CREATE OR REPLACE PACKAGE pkg_service IS

  PROCEDURE send_car_to_service(p_car_id      IN NUMBER
                               ,p_from_date   IN DATE
                               ,p_to_date     IN DATE
                               ,p_description IN VARCHAR2
                               ,p_service_fee IN NUMBER);

END pkg_service;
