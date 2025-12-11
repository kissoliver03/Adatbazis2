CREATE OR REPLACE PACKAGE BODY pkg_rentals IS

  PROCEDURE list_cars_by_category(p_car_category IN VARCHAR2) IS
    TYPE ty_car_list_type IS TABLE OF vw_available_cars%ROWTYPE;
    lv_car_list ty_car_list_type;
  
  BEGIN
    SELECT *
      BULK COLLECT
      INTO lv_car_list
      FROM vw_available_cars vw
     WHERE upper(vw.category) = upper(p_car_category);
  
    IF lv_car_list.count = 0
    THEN
      pkg_error_log.error_log(p_error_message => 'No data found in this category!',
                              p_error_value   => p_car_category,
                              p_api           => 'list_cars_by_category');
                              
      raise_application_error(-20030, 'No car was found in this category!');
    END IF;
  
    FOR i IN 1 .. lv_car_list.count
    LOOP
      dbms_output.put_line('Manufacturer: ' || lv_car_list(i).manufacturer ||
                           ', Model: ' || lv_car_list(i).model ||
                           ', Mileage: ' || lv_car_list(i).mileage ||
                           ', Daily fee: ' || lv_car_list(i).daily_fee);
    
    END LOOP;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_error_log.error_log(p_error_message => 'No data found in this category!',
                              p_error_value   => p_car_category,
                              p_api           => 'list_cars_by_category');
    
      raise_application_error(-20030, 'No car was found in this category!');
    
    WHEN OTHERS THEN
      pkg_error_log.error_log(p_error_message => 'Error occured!',
                              p_error_value   => p_car_category,
                              p_api           => 'list_cars_by_category');
    
      dbms_output.put_line('Error occured!' || SQLERRM);
      raise;
    
  END list_cars_by_category;
  ----------------------------------------------------------------------
  PROCEDURE calculate_rental_fee IS
  BEGIN
    UPDATE rentals r
       SET r.rental_fee =
           (SELECT (r_inner.return_date - r_inner.from_date) * cat.daily_fee * CASE
                     WHEN cus.is_regular_customer = 1 THEN
                      0.8
                     ELSE
                      1
                   END
              FROM rentals r_inner
              JOIN cars c
                ON r_inner.car_id = c.car_id
              JOIN categories cat
                ON c.category_id = cat.category_id
              JOIN customers cus
                ON r_inner.customer_id = cus.customer_id
             WHERE r_inner.rental_id = r.rental_id)
     WHERE r.return_date IS NOT NULL;
  
  EXCEPTION
    WHEN OTHERS THEN
      pkg_error_log.error_log(p_error_message => 'Error occured!',
                              p_error_value   => '',
                              p_api           => 'calculate_rental_fee');
    
      dbms_output.put_line('Error occured!' || SQLERRM);
      raise;
    
  END calculate_rental_fee;
  ----------------------------------------------------------------------
  PROCEDURE new_rental(p_car_id    IN NUMBER
                      ,p_from_date IN VARCHAR2
                      ,p_to_date   IN VARCHAR2) IS
  
    v_car_status cars.status%TYPE;
  
  BEGIN
  
    SELECT c.status
      INTO v_car_status
      FROM cars c
     WHERE c.car_id = p_car_id;
  
    IF v_car_status = 'AVAILABLE'
    THEN
      INSERT INTO rentals
        (rental_id
        ,car_id
        ,customer_id
        ,from_date
        ,to_date)
      VALUES
        (seq_rentals.nextval
        ,p_car_id
        ,10002 --Fix dummy data
        ,to_date(p_from_date, 'dd-mm-yyyy')
        ,to_date(p_to_date, 'dd-mm-yyyy'));
    
      IF SYSDATE < to_date(p_from_date, 'dd-mm-yyyy')
      THEN
        UPDATE cars SET status = 'RESERVED' WHERE car_id = p_car_id;
      ELSE
        UPDATE cars SET status = 'RENTED' WHERE car_id = p_car_id;
      END IF;
    
      IF to_date(p_from_date, 'dd-mm-yyyy') >
         to_date(p_to_date, 'dd-mm-yyyy')
      THEN
        pkg_error_log.error_log(p_error_message => 'The end of rental cannot be earlier than its beginning!',
                              p_error_value   => p_to_date,
                              p_api           => 'new_rental');
                              
        raise_application_error(-20010, 'From_date is bigger than to_date!');
      END IF;
    
    ELSE
      pkg_error_log.error_log(p_error_message => 'The selected car is not available!',
                              p_error_value   => p_car_id,
                              p_api           => 'new_rental');
                              
      raise_application_error (-20000, 'The selected car is not available!');
    
    END IF;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_error_log.error_log(p_error_message => 'The selected car ID is not valid!',
                              p_error_value   => p_car_id,
                              p_api           => 'new_rental');
    
      raise_application_error(-20030, 'No car was found with this ID!');
    
  END new_rental;
  ----------------------------------------------------------------------
  
  PROCEDURE return_car(p_car_id IN NUMBER) IS
  BEGIN
  
    UPDATE rentals
       SET return_date = SYSDATE
     WHERE rental_id = (SELECT r.rental_id
                          FROM rentals r
                          JOIN cars c
                            ON r.car_id = c.car_id
                         WHERE r.car_id = p_car_id
                           AND r.return_date IS NULL
                           AND c.status = 'RENTED');
  
    IF SQL%ROWCOUNT = 0
    THEN
      raise_application_error(-20020, 'No car is rented with this ID');
    END IF;
  
    UPDATE cars SET status = 'AVAILABLE' WHERE car_id = p_car_id;
  
  END return_car;

END pkg_rentals;
/
