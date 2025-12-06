  --When car is returned then rental fee is calculated--
  CREATE OR REPLACE TRIGGER trg_calculate_rental_fee
  BEFORE UPDATE OF return_date ON rentals
  FOR EACH ROW
  WHEN (new.return_date IS NOT NULL
       AND old.return_date IS NULL)
DECLARE

  v_daily_fee           categories.daily_fee%TYPE;
  v_is_regular_customer customers.is_regular_customer%TYPE;

BEGIN

  SELECT cat.daily_fee
        ,cus.is_regular_customer
    INTO v_daily_fee
        ,v_is_regular_customer
    FROM categories cat
    JOIN cars c
      ON cat.category_id = c.category_id
    JOIN rentals r
      ON c.car_id = r.car_id
    JOIN customers cus
      ON r.customer_id = cus.customer_id
   WHERE c.car_id = :new.car_id;

  :new.rental_fee := (:new.return_date - :new.from_date) * v_daily_fee *
                     (CASE
                       WHEN v_is_regular_customer = 1 THEN
                        0.8
                       ELSE
                        1
                     END);

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('Error occured: ' || SQLERRM);
  
END;
