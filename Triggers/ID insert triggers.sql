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

CREATE OR REPLACE TRIGGER trg_error_log
  BEFORE INSERT ON error_log
  FOR EACH ROW
  WHEN (new.err_id IS NULL)
BEGIN
  :new.err_id := seq_error_log.nextval;
END;
/
