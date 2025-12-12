PL/SQL Developer Test script 3.0
8
--date format must be: dd-mm-yyyy
begin
  -- Call the procedure
  pkg_rentals.new_rental(p_car_id => :p_car_id,
                         p_customer_id => :p_customer_id,
                         p_from_date => :p_from_date,
                         p_to_date => :p_to_date);
end;
4
p_car_id
1
10000
4
p_customer_id
1
10000
4
p_from_date
1
12/12/2025
5
p_to_date
1
15/12/2025
5
0
