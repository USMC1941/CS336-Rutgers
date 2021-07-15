-- http://www.mysqltutorial.org/mysql-check-constraint/

DROP DATABASE IF EXISTS CS336_Test;
CREATE DATABASE IF NOT EXISTS CS336_Test;
USE CS336_Test;


-- Without Triggers. Does not work in MySQL Versions < 8.0.16 as it doesn't support CHECK
CREATE TABLE IF NOT EXISTS parts
(
	part_no VARCHAR(18) PRIMARY KEY,
	description VARCHAR(40),
	cost DECIMAL(10 , 2 ) NOT NULL CHECK (cost > 0),
	price DECIMAL(10 , 2 ) NOT NULL CHECK (price > 0),
	CHECK (price >= cost)
);





-- Step 1. Create table in a normal way without CHECK

CREATE TABLE IF NOT EXISTS parts
(
	part_no VARCHAR(18) PRIMARY KEY,
	description VARCHAR(40),
	cost DECIMAL(10, 2) NOT NULL,
	price DECIMAL(10, 2) NOT NULL
);

-- Step 2. Create a procedure ready for Trigger to call this procedure

DELIMITER $
CREATE PROCEDURE `check_parts`(IN cost DECIMAL(10,2), IN price DECIMAL(10,2))
BEGIN
	IF cost < 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'check constraint on parts.cost failed, cost should not be less than zero';
	END IF;

	IF price < 0 THEN
		SIGNAL SQLSTATE '45001'
		SET MESSAGE_TEXT = 'check constraint on parts.price failed, price should not be less than zero';
	END IF;

	IF price < cost THEN
		SIGNAL SQLSTATE '45002'
		SET MESSAGE_TEXT = 'check constraint on parts.price & parts.cost failed, price should not be less than cost';
	END IF;
END$
DELIMITER ;


-- Then, create BEFORE INSERT and BEFORE UPDATE triggers. Inside the triggers, call the check_parts() stored procedure.


-- before insert
DELIMITER $
CREATE TRIGGER `parts_before_insert` BEFORE INSERT ON `parts`
FOR EACH ROW
BEGIN
	CALL check_parts(new.cost,new.price);
END$
DELIMITER ;

-- before update
DELIMITER $
CREATE TRIGGER `parts_before_update` BEFORE UPDATE ON `parts`
FOR EACH ROW
BEGIN
	CALL check_parts(new.cost,new.price);
END$
DELIMITER ;

/*
After that, insert a new row that satisfies all the following conditions:

cost > 0
And price > 0
And price  >= cost

*/

INSERT INTO parts(part_no, description,cost,price)
VALUES('A-001','Cooler', 100, 120);

/*
The INSERT statement invokes the BEFORE INSERT trigger and accepts the values.

The following INSERT statement fails because it violates the condition: cost > 0.
*/

INSERT INTO parts(part_no, description,cost,price)
VALUES('A-002','Heater', -100, 120);

/*
MySQL said:
#1644 - check constraint on parts.cost failed, cost less than zero

The following INSERT statement fails because it violates the condition: price > 0.
*/

INSERT INTO parts(part_no, description,cost,price)
VALUES('A-002','Heater', 100, -120);

/*
MySQL said:
#1644 - check constraint on parts.price failed, price less than zero

The following INSERT statement fails because it violates the condition: price > cost.

*/

INSERT INTO parts(part_no, description,cost,price)
VALUES('A-003','wiper', 120, 100);

/*
MySQL said:
#1644 - check constraint on parts.price & parts.cost failed, price less than cost

So by using two triggers: BEFORE INSERT and BEFORE UPDATE, you are able to emulate CHECK constraints in MySQL.
*/

UPDATE parts
SET price = 10
WHERE part_no = 'A-001';

/*
This won't work because price is less than cost.  This is activating parts_before_update triggers
*/

-- MySQL CHECK constraints using Views

CREATE TABLE IF NOT EXISTS parts_data
(
	part_no VARCHAR(18) PRIMARY KEY,
	description VARCHAR(40),
	cost DECIMAL(10 , 2) NOT NULL,
	price DECIMAL(10, 2) NOT NULL
);

CREATE VIEW parts_view AS SELECT * FROM parts_data;

CREATE VIEW parts_view2 AS (SELECT part_no, description, 'AA' as SData FROM parts_data);

INSERT INTO parts_view(part_no, description,cost,price)
VALUES('A-001','Cooler',100,120);

SELECT * FROM parts_data;
SELECT * FROM parts_view;
SELECT * FROM parts_view1;
SELECT * FROM parts_view2;
SELECT * FROM parts;
