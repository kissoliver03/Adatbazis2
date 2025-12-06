CREATE OR REPLACE PACKAGE pkg_cars AS

  PROCEDURE new_rental(p_car_id    IN NUMBER
                      ,p_from_date IN varchar2
                      ,p_to_date   IN varchar2);

  car_not_available EXCEPTION;

END pkg_cars;
