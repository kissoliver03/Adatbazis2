CREATE OR REPLACE PACKAGE pkg_rentals IS

  PROCEDURE list_cars_by_category(p_car_category IN VARCHAR2);

  PROCEDURE calculate_rental_fee;

  PROCEDURE new_rental(p_car_id    IN NUMBER
                      ,p_from_date IN VARCHAR2
                      ,p_to_date   IN VARCHAR2);

  PROCEDURE return_car(p_car_id IN NUMBER);

END pkg_rentals;
