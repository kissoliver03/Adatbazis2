create table category(
category_id number constraint categories_pk primary key,
category_name varchar2(100) NOT NULL,
daily_fee number NOT NULL
);

create table car(
car_id number constraint cars_pk primary key,
license_plate varchar2(40) constraint license_plate_uq unique,
category_id number constraint category_id_fk references category(category_id) not null,
car_model varchar2(100) NOT NULL,
car_manufacturer varchar2(100) NOT NULL,
mileage number default 0,
status varchar2(40) constraint car_status_chk CHECK (status IN ('AVAILABLE', 'RENTED', 'MAINTENANCE', 'RESERVED')) NOT NULL
);

create table customer(
customer_id number constraint customers_pk primary key,
first_name varchar2(100) NOT NULL,
last_name varchar2(100) NOT NULL,
e_mail varchar2(100) NOT NULL,
is_regular_customer number(1) constraint vip_bool_chk CHECK (is_regular_customer IN (0,1))
);

create table rental(
rental_id number constraint rentals_pk primary key,
car_id number constraint rentals_car_id_fk references car(car_id) not null,
customer_id number constraint customer_id_fk references customer(customer_id) not null,
from_date DATE default sysdate NOT NULL,
to_date DATE,
return_date DATE,
rental_fee number
);

create table service_log(
service_id number constraint service_log_pk primary key,
car_id number constraint service_log_car_id_fk references car(car_id) NOT NULL,
service_date DATE default sysdate,
service_description varchar2(4000),
service_fee number
);

create table error_log(
err_id      number constraint error_log_pk primary key,
err_time    timestamp default sysdate,
err_message varchar2(4000),
err_value   varchar2(4000),
api         varchar2(100)
);
