  --When car is returned then rental fee is calculated--
CREATE OR REPLACE TRIGGER trg_calculate_rental_fee
  BEFORE UPDATE OF return_date ON rental
  FOR EACH ROW
  WHEN (new.return_date IS NOT NULL)
DECLARE

  v_daily_fee           category.daily_fee%TYPE;
  v_is_regular_customer customer.is_regular_customer%TYPE;
  v_days                NUMBER;

BEGIN

  SELECT cat.daily_fee
        ,cus.is_regular_customer
    INTO v_daily_fee
        ,v_is_regular_customer
    FROM category cat
    JOIN car c
      ON cat.category_id = c.category_id
    JOIN customer cus
      ON :new.customer_id = cus.customer_id
   WHERE :new.car_id = c.car_id;

  v_days := trunc(:new.return_date) - trunc(:new.from_date);

  IF v_days = 0
  THEN
    v_days := 1;
  END IF;

  IF v_days < 0
  THEN
    pkg_error_log.error_log(p_error_message => 'From_date is bigger than to_date!',
                            p_error_value   => :new.from_date ||
                                               :new.to_date,
                            p_api           => 'trg_calculate_rental_fee');
  
    raise_application_error(-20010, 'From_date is bigger than to_date!');
  END IF;

  :new.rental_fee := v_days * v_daily_fee * (CASE
                       WHEN v_is_regular_customer = 1 THEN
                        0.8
                       ELSE
                        1
                     END);
  dbms_output.put_line(:new.rental_fee);

EXCEPTION
  WHEN OTHERS THEN
    pkg_error_log.error_log(p_error_message => 'Error occured!',
                            p_error_value   => '',
                            p_api           => 'trg_calculate_rental_fee');
  
END;
