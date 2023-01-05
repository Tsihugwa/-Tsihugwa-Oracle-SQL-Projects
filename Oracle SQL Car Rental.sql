/* Car rental database */

/* Under each comment modify and/or add the relevant code - DO NOT REMOVE THE COMMENTS */

/* Task 1 - correct the errors in this script file */

/* Also remember to change every table name to precede it with your user-id */

/*QUESTION 1*/

/*DROP VIEW service_overview CASCADE CONSTRAINTS;*//*REMOVED BECAUSE THERES NO service_overview created*/
DROP VIEW bh98kj_service_overdue CASCADE CONSTRAINTS;

DROP TABLE bh98kj_booking CASCADE CONSTRAINTS;

DROP TABLE bh98kj_customer CASCADE CONSTRAINTS;

DROP TABLE bh98kj_car CASCADE CONSTRAINTS;

DROP TABLE bh98kj_car_model CASCADE CONSTRAINTS;

DROP TABLE bh98kj_car_group CASCADE CONSTRAINTS;


CREATE TABLE bh98kj_car_group/*ADDED THIS TABLE BECAUSE IT DIDN'T EXIST*/
(car_group_name VARCHAR(2) NOT NULL PRIMARY KEY,/*CHANGED FROM CHAR TO VARCCHAR*/
rate_per_mile  	NUMBER(4,2),
rate_per_day   NUMBER(5,2) );

CREATE TABLE bh98kj_car_model
(model_name VARCHAR2(8) NOT NULL PRIMARY KEY,/*ADDED NOT NULL TO THE ROW*/
car_group_name VARCHAR(2)  NOT NULL REFERENCES bh98kj_car_group(car_group_name),/*ADDED (car_group_name)TO bh98kj_car_groupREFERENCES ,CHANGED FROM CHAR TO VARCCHAR*/
description VARCHAR2(30),
maint_int NUMBER(5) NOT NULL);

CREATE TABLE bh98kj_car
(reg_no VARCHAR2(8) NOT NULL PRIMARY KEY,
model_name VARCHAR2(8) NOT NULL REFERENCES bh98kj_car_model(model_name),/*ADDED (model_name)TO bh98kj_car_modeL REFERENCES */
date_bought DATE NOT NULL,/*REPLACED VARCHAR2(11) WITH DATE*/
cost NUMBER(8,2),
miles_to_date NUMBER(6) NOT NULL,
miles_last_service NUMBER(6));

CREATE TABLE bh98kj_customer
(cust_no NUMBER(5) NOT NULL PRIMARY KEY,/*ADDED NOT NULL TO THE ROW*/
cust_surname VARCHAR2(25) NOT NULL,
cust_forename VARCHAR2(30) NOT NULL,
cust_street VARCHAR2(25) NOT NULL,
cust_town VARCHAR2(15),
cust_county VARCHAR2(20),
cust_pcode VARCHAR(12) NOT NULL,
cust_phoneno VARCHAR(12),/*ADDED ROW TO THE TABLE AS IT WASNT THERE*/
cust_contact VARCHAR(20) NOT NULL,
cust_pay_method VARCHAR(1),/*CHANGED FROM CHAR TO VARCCHAR*/
cust_discount NUMBER(5,2));

CREATE TABLE bh98kj_booking
(booking_no NUMBER(5) NOT NULL PRIMARY KEY, /*ADDED NOT NULL TO THE LINE*/
cust_no NUMBER(5)  NOT NULL REFERENCES bh98kj_customer(cust_no),/*ADDED bh98kj_customer(cust_no)references to row*/
date_reserved DATE  NOT NULL,
start_date DATE ,
hire_period NUMBER(3),
reg_no VARCHAR2(8) NOT NULL REFERENCES bh98kj_car(reg_no),/*ADDED (reg_no) references FOR bh98kj_car to row*/
miles_out NUMBER(6) NOT NULL,
miles_in NUMBER(6) NOT NULL,
amount_due NUMBER(7,2),
paid VARCHAR(1) NOT NULL );/*CHANGED FROM CHAR TO VARCCHAR*/


/* Task 2 - Add below your SQL INSERT commands to insert all the data into your tables */

/*BH98KJ_CAR_GROUP*/
INSERT INTO bh98kj_car_group
VALUES ('A1', 5, 500);

INSERT INTO bh98kj_car_group
VALUES ('A2', 4, 450);

INSERT INTO bh98kj_car_group
VALUES ('A3', 4, 400);

INSERT INTO bh98kj_car_group
VALUES ('A4', 3.7, 355);

INSERT INTO bh98kj_car_group
VALUES ('B1', 3.5, 350);

INSERT INTO bh98kj_car_group
VALUES ('B2', 3, 300);

INSERT INTO bh98kj_car_group
VALUES ('B3', 2.5, 250);

INSERT INTO bh98kj_car_group
VALUES ('B4', 2, 200);


/*bh98kj_car_model*/
INSERT INTO bh98kj_car_model
VALUES('ASTON V8', 'A1', 'Aston Martin V8',	6000);
INSERT INTO bh98kj_car_model
VALUES('BMW 635', 'B2',	'BMW 635 CSi', 6000);
INSERT INTO bh98kj_car_model
VALUES('FERR TR', 'A1', 'Ferrari Testarossa', 5000);
INSERT INTO bh98kj_car_model
VALUES('TOY MR2', 'B4',	'Toyota MR2', 6000);
INSERT INTO bh98kj_car_model
VALUES('JAG XJS', 'A1',	'Jaguar XJS V12', 6000);
INSERT INTO bh98kj_car_model
VALUES('JAG XJ6', 'B1', 'Jaguar XJ6 Sovereign',	6000);
INSERT INTO bh98kj_car_model
VALUES('LAMB COU', 'A1', 'Lamborghini Countach', 4000);
INSERT INTO bh98kj_car_model
VALUES('MERC 560',	'A2', 'Mercedes 560 SEL',	6000);
INSERT INTO bh98kj_car_model
VALUES('P911 TC', 'B4', 'Porche 911 Turbo Cabriolet', 6000);
INSERT INTO bh98kj_car_model
VALUES('P944 T', 'A1', 'Porche 944 Turbo',	6000);
INSERT INTO bh98kj_car_model
VALUES('MJF SP', 'A3', 'MGF Sports', 10000);
INSERT INTO bh98kj_car_model
VALUES('RR SSPIR', 'B2', 'Rolls Royce Silver Spirit', 6000);

/*bh98kj_car*/
INSERT INTO bh98kj_car
VALUES ('A271 RUG', 'ASTON V8', '12-JUN-2019',223000, 60000, 56000);
INSERT INTO bh98kj_car
VALUES ('C345 21', 'BMW 635','12-JUN-18', 223000, 30201, 28678);
INSERT INTO bh98kj_car
VALUES ('P999 TIN',	'TOY MR2','02-May-19', 152200,	78567, 71459);
INSERT INTO bh98kj_car
VALUES ('R922 FGH',	'FERR TR', '21-Jul-17', 423000, 67987, 66865);
INSERT INTO bh98kj_car
VALUES ('D21 ME', 'JAG XJS', '15-Oct-15', 123500,	101567,98775);
INSERT INTO bh98kj_car
VALUES ('L367 RAT',	'LAMB COU',	'30-Nov-19', 233100, 67869, 64964);
INSERT INTO bh98kj_car
VALUES ('ME1 SUE', 'MERC 560', '28-Jan-18',	133000,	56432, 50000);
INSERT INTO bh98kj_car
VALUES ('RU MINE',	'P911 TC', '18-Feb-19',	333000,	23678, 20863);
INSERT INTO bh98kj_car
VALUES ('S897 TAN',	'P944 T', '30-Jul-17',	123000,	83675, 76000);
INSERT INTO bh98kj_car
VALUES ('JR2 DAL',	'MJF SP', '12-Jun-20',	330500,	54378,52005);
INSERT INTO bh98kj_car
VALUES ('JAM POT',	'RR SSPIR','15-Aug-18',	228000,	14645,9020);
INSERT INTO bh98kj_car
VALUES ('N921 SEP',	'JAG XJ6', '12-Dec-19',	157500,	23456,	20921);


/*bh98kj_customer */
INSERT INTO bh98kj_customer
VALUES(10001,	'Brown', 'John', '53 The Avenue', 'Sunderland',	'Tyne And Wear', 'SR2 3ED',	01915275436, 'John Brown', 'C', 15);
INSERT INTO bh98kj_customer
VALUES(10002, 'Smith', 'Janis', '57 Johnson Court',	'Sunderland', 'Tyne And Wear', 'SW33 RT5', 01915672341, 'Janis Smith', 'A',	25);
INSERT INTO bh98kj_customer
VALUES(10003, 'Thomas', 'Mary', '120 Falcon Road', 'Sunderland', 'Tyne And Wear', 'NE33 ER4', 01915647689, 'Sally Jones', 'C', 22.8);
INSERT INTO bh98kj_customer
VALUES(10004, 'Baker', 'Peter',	'The Lodge', 'Elm Road', 'London', 'SE43 6FR', 0171765432, 'Peter Baker',	'A', 20);
INSERT INTO bh98kj_customer
VALUES(10005, 'Wilson',	'Heather', '38 Lassiter Drive',	'London', NULL, 'NW45 3ER', 01715387652, 'Heather Wilson', 'A', 15);
INSERT INTO bh98kj_customer
VALUES(10006, 'Rafiq', 'Sunil', '37 Bromsmere Court', 'Sunderland', 'Tyne And Wear', 'SR4 6TY',	01915437658, 'Farouk Mohammed',	'C', 10);
INSERT INTO bh98kj_customer
VALUES(10007, 'Belmont', 'Hyacinth', '86 Potters Lane', 'Sunderland', 'Tyne And Wear', 'NE54 6TY', NULL, 'Lucinda Belmont', 'A', 15);
INSERT INTO bh98kj_customer
VALUES(10008, 'Thompson', 'Paul', '76 The Cedars', 'Prudhoe', 'Northumberland',	'NE76 7YU',	01661763363, 'Paul Thompson', 'C', 25);
INSERT INTO bh98kj_customer
VALUES(10009, 'Gray', 'Melanie', 'Pendleton House',	'Hexham', 'Northumberland', 'NE21 5HE',	1341, 'Melanie Gray', 'A', 21);
INSERT INTO bh98kj_customer
VALUES(10010, 'Stainmore', 'Herbert', '98 Flockhardt Drive', 'Whitby', 'North Yorkshire', 'YR45 8WL', 01325698785, 'June Brown', 'A', 18);

/*bh98kj_booking*/
INSERT INTO bh98kj_booking
VALUES (50001,	10001,	'12-JUN-21', '18-JAN-22', 15, 'P999 TIN', 65547, 65825,	5325, 'Y');
INSERT INTO bh98kj_booking
VALUES (50002,	10001,	'15-AUG-22', '23-DEC-22', 14, 'P999 TIN', 72987, 73034,	4712, 'N');
INSERT INTO bh98kj_booking
VALUES (50003,	10003,	'12-MAY-21', '12-MAY-21', 3, 'L367 RAT', 52345, 52548, 1500, 'N');
INSERT INTO bh98kj_booking
VALUES (50004,	10006,	'12-OCT-20', '18-NOV-20', 7, 'RU MINE', 23678, 24028, 1400, 'N');
INSERT INTO bh98kj_booking
VALUES (50009,	10006,	'12-OCT-22', '18-NOV-22', 7, 'L367 RAT', 52548, 52687, 2000, 'N');
INSERT INTO bh98kj_booking
VALUES (50005,	10007,	'12-JUL-22', '21-AUG-22', 1, 'JAM POT', 14345, 14365, 740, 'Y');
INSERT INTO bh98kj_booking
VALUES (50006,	10010,	'12-DEC-21', '01-JAN-22', 4, 'JR2 DAL', 54005, 54125, 4440, 'N');
INSERT INTO bh98kj_booking
VALUES (50007,	10010,	'15-JAN-22', '01-FEB-22', 4, 'JR2 DAL', 54125, 54350, 5600, 'N');
INSERT INTO bh98kj_booking
VALUES (50008,	10010,	'21-MAR-22', '14-APR-22', 3, 'JAM POT', 14645, 14700, 2340, 'N');


/* Task 3 - Enter each SQL query under the relevant comment */

/* DO NOT DELETE THE COMMENTS */

/* Task 3 - Question 1 */
select cust_surname, cust_forename, cust_street ,cust_county , cust_pcode
FROM bh98kj_customer 
WHERE cust_town <> 'Sunderland';  /*CAPITALIZED THE FIRST LETTER IN SUNDERLAND AND ADDED THE MISSING ROWS*/

/* Task 3 - Question 2 */
SELECT booking_no, bh98kj_booking.cust_no, start_date, bh98kj_booking.hire_period, bh98kj_car.reg_no, bh98kj_car_model.model_name, bh98kj_car_model.description
from bh98kj_booking, bh98kj_car, bh98kj_car_model
where bh98kj_car.reg_no = bh98kj_booking.reg_no
AND bh98kj_car_model.model_name = bh98kj_car.model_name
ORDER BY bh98kj_car_model.description ASC,bh98kj_booking.hire_period DESC ;

/* Task 3 - Question 3 */
SELECT bh98kj_car.reg_no as reg_no, bh98kj_booking.hire_period*bh98kj_car_group.rate_per_day AS overall_cost
from bh98kj_car, bh98kj_booking, bh98kj_car_group,bh98kj_car_model
where bh98kj_car_model.model_name = bh98kj_car.model_name
AND bh98kj_car.reg_no = bh98kj_booking.reg_no
AND bh98kj_car_model.car_group_name = bh98kj_car_group.car_group_name;

/* Task 3 - Question 4 */
SELECT booking_no, bh98kj_customer.cust_no, SUBSTR(cust_forename,1,1) ||'. '|| cust_surname  AS fullname,
coalesce(cust_phoneno, '------------') AS tel, start_date AS start_dat, start_date+ hire_period AS end_date
from bh98kj_booking, bh98kj_customer 
where bh98kj_booking.cust_no = bh98kj_customer.cust_no;

/* Task 3 - Question 5 */
CREATE VIEW bh98kj_service_overdue AS
select reg_no, miles_to_date, bh98kj_car.model_name as model_na,
description, maint_int, miles_last_service AS overdue
from bh98kj_car, bh98kj_car_model
where (bh98kj_car.model_name = bh98kj_car_model.model_name)
AND  (miles_to_date-miles_last_service)>maint_int;


select reg_no, miles_to_date,  model_na,
description, maint_int, overdue
from bh98kj_service_overdue
ORDER BY overdue DESC;

/* Task 3 - Question 6 */
select bh98kj_booking.reg_no as reg_no, count(bh98kj_booking.reg_no) as no_of_bookings
from  bh98kj_booking, bh98kj_service_overdue, bh98kj_car
where bh98kj_car.miles_to_date < bh98kj_service_overdue.miles_to_date
and bh98kj_booking.reg_no = bh98kj_car.reg_no
and bh98kj_service_overdue.reg_no = bh98kj_booking.reg_no
group by bh98kj_booking.reg_no ;

/* Task 3 - Question 7 */
ALTER TABLE bh98kj_customer
MODIFY cust_surname VARCHAR2(30);

ALTER TABLE bh98kj_customer 
MODIFY (cust_town NOT NULL,
cust_pay_method NOT NULL);

/* Task 3 - Question 8 */
CREATE INDEX person_name
ON bh98kj_customer(cust_surname, cust_forename );

CREATE INDEX registration
ON bh98kj_booking(reg_no);

COMMIT;





