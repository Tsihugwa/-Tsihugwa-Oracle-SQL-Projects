--------------------------------------------------------------------------------
-- Sql Command File For Online Shopping-
-- System Database.
-- Written By: Ryan Tsihugwa                                               
-- December 2022                                                  
-------------------------------------------------------------------------------
--declare serveroutput
SET SERVEROUTPUT ON;
--drop tables and sequence
DROP SEQUENCE purchase_seq;
DROP TABLE purchase CASCADE CONSTRAINTS;
DROP TABLE bank CASCADE CONSTRAINTS;
DROP SEQUENCE cust_seq;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE stock CASCADE CONSTRAINTS; 

--create database tables
CREATE TABLE stock (
item_number NUMBER(5) NOT NULL PRIMARY KEY,
item_name VARCHAR2(20) NOT NULL,
item_type VARCHAR2 (25),
description VARCHAR(25),
instock NUMBER(4),
branch VARCHAR2(25) NOT NULL,
branch_street VARCHAR(25) NOT NULL,
branch_pcode VARCHAR(10) NOT NULL,
cost NUMBER (6) NOT NULL
);

CREATE TABLE customer(
cust_id NUMBER (5) NOT NULL,
surname VARCHAR2(20) NOT NULL,
firstname VARCHAR2(15) NOT NULL,
phone VARCHAR (12) NOT NULL,
property_no NUMBER(4) NOT NULL,
street VARCHAR2(20) NOT NULL,
postcode VARCHAR(8) NOT NULL,
town VARCHAR2(15),
age NUMBER(2) NOT NULL
);
--set cust_id as priamry key
ALTER TABLE customer ADD(
CONSTRAINT custpk PRIMARY KEY(cust_id)
);

CREATE TABLE bank(
account_number NUMBER(10) NOT NULL,
cust_id NUMBER (5) NOT NULL REFERENCES customer(cust_id),
sortcode VARCHAR(8) NOT NULL
);

CREATE TABLE purchase(
purchase_id NUMBER (5) NOT NULL,
cust_id NUMBER (5) NOT NULL REFERENCES customer(cust_id),
item_number NUMBER(5) NOT NULL REFERENCES stock(item_number),
purchase_date date NOT NULL
);
ALTER TABLE purchase ADD(
CONSTRAINT purchasepk PRIMARY KEY(purchase_id)
);

--create sequence for autoincrement of parent keys of customer and purchase
CREATE SEQUENCE cust_seq START WITH 1;
CREATE OR REPLACE TRIGGER cust_bir
BEFORE INSERT ON customer
FOR EACH ROW
BEGIN
SELECT cust_seq.NEXTVAL
INTO : new.cust_id
FROM dual;
END;
/
--CREATE a sequence to autogenerate Customer ID
CREATE SEQUENCE purchase_seq START WITH 1;
CREATE OR REPLACE TRIGGER purchase_bir
BEFORE INSERT ON purchase
FOR EACH ROW
BEGIN
SELECT purchase_seq.NEXTVAL
INTO : new.purchase_id
FROM dual;
END;
/

--insert values into tables created
INSERT INTO stock
VALUES(1,'XBOX-controller','Controller','Xbox one',23, 'Palion', 'Neville', 'SR1 0DD',34.30);
INSERT INTO stock
VALUES(12,'Gaming Chair','Furniture', 'Ergonomic',12,'Hylton', 'Hylton road', 'SR4 4HD',87.50);
INSERT INTO stock
VALUES(3,'PlayStation Console','Consoles', 'PS5',1,'St. Peters', 'St. Peters Way', 'SR3 0XD', 650);
INSERT INTO stock
VALUES(21,'Gaming Headphones','Accessories', 'ROG Headphones',9,'Central Station', 'Central Station Rd', 'NE1 0SF', 54);
INSERT INTO stock
VALUES(11,'Call of Duty','Games','Disk version', 102,'Monkwear', 'Monkwearmouth', 'SR3 2GH', 23 );

INSERT INTO customer(surname, firstname,phone, property_no, street, postcode, town, age)
VALUES('Wanja','Agnes','123455321',10,'MAINSFORTH','SR28JX',null,21);
INSERT INTO customer(surname, firstname,phone, property_no, street, postcode, town, age)
VALUES('Tsihugwa','Ryan','453455321',20,'MAINSFORTH TERRACE','SR48JX','Sunderland',22);
INSERT INTO customer(surname, firstname, phone,property_no, street, postcode, town, age)
VALUES('Wariiyu','Anne','922355321',37,'RYHOPE','SR58JX',null,29);
INSERT INTO customer(surname, firstname, phone,property_no, street, postcode, town, age)
VALUES('Wandia','Nenki','123645321',12,'MAINSFORTH WEST','SR23CX','Sunderland',21);
INSERT INTO customer(surname, firstname, phone,property_no, street, postcode, town, age)
VALUES('Giggs','Ryan','133455321',09,'Neville','SR48PL',null,18);

INSERT INTO bank
VALUES(11230312, 1, '23-34-54');
INSERT INTO bank
VALUES(12340312, 3, '12-45-04');
INSERT INTO bank
VALUES(67890312, 5, '73-34-84');
INSERT INTO bank
VALUES(12467312, 2, '05-23-54');
INSERT INTO bank
VALUES(9876512, 4, '23-52-54');

INSERT INTO purchase(cust_id,item_number, purchase_date)
VALUES(1,11,'12-MAR-2022');
INSERT INTO purchase(cust_id,item_number, purchase_date)
VALUES(3, 12,'23-MAR-2022');
INSERT INTO purchase(cust_id,item_number, purchase_date)
VALUES(5,3,'22-APRIL-2022');
INSERT INTO purchase(cust_id,item_number, purchase_date)
VALUES(2,1,'01-MAY-2022');
INSERT INTO purchase(cust_id,item_number, purchase_date)
VALUES(4, 21,'12-DEC-2022');

--Create new customer
CREATE OR REPLACE FUNCTION create_customer(
new_cust_id NUMBER,
new_surname VARCHAR2,
new_firstname VARCHAR2,
new_phone VARCHAR,
new_property_no NUMBER,
new_street VARCHAR2,
new_postcode VARCHAR,
new_town VARCHAR2,
new_age NUMBER
)
RETURN VARCHAR2
AS
cust_cust_count NUMBER;

-- Declare exceptions
customer_already_exists EXCEPTION;
surname_null_error EXCEPTION;
firstname_null_error EXCEPTION;
phone_null_error EXCEPTION;
property_no_null_error EXCEPTION;
street_null_error EXCEPTION;
postcode_null_error EXCEPTION;
age_null_error EXCEPTION;
customer_creation_error EXCEPTION;
invalid_age EXCEPTION;

BEGIN
-- Check for duplicate customer
SELECT COUNT(*)
INTO cust_cust_count
FROM customer
WHERE cust_id = new_cust_id;

IF cust_cust_count > 0 THEN
RAISE customer_already_exists;
END IF;

--Check if customer is over 18
IF new_age < 18 THEN
  RAISE invalid_age;
END IF;

-- Validate not null columns
IF new_surname IS NULL THEN
RAISE surname_null_error;
ELSIF new_firstname IS NULL THEN
RAISE firstname_null_error;
ELSIF new_phone IS NULL THEN
RAISE phone_null_error;
ELSIF new_property_no IS NULL THEN
RAISE property_no_null_error;
ELSIF new_street IS NULL THEN
RAISE street_null_error;
ELSIF new_postcode IS NULL THEN
RAISE postcode_null_error;
ELSIF new_age IS NULL THEN
RAISE age_null_error;

END IF;

-- Insert new customer
INSERT INTO customer (cust_id, surname, firstname, phone, property_no, street, postcode, town, age)
VALUES (cust_seq.NEXTVAL, new_surname, new_firstname, new_phone, new_property_no, new_street, new_postcode, new_town, new_age);

RETURN 'Customer created successfully.';

EXCEPTION
WHEN customer_already_exists THEN
RETURN 'Error: Customer with ID ' || new_cust_id || ' already exists.';

WHEN surname_null_error THEN
RETURN 'Error: surname cannot be null.';
WHEN firstname_null_error THEN
RETURN 'Error: firstname cannot be null.';
WHEN phone_null_error THEN
RETURN 'Error: phone cannot be null.';
WHEN property_no_null_error THEN
RETURN 'Error: property_no cannot be null.';
WHEN street_null_error THEN
RETURN 'Error: street cannot be null.';
WHEN postcode_null_error THEN
RETURN 'Error: Postcode cannot be null.';
WHEN age_null_error THEN
RETURN 'Error: age cannot be null.';

WHEN invalid_age THEN
RETURN 'Error: Customer must be over 18 years old.';
END;
/

-- Test customer_already_exists exception using an ID that already exists
BEGIN
dbms_output.put_line(create_customer(1, 'Raymond', 'Baron', '23456876543', 123, 'Main St', '12345', 'Newcastle', 32));
END;
/
--Test for null values in surname field
BEGIN
dbms_output.put_line(create_customer(cust_seq.NEXTVAL, NULL, 'Ray', '0234567890', 1, 'Mainsforth St', 'NE47DH', 'Newcastle', 30));
END;
/
--input age that is under 18
BEGIN
dbms_output.put_line(create_customer(cust_seq.NEXTVAL, 'Ade', 'Zoe', NULL, 1, 'Mainsforth TW', 'NE42RD', 'Newcastle', 16));
END;
/
--inputing correct data into the database
BEGIN
dbms_output.put_line(create_customer(cust_seq.NEXTVAL, 'Ade', 'Zoe', '3459876542', 1, 'Hylton Rd', 'SR42RD', 'Sunderland', 34));
END;
/

--check if data was saved to database
SELECT * FROM customer;

--Procedure for new purchase using item id
CREATE OR REPLACE PROCEDURE purchase_item (
p_cust_id IN customer.cust_id%TYPE,
p_item_number IN stock.item_number%TYPE,
p_branch IN stock.branch%TYPE
)
AS
pur_cost stock.cost%TYPE;
pur_instock stock.instock%TYPE;
pur_item_exists NUMBER(1) := 0;
pur_branch_exists NUMBER(1) := 0;
pur_cust_exists NUMBER(1) := 0;

BEGIN

-- enclose the code in a block
BEGIN
  -- check if the item exists in the specified branch
  SELECT 1
  INTO pur_item_exists
  FROM stock
  WHERE item_number = p_item_number AND branch = p_branch;
  -- check if the specified branch exists
  SELECT 1
  INTO pur_branch_exists
  FROM stock
  WHERE branch = p_branch;
  -- if the item or branch does not exist, raise an exception
  IF pur_item_exists = 0 OR pur_branch_exists = 0 THEN
    RAISE NO_DATA_FOUND;
  END IF;
  -- retrieve the cost and instock of the item
  SELECT cost, instock
  INTO pur_cost, pur_instock
  FROM stock
  WHERE item_number = p_item_number AND branch = p_branch;
  -- if the item is not in stock, raise an exception
  IF pur_instock = 0 THEN
    RAISE NO_DATA_FOUND;
  END IF;
  -- reduce the stock by 1
  UPDATE stock
  SET instock = instock - 1
  WHERE item_number = p_item_number AND branch = p_branch;
  -- save the purchase in the purchase table
  INSERT INTO purchase (purchase_id, cust_id, item_number, purchase_date)
  VALUES (purchase_seq.NEXTVAL, p_cust_id, p_item_number, SYSDATE);
  -- display the purchase information and cost to the user
  DBMS_OUTPUT.PUT_LINE('Purchase ID: ' ||purchase_seq.NEXTVAL);
  DBMS_OUTPUT.PUT_LINE('Item: ' || p_item_number);
  DBMS_OUTPUT.PUT_LINE('Branch: ' || p_branch);
  DBMS_OUTPUT.PUT_LINE('Cost: ' ||pur_cost);

EXCEPTION
  -- exception handler for NO_DATA_FOUND
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('The specified item or branch does not exist or the item is not in stock.');
END;

END purchase_item;
/

--The first two inputs of the same item which has only one item in stock to demonstrate how the item goes out of stock after the first purchase
BEGIN
purchase_item(p_cust_id => 1,
p_item_number => 3,
p_branch => 'St. Peters');
END;
/
BEGIN
purchase_item(p_cust_id => 2,
p_item_number => 3,
p_branch => 'St. Peters');
END;
/
--this example displays an example of a successful purchase of a different item
BEGIN
purchase_item(p_cust_id => 3,
p_item_number => 21,
p_branch => 'Central Station');
END;
/

--create purchase records history
CREATE OR REPLACE PROCEDURE display_purchase_info (
start_date IN DATE,
end_date IN DATE,
cursor_out OUT SYS_REFCURSOR
)
AS
BEGIN

OPEN cursor_out FOR
SELECT purchase.purchase_id, purchase.cust_id, purchase.item_number, stock.branch, stock.branch_street,
stock.branch_pcode, purchase.purchase_date, stock.item_name, stock.description
FROM purchase
INNER JOIN stock
ON purchase.item_number = stock.item_number
WHERE purchase.purchase_date BETWEEN start_date AND end_date;
EXCEPTION
WHEN OTHERS THEN
RAISE_APPLICATION_ERROR(-20001, 'An error occurred while trying to display the purchase information.');
END;
/

DECLARE
cursor_cust SYS_REFCURSOR;
purchase_id NUMBER;
cust_id NUMBER;
item_number NUMBER;
branch VARCHAR2(25);
branch_street VARCHAR2(25);
branch_pcode VARCHAR2(10);
purchase_date DATE;
item_name VARCHAR2(20);
description VARCHAR2(25);
NO_DATA_FOUND EXCEPTION;
INVALID_DATE EXCEPTION;
BEGIN
display_purchase_info(
start_date => TO_DATE('2022-03-01','YYYY-MM-DD'),
end_date => TO_DATE('2022-05-31','YYYY-MM-DD'),
cursor_out => cursor_cust
);

LOOP
FETCH cursor_cust INTO purchase_id, cust_id, item_number, branch, 
branch_street, branch_pcode, purchase_date, item_name, description;

IF cursor_cust%ROWCOUNT = 0 THEN
RAISE NO_DATA_FOUND;
END IF;

EXIT WHEN cursor_cust%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Purchase ID: ' || purchase_id);
DBMS_OUTPUT.PUT_LINE('Customer ID: ' || cust_id);
DBMS_OUTPUT.PUT_LINE('Item number: ' || item_number);
DBMS_OUTPUT.PUT_LINE('Item name: ' || item_name);
DBMS_OUTPUT.PUT_LINE('Description: ' || description);
DBMS_OUTPUT.PUT_LINE('Branch: ' || branch);
DBMS_OUTPUT.PUT_LINE('Branch street: ' || branch_street);
DBMS_OUTPUT.PUT_LINE('Branch pcode: ' || branch_pcode);
DBMS_OUTPUT.PUT_LINE('Purchase date: ' || purchase_date);        
DBMS_OUTPUT.PUT_LINE('------------------');
END LOOP;

CLOSE cursor_cust;

EXCEPTION
WHEN NO_DATA_FOUND THEN
dbms_output.put_line('No purchases found between the specified dates');
END;
/

COMMIT;

