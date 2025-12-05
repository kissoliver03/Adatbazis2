CREATE OR REPLACE TYPE ty_car IS OBJECT
(
  category     VARCHAR2(40),
  manufacturer VARCHAR2(40),
  model        VARCHAR2(40),
  mileage      NUMBER,
  daily_fee    NUMBER
)
;

CREATE OR REPLACE TYPE ty_car_l IS TABLE OF ty_car;
