create table department
(
	Dname char(15),
	Dno char(3) primary key,
	Total_sal real,
	Manager_ssn char(3)
);

create table employee
(
	name char(40),
	Ssn char(3) primary key,
	Salary real,
	Dno char(3),
	Supervisor_ssn char(3),
	foreign key(Dno) references department(Dno)
);

-- XAMPP Syntax:

/*
Inserting (one or more) new employee tuples,
need to update Total_sal
*/

CREATE TRIGGER `Total_Sal1` AFTER INSERT ON `employee`
FOR EACH ROW
UPDATE department
SET Total_sal = Total_sal + NEW.Salary
WHERE Dno = NEW.Dno;

insert into department values
("Finance","FFF",0.00,"M01");

insert into department values
("Accounting","AAA",0.00,"M02");

insert into employee values
("John Doe","111",55000.00,"FFF","M01");

select * from department;

insert into employee values
("Bill Clinton","222",45000.00,"FFF","M01");

select * from department;

/*
Changing the salary of (one or more) existing employees
*/
CREATE TRIGGER `Total_Sal2` AFTER UPDATE ON `employee`
FOR EACH ROW
UPDATE department SET Total_sal = Total_sal + NEW.Salary - OLD.Salary
WHERE Dno=NEW.Dno;

update employee set Salary=0 where Ssn="222";

select * from department;

/*
XAMPP does not allow multiple triggers on the same table with the same action like AFTER UPDATE

Changing the assignment of existing employess from one department
to another
*/
CREATE TRIGGER `Total_Sal3` AFTER UPDATE ON `employee`
FOR EACH ROW
BEGIN
	UPDATE department SET Total_sal = Total_sal + NEW.Salary WHERE Dno=NEW.Dno;
	UPDATE department SET Total_sal = Total_sal - OLD.Salary WHERE Dno=OLD.Dno;
END;

/*
Deleting (one or more) employee tuples
*/
CREATE TRIGGER `Total_Sal3` AFTER DELETE ON `employee`
FOR EACH ROW
UPDATE department SET Total_sal = Total_sal - OLD.Salary
WHERE Dno = OLD.Dno;

select * from department;

select * from employee;

delete from employee where Ssn="111";

select * from department;