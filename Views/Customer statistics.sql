create or replace view vw_customer_statistic as
SELECT cus.first_name || ' ' || cus.last_name AS NAME
      ,c.car_manufacturer AS manufacturer
      ,c.car_model AS model
      ,r.from_date
      ,r.to_date
      ,COUNT(*) over(PARTITION BY r.car_id ORDER BY r.from_date) AS rental_count_for_car
  FROM rental r
  JOIN customer cus
    ON r.customer_id = cus.customer_id
  JOIN car c
    ON r.car_id = c.car_id
 ORDER BY r.car_id
         ,r.from_date;
