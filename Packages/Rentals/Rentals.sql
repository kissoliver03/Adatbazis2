CREATE OR REPLACE PACKAGE pkg_rentals IS

  PROCEDURE list_cars_by_category(p_car_category IN VARCHAR2);

  PROCEDURE calculate_rental_fee;

END pkg_rentals;
