PL/SQL Developer Test script 3.0
5
begin
  -- Call the procedure
  pkg_rentals.get_customer_rental_history(p_customer_id => :p_customer_id,
                                          p_recordset => :p_recordset);
end;
2
p_customer_id
1
10000
4
p_recordset
1
<Cursor>
116
0
