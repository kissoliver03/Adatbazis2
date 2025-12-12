PL/SQL Developer Test script 3.0
10
DECLARE
  -- Non-scalar parameters require additional processing 
  RESULT ty_car_l;
BEGIN
  -- Call the function
  RESULT := pkg_rentals.list_cars_by_category(p_car_category => :p_car_category);

  OPEN :cur FOR
    SELECT * FROM TABLE(RESULT);
END;
2
p_car_category
1
Premium
5
cur
1
<Cursor>
116
0
