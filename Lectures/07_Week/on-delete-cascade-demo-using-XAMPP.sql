drop table Works;
drop table Dept;
drop table Emp;

CREATE TABLE Emp
(
	eid INTEGER, 
	ename CHAR(10), 
	age INTEGER, 
	salary REAL, 
	PRIMARY KEY(eid)
);

CREATE TABLE Dept 
(
	did INTEGER, 
	budget REAL, 
	managerid INTEGER,
	PRIMARY KEY(did), 
	FOREIGN KEY(managerid) REFERENCES Emp(eid)
); 

CREATE TABLE Works
(
	eid INTEGER,
	did INTEGER,
	pcttime INTEGER, 
	PRIMARY KEY(eid, did), 
	FOREIGN KEY(did) REFERENCES Dept(did) ON UPDATE CASCADE, 
	FOREIGN KEY(eid) REFERENCES Emp(eid) ON DELETE CASCADE
);

insert into emp
values
(111,'John',25,60000.00),
(222,'Jill',26,75000.11),
(333,'Jack',23,45000.22);

insert into Dept
values
(12345,500000,111),
(23456,600000,222);

insert into Works
values
(111,12345,24),
(222,23456,55),
(333,12345,77);

delete from Emp where eid=111; /*not working, why? */

delete from Emp where eid=333; /*it works, why? */

update dept set did=99999 where did=12345; /*ON UPDATE CASCADE*/