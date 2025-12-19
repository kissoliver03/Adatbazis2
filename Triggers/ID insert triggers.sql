CREATE OR REPLACE TRIGGER trg_category
  BEFORE INSERT OR UPDATE ON category
  FOR EACH ROW
BEGIN
  IF (inserting)
  THEN
    IF (:new.category_id IS NULL)
    THEN
      :new.category_id := seq_category.nextval;
    END IF;
    :new.created_on := SYSDATE;
    :new.last_mod   := SYSDATE;
    :new.dml_flag   := 'I';
    :new.version    := 1;
    :new.mod_user   := sys_context(namespace => 'USERENV',
                                   attribute => 'OS_USER');
  ELSE
    :new.last_mod := SYSDATE;
    :new.dml_flag := 'U';
    :new.version  := :old.version + 1;
    :new.mod_user := sys_context(namespace => 'USERENV',
                                 attribute => 'OS_USER');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_car
  BEFORE INSERT OR UPDATE ON car
  FOR EACH ROW
BEGIN
  IF (inserting)
  THEN
    IF (:new.car_id IS NULL)
    THEN
      :new.car_id := seq_car.nextval;
    END IF;
    :new.created_on := SYSDATE;
    :new.last_mod   := SYSDATE;
    :new.dml_flag   := 'I';
    :new.version    := 1;
    :new.mod_user   := sys_context(namespace => 'USERENV',
                                   attribute => 'OS_USER');
  ELSE
    :new.last_mod := SYSDATE;
    :new.dml_flag := 'U';
    :new.version  := :old.version + 1;
    :new.mod_user := sys_context(namespace => 'USERENV',
                                 attribute => 'OS_USER');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_customer
  BEFORE INSERT OR UPDATE ON customer
  FOR EACH ROW
BEGIN
  IF (inserting)
  THEN
    IF (:new.customer_id IS NULL)
    THEN
      :new.customer_id := seq_customer.nextval;
    END IF;
    :new.created_on := SYSDATE;
    :new.last_mod   := SYSDATE;
    :new.dml_flag   := 'I';
    :new.version    := 1;
    :new.mod_user   := sys_context(namespace => 'USERENV',
                                   attribute => 'OS_USER');
  ELSE
    :new.last_mod := SYSDATE;
    :new.dml_flag := 'U';
    :new.version  := :old.version + 1;
    :new.mod_user := sys_context(namespace => 'USERENV',
                                 attribute => 'OS_USER');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_rental
  BEFORE INSERT OR UPDATE ON rental
  FOR EACH ROW
BEGIN
  IF (inserting)
  THEN
    IF (:new.rental_id IS NULL)
    THEN
      :new.rental_id := seq_rental.nextval;
    END IF;
    :new.created_on := SYSDATE;
    :new.last_mod   := SYSDATE;
    :new.dml_flag   := 'I';
    :new.version    := 1;
    :new.mod_user   := sys_context(namespace => 'USERENV',
                                   attribute => 'OS_USER');
  ELSE
    :new.last_mod := SYSDATE;
    :new.dml_flag := 'U';
    :new.version  := :old.version + 1;
    :new.mod_user := sys_context(namespace => 'USERENV',
                                 attribute => 'OS_USER');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_service_log
  BEFORE INSERT OR UPDATE ON service_log
  FOR EACH ROW
BEGIN
  IF (inserting)
  THEN
    IF (:new.service_id IS NULL)
    THEN
      :new.service_id := seq_service_log.nextval;
    END IF;
    :new.created_on := SYSDATE;
    :new.last_mod   := SYSDATE;
    :new.dml_flag   := 'I';
    :new.version    := 1;
    :new.mod_user   := sys_context(namespace => 'USERENV',
                                   attribute => 'OS_USER');
  ELSE
    :new.last_mod := SYSDATE;
    :new.dml_flag := 'U';
    :new.version  := :old.version + 1;
    :new.mod_user := sys_context(namespace => 'USERENV',
                                 attribute => 'OS_USER');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_reserve
  BEFORE INSERT OR UPDATE ON reserve
  FOR EACH ROW
BEGIN
  IF (inserting)
  THEN
    IF (:new.reserve_id IS NULL)
    THEN
      :new.reserve_id := seq_reserve.nextval;
    END IF;
    :new.created_on := SYSDATE;
    :new.last_mod   := SYSDATE;
    :new.dml_flag   := 'I';
    :new.version    := 1;
    :new.mod_user   := sys_context(namespace => 'USERENV',
                                   attribute => 'OS_USER');
  ELSE
    :new.last_mod := SYSDATE;
    :new.dml_flag := 'U';
    :new.version  := :old.version + 1;
    :new.mod_user := sys_context(namespace => 'USERENV',
                                 attribute => 'OS_USER');
  END IF;
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

--History table triggers

CREATE OR REPLACE TRIGGER trg_category_h
  AFTER INSERT OR UPDATE OR DELETE ON category
  FOR EACH ROW
BEGIN
  IF (deleting)
  THEN
    INSERT INTO category_h
      (category_id
      ,category_name
      ,daily_fee
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:old.category_id
      ,:old.category_name
      ,:old.daily_fee
      ,sys_context('USERENV', 'OS_USER')
      ,:old.created_on
      ,SYSDATE
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO category_h
      (category_id
      ,category_name
      ,daily_fee
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:new.category_id
      ,:new.category_name
      ,:new.daily_fee
      ,:new.mod_user
      ,:new.created_on
      ,:new.last_mod
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_car_h
  AFTER INSERT OR UPDATE OR DELETE on car
  FOR EACH ROW
BEGIN
  IF (deleting)
  THEN
    INSERT INTO car_h
      (car_id
      ,license_plate
      ,category_id
      ,car_model
      ,car_manufacturer
      ,mileage
      ,status
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:old.car_id
      ,:old.license_plate
      ,:old.category_id
      ,:old.car_model
      ,:old.car_manufacturer
      ,:old.mileage
      ,:old.status
      ,sys_context('USERENV', 'OS_USER')
      ,:old.created_on
      ,SYSDATE
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO car_h
      (car_id
      ,license_plate
      ,category_id
      ,car_model
      ,car_manufacturer
      ,mileage
      ,status
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:new.car_id
      ,:new.license_plate
      ,:new.category_id
      ,:new.car_model
      ,:new.car_manufacturer
      ,:new.mileage
      ,:new.status
      ,:new.mod_user
      ,:new.created_on
      ,:new.last_mod
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_customer_h
  AFTER INSERT OR UPDATE OR DELETE on customer
  FOR EACH ROW
BEGIN
  IF (deleting)
  THEN
    INSERT INTO customer_h
      (customer_id
      ,first_name
      ,last_name
      ,e_mail
      ,is_regular_customer
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:old.customer_id
      ,:old.first_name
      ,:old.last_name
      ,:old.e_mail
      ,:old.is_regular_customer
      ,sys_context('USERENV', 'OS_USER')
      ,:old.created_on
      ,SYSDATE
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO customer_h
      (customer_id
      ,first_name
      ,last_name
      ,e_mail
      ,is_regular_customer
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:new.customer_id
      ,:new.first_name
      ,:new.last_name
      ,:new.e_mail
      ,:new.is_regular_customer
      ,:new.mod_user
      ,:new.created_on
      ,:new.last_mod
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_rental_h
  AFTER INSERT OR UPDATE OR DELETE ON rental
  FOR EACH ROW
BEGIN
  IF (deleting)
  THEN
    INSERT INTO rental_h
      (rental_id
      ,car_id
      ,customer_id
      ,from_date
      ,to_date
      ,return_date
      ,rental_fee
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:old.rental_id
      ,:old.car_id
      ,:old.customer_id
      ,:old.from_date
      ,:old.to_date
      ,:old.return_date
      ,:old.rental_fee
      ,sys_context('USERENV', 'OS_USER')
      ,:old.created_on
      ,SYSDATE
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO rental_h
      (rental_id
      ,car_id
      ,customer_id
      ,from_date
      ,to_date
      ,return_date
      ,rental_fee
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:new.rental_id
      ,:new.car_id
      ,:new.customer_id
      ,:new.from_date
      ,:new.to_date
      ,:new.return_date
      ,:new.rental_fee
      ,:new.mod_user
      ,:new.created_on
      ,:new.last_mod
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_service_log_h
  AFTER INSERT OR UPDATE OR DELETE ON service_log
  FOR EACH ROW
BEGIN
  IF (deleting)
  THEN
    INSERT INTO service_log_h
      (service_id
      ,car_id
      ,from_date
      ,to_date
      ,service_description
      ,service_fee
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:old.service_id
      ,:old.car_id
      ,:old.from_date
      ,:old.to_date
      ,:old.service_description
      ,:old.service_fee
      ,sys_context('USERENV', 'OS_USER')
      ,:old.created_on
      ,SYSDATE
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO service_log_h
      (service_id
      ,car_id
      ,from_date
      ,to_date
      ,service_description
      ,service_fee
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:new.service_id
      ,:new.car_id
      ,:new.from_date
      ,:new.to_date
      ,:new.service_description
      ,:new.service_fee
      ,:new.mod_user
      ,:new.created_on
      ,:new.last_mod
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_reserve_h
  AFTER INSERT OR UPDATE OR DELETE ON reserve
  FOR EACH ROW
BEGIN
  IF (deleting)
  THEN
    INSERT INTO reserve_h
      (reserve_id
      ,customer_id
      ,car_id
      ,from_date
      ,to_date
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:old.reserve_id
      ,:old.customer_id
      ,:old.car_id
      ,:old.from_date
      ,:old.to_date
      ,sys_context('USERENV', 'OS_USER')
      ,:old.created_on
      ,SYSDATE
      ,'D'
      ,:old.version + 1);
  ELSE
    INSERT INTO reserve_h
      (reserve_id
      ,customer_id
      ,car_id
      ,from_date
      ,to_date
      ,mod_user
      ,created_on
      ,last_mod
      ,dml_flag
      ,version)
    VALUES
      (:new.reserve_id
      ,:new.customer_id
      ,:new.car_id
      ,:new.from_date
      ,:new.to_date
      ,:new.mod_user
      ,:new.created_on
      ,:new.last_mod
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/
