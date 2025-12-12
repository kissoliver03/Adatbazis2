CREATE OR REPLACE PACKAGE pkg_rentals IS

  FUNCTION list_cars_by_category(p_car_category IN VARCHAR2)
    RETURN ty_car_l;

  PROCEDURE new_rental(p_car_id      IN NUMBER
                      ,p_customer_id IN NUMBER
                      ,p_from_date   IN VARCHAR2
                      ,p_to_date     IN VARCHAR2);

  PROCEDURE return_car(p_car_id IN NUMBER);

END pkg_rentals;
/
