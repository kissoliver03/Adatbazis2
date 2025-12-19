CREATE OR REPLACE PACKAGE BODY pkg_service IS

  PROCEDURE send_car_to_service(p_car_id      IN NUMBER
                               ,p_from_date   IN DATE
                               ,p_to_date     IN DATE
                               ,p_description IN VARCHAR2
                               ,p_service_fee IN NUMBER) IS
  
    v_current_status car.status%TYPE;
  BEGIN
  
    BEGIN
      SELECT status INTO v_current_status FROM car WHERE car_id = p_car_id;
    
    EXCEPTION
      WHEN no_data_found THEN
        RAISE pkg_exceptions.no_car_found;
    END;
  
    IF p_to_date < p_from_date
    THEN
      RAISE pkg_exceptions.to_date_bigger_than_from_date;
    END IF;
  
    IF v_current_status = 'MAINTENANCE'
    THEN
      RAISE pkg_exceptions.car_not_available;
    END IF;
  
    INSERT INTO service_log
      (car_id
      ,from_date
      ,to_date
      ,service_description
      ,service_fee)
    VALUES
      (p_car_id
      ,p_from_date
      ,p_to_date
      ,p_description
      ,p_service_fee);
  
    UPDATE car SET status = 'MAINTENANCE' WHERE car_id = p_car_id;
  
  EXCEPTION
    WHEN pkg_exceptions.no_car_found THEN
      pkg_error_log.error_log(p_error_message => 'Error! No car was found with the given ID.',
                              p_error_value   => p_car_id,
                              p_api           => 'send_car_to_service');
      raise_application_error(-20030, 'No car was found with the given ID!');
    
    WHEN pkg_exceptions.to_date_bigger_than_from_date THEN
      pkg_error_log.error_log(p_error_message => 'Error! From_date is bigger than to_date!',
                              p_error_value   => p_to_date,
                              p_api           => 'send_car_to_service');
      raise_application_error(-20010, 'From_date is bigger than to_date!');
    
    WHEN pkg_exceptions.car_not_available THEN
      pkg_error_log.error_log(p_error_message => 'Error! Car is not available to send to maintenance!',
                              p_error_value   => p_car_id,
                              p_api           => 'send_car_to_service');
      raise_application_error(-20000, 'Car is not available to send to maintenance!');
    
    WHEN OTHERS THEN
      pkg_error_log.error_log(p_error_message => SQLERRM,
                              p_error_value   => '',
                              p_api           => 'send_car_to_service');
      raise;
    
  END send_car_to_service;

END pkg_service;
/
