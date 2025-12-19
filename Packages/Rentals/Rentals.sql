CREATE OR REPLACE PACKAGE pkg_rentals IS

  FUNCTION list_cars_by_category(p_car_category IN VARCHAR2) RETURN ty_car_l;

  PROCEDURE new_rental(p_car_id               IN NUMBER
                      ,p_customer_id          IN NUMBER
                      ,p_from_date            IN VARCHAR2
                      ,p_to_date              IN VARCHAR2
                      ,p_estimated_rental_fee OUT NUMBER);

  PROCEDURE return_car(p_car_id IN NUMBER);

  PROCEDURE check_car_for_rental(p_car_id    IN NUMBER
                                ,p_from_date IN DATE
                                ,p_to_date   IN DATE
                                ,p_is_free   OUT NUMBER);

  PROCEDURE get_customer_rental_history(p_customer_id IN NUMBER
                                       ,p_recordset   OUT SYS_REFCURSOR);

  PROCEDURE get_all_customer_rental_sum(p_recordset OUT SYS_REFCURSOR);
  
  PROCEDURE cancel_reservation(p_reserve_id IN NUMBER);

END pkg_rentals;
/
