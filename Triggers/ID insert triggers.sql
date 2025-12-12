CREATE OR REPLACE TRIGGER trg_category
  BEFORE INSERT ON category
  FOR EACH ROW
  WHEN (new.category_id IS NULL)
BEGIN
  :new.category_id := seq_category.nextval;
END;
/

CREATE OR REPLACE TRIGGER trg_car
  BEFORE INSERT ON car
  FOR EACH ROW
  WHEN (new.car_id IS NULL)
BEGIN
  :new.car_id := seq_car.nextval;
END;
/

CREATE OR REPLACE TRIGGER trg_customer
  BEFORE INSERT ON customer
  FOR EACH ROW
  WHEN (new.customer_id IS NULL)
BEGIN
  :new.customer_id := seq_customer.nextval;
END;
/

CREATE OR REPLACE TRIGGER trg_rental
  BEFORE INSERT ON rental
  FOR EACH ROW
  WHEN (new.rental_id IS NULL)
BEGIN
  :new.rental_id := seq_rental.nextval;
END;
/

CREATE OR REPLACE TRIGGER trg_service_log
  BEFORE INSERT ON service_log
  FOR EACH ROW
  WHEN (new.service_id IS NULL)
BEGIN
  :new.service_id := seq_service_log.nextval;
END;
/

CREATE OR REPLACE TRIGGER trg_error_log
  BEFORE INSERT ON error_log
  FOR EACH ROW
  WHEN (new.err_id IS NULL)
BEGIN
  :new.err_id := seq_error_log.nextval;
END;
/
