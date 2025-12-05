CREATE OR REPLACE PACKAGE BODY pkg_rentals IS

  PROCEDURE list_cars_by_category(p_car_category IN VARCHAR2) IS
    TYPE ty_car_list_type IS TABLE OF vw_available_cars%ROWTYPE;
    lv_car_list ty_car_list_type;
  
  BEGIN
    SELECT *
      BULK COLLECT
      INTO lv_car_list
      FROM vw_available_cars vw
     WHERE upper(vw.category) = upper(p_car_category);
  
    IF lv_car_list.count = 0
    THEN
      RAISE no_data_found;
    END IF;
  
    FOR i IN 1 .. lv_car_list.count
    LOOP
      dbms_output.put_line('Manufacturer: ' || lv_car_list(i).manufacturer ||
                           ', Model: ' || lv_car_list(i).model ||
                           ', Mileage: ' || lv_car_list(i).mileage ||
                           ', Daily fee: ' || lv_car_list(i).daily_fee);
    
    END LOOP;
  
  EXCEPTION
    WHEN no_data_found THEN
      dbms_output.put_line('No data found in this category: ' ||
                           p_car_category);
      RAISE;
    
    WHEN OTHERS THEN
      dbms_output.put_line('Error occured!' || SQLERRM);
    
  END list_cars_by_category;
END pkg_rentals;
/
