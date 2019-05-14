-- DDL
CREATE TABLE tbldepartment
(
	dept_id CHAR(3) PRIMARY KEY,
	dept_name CHAR(40)
);

ALTER TABLE tbldepartment
ADD dept_mgr_name CHAR(50);

ALTER TABLE tbldepartment DROP dept_mgr_name;

CREATE TABLE tblemployee
(
	emp_id CHAR(3) PRIMARY KEY,
	last_name CHAR(45),
	first_name CHAR(30),
	dept_id CHAR(3),
	FOREIGN KEY(dept_id) REFERENCES tbldepartment(dept_id)
);

-- DML
INSERT INTO tbldepartment
VALUES ('FFF','Finance','King James');

INSERT INTO tblemployee
VALUES ('111','doe','john','AAA');

DELETE FROM tbldepartment WHERE dept_id='AAA';

UPDATE tblemployee SET last_name='King' WHERE
emp_id='111';

SELECT * FROM tbledepartment;

SELECT last_name, first_name FROM tblemployee
WHERE last_name LIKE '%d' AND first_name LIKE 'J%';

SELECT last_name, first_name FROM tblemployee
WHERE last_name='doe' AND first_name='john';


-- 

CREATE TABLE student_class
(
	class_id CHAR(3),
	student_id CHAR(3),
	semester_year CHAR(50),
	Grade int,
	PRIMARY KEY(class_id, student_id, semester_year),
	FOREIGN KEY(class_id) REFERENCES class(class_id),
	FOREIGN KEY(student_id) REFERENCES student(student_id)
);