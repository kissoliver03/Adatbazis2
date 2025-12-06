PL/SQL Developer Test script 3.0
6
begin
  -- Call the procedure
  pkg_cars.new_rental(p_car_id => :p_car_id,
                      p_from_date => :p_from_date,
                      p_to_date => :p_to_date);
end;
3
p_car_id
1
10000
4
p_from_date
1
07-12-2025
5
p_to_date
1
20-12-2025
5
0
