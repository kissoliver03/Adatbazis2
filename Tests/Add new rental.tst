PL/SQL Developer Test script 3.0
9
--Date format must be: dd/mm/yyyy
begin
  -- Call the procedure
  pkg_rentals.new_rental(p_car_id => :p_car_id,
                         p_customer_id => :p_customer_id,
                         p_from_date => to_date(:p_from_date, 'dd/mm/yyyy'),
                         p_to_date => to_date(:p_to_date, 'dd/mm/yyyy'),
                         p_estimated_rental_fee => :p_estimated_rental_fee);
end;
5
p_car_id
1
10002
4
p_customer_id
1
10000
4
p_from_date
1
19/12/2025
5
p_to_date
1
21/12/2025
5
p_estimated_rental_fee
1
30000
4
0
