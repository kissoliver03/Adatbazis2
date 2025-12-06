CREATE OR REPLACE PACKAGE BODY pkg_cars AS

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
    
      IF sysdate < to_date(p_from_date, 'dd-mm-yyyy')
      THEN
        UPDATE cars SET status = 'RESERVED' WHERE car_id = p_car_id;
      ELSE
        UPDATE cars SET status = 'RENTED' WHERE car_id = p_car_id;
      END IF;
      
       ELSE RAISE car_not_available;
    
    END IF;
  
  EXCEPTION
    WHEN car_not_available THEN
      dbms_output.put_line('The selected car is not available! Current status: ' ||
                           v_car_status);
      RAISE;
    
  END new_rental;

END pkg_cars;
/
