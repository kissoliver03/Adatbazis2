--Car search by category for customers (category, car manufacturer, car_model, milegage, (status = AVAILABLE),  daily fee)
CREATE OR REPLACE view vw_available_cars AS
  SELECT c.car_id           AS car_number
        ,cat.category_name  AS category
        ,c.car_manufacturer AS manufacturer
        ,c.car_model        AS model
        ,c.mileage          AS mileage
        ,cat.daily_fee      AS daily_fee
    FROM car c
    JOIN category cat
      ON c.category_id = cat.category_id
   WHERE c.status = 'AVAILABLE';

