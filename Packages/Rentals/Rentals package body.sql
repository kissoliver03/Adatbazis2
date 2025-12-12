CREATE OR REPLACE PACKAGE BODY pkg_rentals IS

  FUNCTION list_cars_by_category(p_car_category IN VARCHAR2)
    RETURN ty_car_l IS
  
    v_sql  VARCHAR2(4000);
    v_cars ty_car_l;
  
  BEGIN
  
    v_sql := 'select ty_car(vw.category, vw.manufacturer, vw.model, vw.mileage, vw.daily_fee)' ||
             ' from vw_available_cars vw' || ' where 1 = 1';
  
    IF p_car_category IS NOT NULL
    THEN
      v_sql := v_sql || ' AND UPPER(vw.category) = UPPER(:1)';
    END IF;
  
    EXECUTE IMMEDIATE v_sql BULK COLLECT
      INTO v_cars
      USING p_car_category;
  
    RETURN v_cars;
  
  EXCEPTION
    WHEN no_data_found THEN
      pkg_error_log.error_log(p_error_message => 'No data was found in this category!',
                              p_error_value   => p_car_category,
                              p_api           => 'list_cars_by_category_dynamic');
    
      RAISE;
    
    WHEN OTHERS THEN
      pkg_error_log.error_log(p_error_message => SQLERRM,
                              p_error_value   => v_sql,
                              p_api           => 'list_cars_by_category_dynamic');
      RAISE;
    
  END list_cars_by_category;
  ----------------------------------------------------------------------
  PROCEDURE new_rental(p_car_id      IN NUMBER
                      ,p_customer_id IN NUMBER
                      ,p_from_date   IN VARCHAR2
                      ,p_to_date     IN VARCHAR2) IS
  
    v_car_status  car.status%TYPE;
    v_customer_id customer.customer_id%TYPE;
  
  BEGIN
  
    BEGIN
      SELECT c.status
        INTO v_car_status
        FROM car c
       WHERE c.car_id = p_car_id;
    EXCEPTION
      WHEN no_data_found THEN
        RAISE pkg_exceptions.no_car_found;
    END;
  
    BEGIN
      SELECT cus.customer_id
        INTO v_customer_id
        FROM customer cus
       WHERE cus.customer_id = p_customer_id;
    EXCEPTION
      WHEN no_data_found THEN
        RAISE pkg_exceptions.customer_not_valid;
    END;
  
    IF v_car_status = 'AVAILABLE'
    THEN
      INSERT INTO rental
        (car_id
        ,customer_id
        ,from_date
        ,to_date)
      VALUES
        (p_car_id
        ,p_customer_id
        ,to_date(p_from_date, 'dd-mm-yyyy')
        ,to_date(p_to_date, 'dd-mm-yyyy'));
    
      IF SYSDATE < to_date(p_from_date, 'dd-mm-yyyy')
      THEN
        UPDATE car SET status = 'RESERVED' WHERE car_id = p_car_id;
      ELSE
        UPDATE car SET status = 'RENTED' WHERE car_id = p_car_id;
      END IF;
    
      IF to_date(p_from_date, 'dd-mm-yyyy') >
         to_date(p_to_date, 'dd-mm-yyyy')
      THEN
        RAISE pkg_exceptions.to_date_bigger_than_from_date;
      END IF;
    
    ELSE
      RAISE pkg_exceptions.car_not_available;
    END IF;
  
  EXCEPTION
    WHEN pkg_exceptions.no_car_found THEN
      pkg_error_log.error_log(p_error_message => 'The selected car ID is not valid!',
                              p_error_value   => p_car_id,
                              p_api           => 'new_rental');
    
      raise_application_error(-20030, 'No car was found with this ID!');
    
    WHEN pkg_exceptions.to_date_bigger_than_from_date THEN
      pkg_error_log.error_log(p_error_message => 'The end of rental cannot be earlier than its beginning!',
                              p_error_value   => p_to_date,
                              p_api           => 'new_rental');
    
      raise_application_error(-20010, 'From_date is bigger than to_date!');
    
    WHEN pkg_exceptions.car_not_available THEN
      pkg_error_log.error_log(p_error_message => 'The selected car is not available!',
                              p_error_value   => p_car_id,
                              p_api           => 'new_rental');
    
      raise_application_error(-20000, 'The selected car is not available!');
    
    WHEN pkg_exceptions.customer_not_valid THEN
      pkg_error_log.error_log(p_error_message => 'The given customer is not valid!',
                              p_error_value   => p_customer_id,
                              p_api           => 'new_rental');
    
      raise_application_error(-20040, 'The given customer is not valid!');
    
  END new_rental;
  ----------------------------------------------------------------------

  PROCEDURE return_car(p_car_id IN NUMBER) IS
  BEGIN
  
    UPDATE rental
       SET return_date = SYSDATE
     WHERE rental_id = (SELECT r.rental_id
                          FROM rental r
                          JOIN car c
                            ON r.car_id = c.car_id
                         WHERE r.car_id = p_car_id
                           AND r.return_date IS NULL
                           AND c.status = 'RENTED');
  
    IF SQL%ROWCOUNT = 0
    THEN
      pkg_error_log.error_log(p_error_message => 'No car is rented with the given ID!',
                              p_error_value   => p_car_id,
                              p_api           => 'return_car');
    
      RAISE pkg_exceptions.no_car_is_rented_with_id;
    END IF;
  
    UPDATE car SET status = 'AVAILABLE' WHERE car_id = p_car_id;
  
  EXCEPTION
    WHEN pkg_exceptions.no_car_is_rented_with_id THEN
      raise_application_error(-20020, 'No car is rented with this ID');
    
  END return_car;

END pkg_rentals;
/
