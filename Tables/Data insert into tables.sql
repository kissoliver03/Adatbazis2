--Loading categories
INSERT INTO category
  (category_name
  ,daily_fee)
VALUES
  ('Premium'
  ,10000);

INSERT INTO category
  (category_name
  ,daily_fee)
VALUES
  ('SUV'
  ,8000);

INSERT INTO category
  (category_name
  ,daily_fee)
VALUES
  ('Van'
  ,15000);

INSERT INTO category
  (category_name
  ,daily_fee)
VALUES
  ('Sedan'
  ,5000);

INSERT INTO category
  (category_name
  ,daily_fee)
VALUES
  ('Sport'
  ,12000);

--Loading cars
INSERT INTO car
  (license_plate
  ,category_id
  ,car_model
  ,car_manufacturer
  ,mileage
  ,status)
VALUES
  ('AUD-001'
  ,1
  ,'A6'
  ,'Audi'
  ,120000
  ,'AVAILABLE');

INSERT INTO car
  (license_plate
  ,category_id
  ,car_model
  ,car_manufacturer
  ,mileage
  ,status)
VALUES
  ('TOY-002'
  ,2
  ,'RAV4'
  ,'Toyota'
  ,45000
  ,'RESERVED');

INSERT INTO car
  (license_plate
  ,category_id
  ,car_model
  ,car_manufacturer
  ,mileage
  ,status)
VALUES
  ('FOR-003'
  ,3
  ,'Transit'
  ,'Ford'
  ,210000
  ,'AVAILABLE');

INSERT INTO car
  (license_plate
  ,category_id
  ,car_model
  ,car_manufacturer
  ,mileage
  ,status)
VALUES
  ('OPE-004'
  ,4
  ,'Astra'
  ,'Opel'
  ,89000
  ,'MAINTENANCE');

INSERT INTO car
  (license_plate
  ,category_id
  ,car_model
  ,car_manufacturer
  ,mileage
  ,status)
VALUES
  ('MUS-005'
  ,5
  ,'Mustang'
  ,'Ford'
  ,15000
  ,'AVAILABLE');

--Loading customers
INSERT INTO customer
  (first_name
  ,last_name
  ,e_mail
  ,is_regular_customer)
VALUES
  ('Nagy'
  ,'Anna'
  ,'nagyanna@gmail.com'
  ,1);

INSERT INTO customer
  (first_name
  ,last_name
  ,e_mail
  ,is_regular_customer)
VALUES
  ('Kiss'
  ,'Peter'
  ,'kisspeter@gmail.com'
  ,0);

INSERT INTO customer
  (first_name
  ,last_name
  ,e_mail
  ,is_regular_customer)
VALUES
  ('Kovacs'
  ,'Eva'
  ,'kovacseva@gmail.com'
  ,0);

INSERT INTO customer
  (first_name
  ,last_name
  ,e_mail
  ,is_regular_customer)
VALUES
  ('Horvath'
  ,'Tamas'
  ,'horvathtamas@gmail.com'
  ,1);

INSERT INTO customer
  (first_name
  ,last_name
  ,e_mail
  ,is_regular_customer)
VALUES
  ('Toth'
  ,'Gabor'
  ,'tothgabor@gmail.com'
  ,0);

--Loading rentals
INSERT INTO rental
  (car_id
  ,customer_id
  ,from_date
  ,to_date
  ,return_date
  ,rental_fee)
VALUES
  (10000
  ,10000
  ,to_date('01-10-2023', 'dd-mm-yyyy')
  ,to_date('05-10-2023', 'dd-mm-yyyy')
  ,to_date('05,10,2023', 'dd-mm-yyyy')
  ,32000);

INSERT INTO rental
  (car_id
  ,customer_id
  ,from_date
  ,to_date
  ,return_date)
VALUES
  (10001
  ,10001
  ,SYSDATE + 2
  ,SYSDATE + 5
  ,NULL);

INSERT INTO rental
  (car_id
  ,customer_id
  ,from_date
  ,to_date
  ,return_date
  ,rental_fee)
VALUES
  (10002
  ,10002
  ,to_date('01-06-2023', 'dd-mm-yyyy')
  ,to_date('06-10-2023', 'dd-mm-yyyy')
  ,to_date('06-10-2023', 'dd-mm-yyyy')
  ,1905000);

INSERT INTO rental
  (car_id
  ,customer_id
  ,from_date
  ,to_date
  ,return_date
  ,rental_fee)
VALUES
  (10003
  ,10003
  ,to_date('11-10-2023', 'dd-mm-yyyy')
  ,to_date('12-10-2023', 'dd-mm-yyyy')
  ,to_date('12-10-2023', 'dd-mm-yyyy')
  ,4000);

INSERT INTO rental
  (car_id
  ,customer_id
  ,from_date
  ,to_date
  ,return_date
  ,rental_fee)
VALUES
  (10004
  ,10004
  ,to_date('01-09-2023', 'dd-mm-yyyy')
  ,to_date('05-09-2023', 'dd-mm-yyyy')
  ,to_date('05-09-2023', 'dd-mm-yyyy')
  ,48000);

--Loading service log
INSERT INTO service_log
  (car_id
  ,from_date
  ,to_date
  ,service_description
  ,service_fee)
VALUES
  (10000
  ,to_date('01-01-2023', 'dd-mm-yyyy')
  ,to_date('07-01-2023', 'dd-mm-yyyy')
  ,'Olajcsere'
  ,15000);

INSERT INTO service_log
  (car_id
  ,from_date
  ,to_date
  ,service_description
  ,service_fee)
VALUES
  (10001
  ,to_date('01-04-2021', 'dd-mm-yyyy')
  ,to_date('05-04-2021', 'dd-mm-yyyy')
  ,'Olajcsere'
  ,12000);

INSERT INTO service_log
  (car_id
  ,from_date
  ,to_date
  ,service_description
  ,service_fee)
VALUES
  (10002
  ,to_date('01-07-2023', 'dd-mm-yyyy')
  ,to_date('02-07-2023', 'dd-mm-yyyy')
  ,'Kerekcsere'
  ,20000);

INSERT INTO service_log
  (car_id
  ,from_date
  ,to_date
  ,service_description
  ,service_fee)
VALUES
  (10003
  ,to_date('01-01-2020', 'dd-mm-yyyy')
  ,to_date('03-01-2020', 'dd-mm-yyyy')
  ,'Kerekcsere'
  ,10000);

INSERT INTO service_log
  (car_id
  ,from_date
  ,to_date
  ,service_description
  ,service_fee)
VALUES
  (10004
  ,to_date('01-01-2019', 'dd-mm-yyyy')
  ,to_date('01-02-2019', 'dd-mm-yyyy')
  ,'Motor meghibasodas'
  ,30000);
  
--Loading reserve
INSERT INTO reserve
  (customer_id
  ,car_id
  ,from_date
  ,to_date)
VALUES
  (10003
  ,10001
  ,SYSDATE + 2
  ,SYSDATE + 5);
