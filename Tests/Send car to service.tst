PL/SQL Developer Test script 3.0
9
--Date format must be: dd/mm/yyyy
begin
  -- Call the procedure
  pkg_service.send_car_to_service(p_car_id => :p_car_id,
                                  p_from_date => to_date(:p_from_date, 'dd/mm/yyyy'),
                                  p_to_date => to_date(:p_to_date, 'dd/mm/yyyy'),
                                  p_description => :p_description,
                                  p_service_fee => :p_service_fee);
end;
5
p_car_id
1
10000
4
p_from_date
1
19/12/2025
5
p_to_date
1
25/12/2025
5
p_description
1
Kerékcsere
5
p_service_fee
1
30000
4
0
