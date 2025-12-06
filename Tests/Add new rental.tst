PL/SQL Developer Test script 3.0
6
begin
  -- Call the procedure
  pkg_rentals.new_rental(p_car_id => :p_car_id,
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
24-12-2025
5
p_to_date
1
22-12-2025
5
0
