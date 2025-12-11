CREATE OR REPLACE TRIGGER trg_categories
  BEFORE INSERT ON categories
  FOR EACH ROW
  WHEN (new.category_id IS NULL)
BEGIN
  :new.category_id := seq_categories.nextval;
END;
/

CREATE OR REPLACE TRIGGER trg_cars
  BEFORE INSERT ON cars
  FOR EACH ROW
  WHEN (new.car_id IS NULL)
BEGIN
  :new.car_id := seq_cars.nextval;
END;
/

CREATE OR REPLACE TRIGGER trg_customers
  BEFORE INSERT ON customers
  FOR EACH ROW
  WHEN (new.customer_id IS NULL)
BEGIN
  :new.customer_id := seq_customers.nextval;
END;
/

CREATE OR REPLACE TRIGGER trg_rentals
  BEFORE INSERT ON rentals
  FOR EACH ROW
  WHEN (new.rental_id IS NULL)
BEGIN
  :new.rental_id := seq_rentals.nextval;
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
