create table categories(
category_id number constraint categories_pk primary key,
category_name varchar2(100) NOT NULL,
daily_fee number NOT NULL
);

create table cars(
car_id number constraint cars_pk primary key,
license_plate varchar2(40) constraint license_plate_uq unique,
category_id number references categories(category_id),
car_model varchar2(100) NOT NULL,
car_manufacturer varchar2(100) NOT NULL,
mileage number default 0,
status varchar2(40) constraint car_status_chk CHECK (status IN ('AVAILABLE', 'RENTED', 'MAINTENANCE', 'RESERVED')) NOT NULL
);


create table customers(
customer_id number constraint customers_pk primary key,
first_name varchar2(100) NOT NULL,
last_name varchar2(100) NOT NULL,
e_mail varchar2(100) NOT NULL,
is_regular_customer number(1) constraint vip_bool_chk CHECK (is_regular_customer IN (0,1))
);


create table rentals(
rental_id number constraint rentals_pk primary key,
car_id number references cars(car_id),
customer_id number references customers(customer_id),
from_date DATE default sysdate NOT NULL,
to_date DATE,
return_date DATE,
rental_fee number
);


create table service_log(
service_id number constraint service_log_pk primary key,
car_id number references cars(car_id) NOT NULL,
service_date DATE default sysdate,
service_description varchar2(4000),
service_fee number
);


--Loading categories
INSERT INTO categories
  (category_id
  ,category_name
  ,daily_fee)
VALUES
  (seq_categories.nextval
  ,'Premium'
  ,10000);
 
INSERT INTO categories
  (category_id
  ,category_name
  ,daily_fee)
VALUES
  (seq_categories.nextval
  ,'SUV'
  ,8000);
  
INSERT INTO categories
  (category_id
  ,category_name
  ,daily_fee)
VALUES
  (seq_categories.nextval
  ,'Van'
  ,15000);
  
INSERT INTO categories
  (category_id
  ,category_name
  ,daily_fee)
VALUES
  (seq_categories.nextval
  ,'Sedan'
  ,5000);
  
INSERT INTO categories
  (category_id
  ,category_name
  ,daily_fee)
VALUES
  (seq_categories.nextval
  ,'Sport'
  ,12000);
  
--Loading cars
INSERT INTO cars
  (car_id
  ,license_plate
  ,category_id
  ,car_model
  ,car_manufacturer
  ,mileage
  ,status)
VALUES
  (seq_cars.nextval
  ,'AUD-001'
  ,1
  ,'A6'
  ,'Audi'
  ,120000
  ,'AVAILABLE');

INSERT INTO cars
  (car_id
  ,license_plate
  ,category_id
  ,car_model
  ,car_manufacturer
  ,mileage
  ,status)
VALUES
  (seq_cars.nextval
  ,'TOY-002'
  ,2
  ,'RAV4'
  ,'Toyota'
  ,45000
  ,'RENTED');

INSERT INTO cars
  (car_id
  ,license_plate
  ,category_id
  ,car_model
  ,car_manufacturer
  ,mileage
  ,status)
VALUES
  (seq_cars.nextval
  ,'FOR-003'
  ,3
  ,'Transit'
  ,'Ford'
  ,210000
  ,'AVAILABLE');

INSERT INTO cars
  (car_id
  ,license_plate
  ,category_id
  ,car_model
  ,car_manufacturer
  ,mileage
  ,status)
VALUES
  (seq_cars.nextval
  ,'OPE-004'
  ,4
  ,'Astra'
  ,'Opel'
  ,89000
  ,'MAINTENANCE');

INSERT INTO cars
  (car_id
  ,license_plate
  ,category_id
  ,car_model
  ,car_manufacturer
  ,mileage
  ,status)
VALUES
  (seq_cars.nextval
  ,'MUS-005'
  ,5
  ,'Mustang'
  ,'Ford'
  ,15000
  ,'RESERVED');
  

--Loading customers
INSERT INTO customers
  (customer_id
  ,first_name
  ,last_name
  ,e_mail
  ,is_regular_customer)
VALUES
  (seq_customers.nextval
  ,'Nagy'
  ,'Anna'
  ,'nagyanna@gmail.com'
  ,1);

INSERT INTO customers
  (customer_id
  ,first_name
  ,last_name
  ,e_mail
  ,is_regular_customer)
VALUES
  (seq_customers.nextval
  ,'Kiss'
  ,'Peter'
  ,'kisspeter@gmail.com'
  ,0);

INSERT INTO customers
  (customer_id
  ,first_name
  ,last_name
  ,e_mail
  ,is_regular_customer)
VALUES
  (seq_customers.nextval
  ,'Kovacs'
  ,'Eva'
  ,'kovacseva@gmail.com'
  ,0);

INSERT INTO customers
  (customer_id
  ,first_name
  ,last_name
  ,e_mail
  ,is_regular_customer)
VALUES
  (seq_customers.nextval
  ,'Horvath'
  ,'Tamas'
  ,'horvathtamas@gmail.com'
  ,1);

INSERT INTO customers
  (customer_id
  ,first_name
  ,last_name
  ,e_mail
  ,is_regular_customer)
VALUES
  (seq_customers.nextval
  ,'Toth'
  ,'Gabor'
  ,'tothgabor@gmail.com'
  ,0);
  
  
 --Loading rentals
INSERT INTO rentals
  (rental_id
  ,car_id
  ,customer_id
  ,from_date
  ,to_date
  ,return_date
  )
VALUES
  (
  seq_rentals.nextval,
  10000,
  10000,
  to_date('01-10-2023', 'dd-mm-yyyy'),
  to_date('05-10-2023', 'dd-mm-yyyy'),
  to_date('05,10,2023', 'dd-mm-yyyy')
  );
  
INSERT INTO rentals
  (rental_id
  ,car_id
  ,customer_id
  ,from_date
  ,to_date
  ,return_date
  )
VALUES
  (seq_rentals.nextval
  ,10001
  ,10001
  ,SYSDATE - 2
  ,SYSDATE + 5
  ,NULL
  );

INSERT INTO rentals
  (rental_id
  ,car_id
  ,customer_id
  ,from_date
  ,to_date
  ,return_date
  )
VALUES
  (seq_rentals.nextval
  ,10002
  ,10002
  ,to_date('01-06-2023', 'dd-mm-yyyy')
  ,to_date('06-10-2023', 'dd-mm-yyyy')
  ,to_date('06-10-2023', 'dd-mm-yyyy'));

INSERT INTO rentals
  (rental_id
  ,car_id
  ,customer_id
  ,from_date
  ,to_date
  ,return_date
  )
VALUES
  (seq_rentals.nextval
  ,10003
  ,10003
  ,to_date('11-10-2023', 'dd-mm-yyyy')
  ,to_date('12-10-2023', 'dd-mm-yyyy')
  ,to_date('12-10-2023', 'dd-mm-yyyy'));

INSERT INTO rentals
  (rental_id
  ,car_id
  ,customer_id
  ,from_date
  ,to_date
  ,return_date
  )
VALUES
  (seq_rentals.nextval
  ,10004
  ,10004
  ,to_date('01-09-2023', 'dd-mm-yyyy')
  ,to_date('05-09-2023', 'dd-mm-yyyy')
  ,to_date('05-09-2023', 'dd-mm-yyyy')
  );
  

--Loading service log
INSERT INTO service_log
  (service_id
  ,car_id
  ,service_date
  ,service_description
  ,service_fee)
VALUES
  (seq_service_log.nextval
  ,10000
  ,to_date('01-01-2023', 'dd-mm-yyyy')
  ,'Olajcsere'
  ,15000);
  
  INSERT INTO service_log
  (service_id
  ,car_id
  ,service_date
  ,service_description
  ,service_fee)
VALUES
  (seq_service_log.nextval
  ,10001
  ,to_date('01-04-2021', 'dd-mm-yyyy')
  ,'Olajcsere'
  ,12000);
  
  INSERT INTO service_log
  (service_id
  ,car_id
  ,service_date
  ,service_description
  ,service_fee)
VALUES
  (seq_service_log.nextval
  ,10002
  ,to_date('01-07-2023', 'dd-mm-yyyy')
  ,'Kerekcsere'
  ,20000);
  
  INSERT INTO service_log
  (service_id
  ,car_id
  ,service_date
  ,service_description
  ,service_fee)
VALUES
  (seq_service_log.nextval
  ,10003
  ,to_date('01-01-2020', 'dd-mm-yyyy')
  ,'Kerekcsere'
  ,10000);
  
  INSERT INTO service_log
  (service_id
  ,car_id
  ,service_date
  ,service_description
  ,service_fee)
VALUES
  (seq_service_log.nextval
  ,10004
  ,to_date('01-01-2019', 'dd-mm-yyyy')
  ,'Motor meghibasodas'
  ,30000);

