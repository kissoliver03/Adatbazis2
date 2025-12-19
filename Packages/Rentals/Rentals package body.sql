CREATE OR REPLACE PACKAGE BODY pkg_rentals IS

  FUNCTION list_cars_by_category(p_car_category IN VARCHAR2) RETURN ty_car_l IS
  
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
  PROCEDURE new_rental(p_car_id               IN NUMBER
                      ,p_customer_id          IN NUMBER
                      ,p_from_date            IN VARCHAR2
                      ,p_to_date              IN VARCHAR2
                      ,p_estimated_rental_fee OUT NUMBER) IS
  
    v_car_status  car.status%TYPE;
    v_customer_id customer.customer_id%TYPE;
    v_days        NUMBER;
    v_daily_fee   NUMBER;
  
  BEGIN
  
    BEGIN
      SELECT c.status
            ,cat.daily_fee
        INTO v_car_status
            ,v_daily_fee
        FROM car c
        JOIN category cat
          ON c.category_id = cat.category_id
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
    
      IF to_date(SYSDATE, 'dd/mm/yyyy') <
         to_date(p_from_date, 'dd-mm-yyyy')
      THEN
        UPDATE car SET status = 'RESERVED' WHERE car_id = p_car_id;
      
        INSERT INTO reserve
          (customer_id
          ,car_id
          ,from_date
          ,to_date)
        VALUES
          (p_customer_id
          ,p_car_id
          ,to_date(p_from_date, 'dd-mm-yyyy')
          ,to_date(p_to_date, 'dd-mm-yyyy'));
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
  
    v_days                 := trunc(to_date(p_to_date, 'dd/mm/yyyy')) -
                              trunc(to_date(p_from_date, 'dd/mm/yyyy'));
    p_estimated_rental_fee := v_days * v_daily_fee;
  
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
  ----------------------------------------------------------------------

  PROCEDURE check_car_for_rental(p_car_id    IN NUMBER
                                ,p_from_date IN DATE
                                ,p_to_date   IN DATE
                                ,p_is_free   OUT NUMBER) IS
    v_count     car.car_id%TYPE;
    v_conflicts NUMBER;
  BEGIN
  
    BEGIN
      SELECT car_id INTO v_count FROM car WHERE car_id = p_car_id;
    EXCEPTION
      WHEN no_data_found THEN
        RAISE pkg_exceptions.no_car_found;
    END;
  
    IF to_date(p_from_date, 'dd-mm-yyyy') >
       to_date(p_to_date, 'dd-mm-yyyy')
    THEN
      RAISE pkg_exceptions.to_date_bigger_than_from_date;
    END IF;
  
    SELECT COUNT(*)
      INTO v_conflicts
      FROM (SELECT from_date
                  ,to_date
              FROM rental
             WHERE car_id = p_car_id
               AND return_date IS NULL
            UNION ALL
            SELECT from_date
                  ,to_date
              FROM reserve
             WHERE car_id = p_car_id
            UNION ALL
            SELECT from_date
                  ,to_date
              FROM service_log
             WHERE car_id = p_car_id)
     WHERE p_from_date <= to_date
       AND p_to_date >= from_date;
  
    IF v_conflicts = 0
    THEN
      p_is_free := 1;
    ELSE
      p_is_free := 0;
    END IF;
  
  EXCEPTION
    WHEN pkg_exceptions.no_car_found THEN
      pkg_error_log.error_log(p_error_message => 'No car was found witht the given ID!',
                              p_error_value   => p_car_id,
                              p_api           => 'check_car_for_rental');
    
      raise_application_error(-20030,
                              'No car was found witht the given ID!');
    
    WHEN pkg_exceptions.to_date_bigger_than_from_date THEN
      pkg_error_log.error_log(p_error_message => 'The end of rental cannot be earlier than its beginning!',
                              p_error_value   => p_to_date,
                              p_api           => 'check_car_for_rental');
    
      raise_application_error(-20010, 'From_date is bigger than to_date!');
    
  END check_car_for_rental;
  ---------------------------------------------------------------------------------------

  PROCEDURE get_customer_rental_history(p_customer_id IN NUMBER
                                       ,p_recordset   OUT SYS_REFCURSOR) IS
    v_dummy NUMBER;
  BEGIN
  
    BEGIN
      SELECT 1
        INTO v_dummy
        FROM customer
       WHERE customer_id = p_customer_id;
    EXCEPTION
      WHEN no_data_found THEN
        RAISE pkg_exceptions.customer_not_valid;
    END;
  
    OPEN p_recordset FOR
      SELECT r.rental_id
            ,r.from_date
            ,r.to_date
            ,r.return_date
            ,r.rental_fee
            ,c.car_manufacturer
            ,c.car_model
        FROM rental r
        JOIN car c
          ON r.car_id = c.car_id
       WHERE r.customer_id = p_customer_id
       ORDER BY r.from_date DESC;
  
  EXCEPTION
    WHEN pkg_exceptions.customer_not_valid THEN
      pkg_error_log.error_log(p_error_message => 'There are no customer with the given ID!',
                              p_error_value   => p_customer_id,
                              p_api           => 'get_customer_rental_history');
    
      raise_application_error(-20040,
                              'There are no customer with the given ID!');
    WHEN OTHERS THEN
      pkg_error_log.error_log(p_error_message => SQLERRM,
                              p_error_value   => 'Customer_ID: ' ||
                                                 p_customer_id,
                              p_api           => 'get_customer_rental_history');
      RAISE;
  END get_customer_rental_history;
  ------------------------------------------------------------------------------------

  PROCEDURE get_all_customer_rental_sum(p_recordset OUT SYS_REFCURSOR) IS
  BEGIN
  
    OPEN p_recordset FOR
      SELECT cus.customer_id
            ,cus.first_name
            ,cus.last_name
            ,cus.e_mail
            ,COUNT(r.rental_id) AS total_rentals
            ,nvl(SUM(r.rental_fee), 0) AS total_spent
        FROM customer cus
        JOIN rental r
          ON cus.customer_id = r.customer_id
       GROUP BY cus.customer_id
               ,cus.first_name
               ,cus.last_name
               ,cus.e_mail
       ORDER BY total_spent DESC;
  
  EXCEPTION
    WHEN OTHERS THEN
      pkg_error_log.error_log(p_error_message => SQLERRM,
                              p_error_value   => 'Summary report error',
                              p_api           => 'get_customer_rental_summary');
      RAISE;
  END get_all_customer_rental_sum;
  ----------------------------------------------------------------------------------

  PROCEDURE cancel_reservation(p_reserve_id IN NUMBER) IS
    v_car_id      reserve.car_id%TYPE;
    v_customer_id reserve.customer_id%TYPE;
    v_from_date   reserve.from_date%TYPE;
    v_to_date     reserve.to_date%TYPE;
  
  BEGIN
    BEGIN
      SELECT res.car_id
            ,res.customer_id
            ,res.from_date
            ,res.to_date
        INTO v_car_id
            ,v_customer_id
            ,v_from_date
            ,v_to_date
        FROM reserve res
       WHERE res.reserve_id = p_reserve_id;
    
    EXCEPTION
      WHEN no_data_found THEN
        pkg_error_log.error_log(p_error_message => 'No reservation found with the given ID',
                                p_error_value   => p_reserve_id,
                                p_api           => 'cancel_reservation');
        RAISE;
    END;
  
    DELETE FROM reserve WHERE reserve_id = p_reserve_id;
  
    DELETE FROM rental
     WHERE car_id = v_car_id
       AND customer_id = v_customer_id
       AND from_date = v_from_date
       AND to_date = v_to_date;
  
    UPDATE car SET status = 'AVAILABLE' WHERE car_id = v_car_id;
  END cancel_reservation;

END pkg_rentals;
/
