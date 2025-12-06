CREATE OR REPLACE PACKAGE pkg_exceptions IS

  car_not_available EXCEPTION;
  PRAGMA EXCEPTION_INIT(car_not_available, -20000);

  to_date_bigger_than_from_date EXCEPTION;
  PRAGMA EXCEPTION_INIT(to_date_bigger_than_from_date, -20010);

END pkg_exceptions;
