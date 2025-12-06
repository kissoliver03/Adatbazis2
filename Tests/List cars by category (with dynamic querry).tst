PL/SQL Developer Test script 3.0
10
declare
  -- Non-scalar parameters require additional processing 
  result ty_car_l;
begin
  -- Call the function
  result := list_cars_by_category_dynamic(p_car_category => :p_car_category);
  
  open :cur for 
  select * from table(result);
end;
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
