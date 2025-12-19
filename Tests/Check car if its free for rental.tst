PL/SQL Developer Test script 3.0
8
--Date format must be: dd/mm/yyyy
begin
  -- Call the procedure
  pkg_rentals.check_car_for_rental(p_car_id => :p_car_id,
                                   p_from_date => to_date(:p_from_date, 'dd/mm/yyyy'),
                                   p_to_date => to_date(:p_to_date, 'dd/mm/yyyy'),
                                   p_is_free => :p_is_free);
end;
4
p_car_id
1
10000
4
p_from_date
1
20/12/2025
5
p_to_date
1
25/12/2025
5
p_is_free
1
0
4
0
