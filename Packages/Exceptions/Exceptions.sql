CREATE OR REPLACE PACKAGE pkg_exceptions IS

  car_not_available EXCEPTION;
  PRAGMA EXCEPTION_INIT(car_not_available, -20000);

  to_date_bigger_than_from_date EXCEPTION;
  PRAGMA EXCEPTION_INIT(to_date_bigger_than_from_date, -20010);

  no_car_is_rented_with_id EXCEPTION;
  PRAGMA EXCEPTION_INIT(no_car_is_rented_with_id, -20020);

  no_car_found EXCEPTION;
  PRAGMA EXCEPTION_INIT(no_car_found, -20030);

END pkg_exceptions;
