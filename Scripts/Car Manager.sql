DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO v_count
    FROM dba_users t
   WHERE t.username = 'CAR_MANAGER';
  IF v_count = 1
  THEN
    EXECUTE IMMEDIATE 'drop user car_manager cascade';
  END IF;
END;
/
create user car_manager identified by 12345678 default tablespace users quota unlimited on users;
grant create session to car_manager;

grant create table to car_manager;
grant create view to car_manager;
grant create procedure to car_manager;
grant create trigger to car_manager;
grant create job to car_manager;
grant create sequence to car_manager;
grant create type to car_manager;

alter session set current_schema = car_manager;




