-- Actual Assignment Starts From Line No. 240
-- Below Are Some Utility Procedures Used To Reset Database, Tables And Table Records


-- Procedure To Drop All Tables If Exists
CREATE PROCEDURE spDropTables
AS
BEGIN
	IF OBJECT_ID('EmployeeProject') IS NOT NULL
		DROP TABLE EmployeeProject;
	IF OBJECT_ID('Employee') IS NOT NULL
		DROP TABLE Employee;
	IF OBJECT_ID('Department') IS NOT NULL
		DROP TABLE Department;
	IF OBJECT_ID('Project') IS NOT NULL
		DROP TABLE Project;
END


-- Procedure To Create Table 'Department'
CREATE PROCEDURE spCreateDepartmentTable 
AS
BEGIN 
	CREATE TABLE Department (
		dept_id INT IDENTITY(1, 1) PRIMARY KEY,
		dept_name VARCHAR(50) NOT NULL DEFAULT NULL
	);
END


-- Procedure To Create Table 'Employee'
CREATE PROCEDURE spCreateEmployeeTable 
AS
BEGIN 
	CREATE TABLE Employee (
		emp_id INT IDENTITY(1, 1) PRIMARY KEY,
		first_name VARCHAR(50) NOT NULL DEFAULT NULL,
		last_name VARCHAR(50),
		dept_id INT FOREIGN KEY REFERENCES Department(dept_id) ON DELETE CASCADE,
		salary DECIMAL(10, 2) NOT NULL CHECK (salary >= 10000) DEFAULT 10000,
		email VARCHAR(70) NOT NULL UNIQUE DEFAULT NULL,
		hire_date DATE DEFAULT CAST (GETDATE() AS DATE)
	);
END


-- Procedure To Create Table 'Project'
CREATE PROCEDURE spCreateProjectTable
AS
BEGIN
	CREATE TABLE Project (
		project_id INT IDENTITY(101, 1) PRIMARY KEY,
		project_name VARCHAR(50) NOT NULL DEFAULT NULL,
		start_date DATE DEFAULT CAST (GETDATE() AS DATE),
		end_date DATE DEFAULT NULL
	);
END


-- Procedure To Create Table 'EmployeeProject'
CREATE PROCEDURE spCreateEmployeeProjectTable
AS
BEGIN
	CREATE TABLE EmployeeProject (
		emp_id INT,
		project_id INT,
		PRIMARY KEY (emp_id, project_id)
	);
END


-- Procedure To Create All Tables
CREATE PROCEDURE spCreateTables
AS
BEGIN
	EXEC spCreateDepartmentTable;
	EXEC spCreateEmployeeTable;
	EXEC spCreateProjectTable;
	EXEC spCreateEmployeeProjectTable;
END


-- Procedure To Insert Records Into Table 'Department'
CREATE PROCEDURE spInsertIntoDepartment
AS
BEGIN
	INSERT INTO Department VALUES
	('IT'),
	('DevOps'),
	('Software Development'),
	('Cyber Security');
END


-- Procedure To Insert Records Into Table 'Employee'
CREATE PROCEDURE spInsertIntoEmployee 
AS
BEGIN
	INSERT INTO Employee VALUES
	('Wade', 'Allen', 2, 60000, 'wade@gmail.com', CAST('2018-04-20' AS DATE)),
	('Isabel', 'Lopez', 1, 55000, 'isabel@gmail.com', CAST('2014-12-21' AS DATE)),
	('Seth', 'Green', 4, 40000, 'seth@gmail.com', CAST('2021-07-11' AS DATE)),
	('Ivan', 'Terry', 3, 75000, 'ivan@gmail.com', CAST('2023-02-12' AS DATE)),
	('Lucy', 'Shaw', 2, 60000, 'lucy@gmail.com', CAST('2021-01-06' AS DATE)),
	('Glen', 'Hamittor', 3, 65000, 'glen@gmail.com', CAST('2023-02-05' AS DATE)),
	('Vicki', 'Erick', 3, 70000, 'vicky@gmail.com', CAST('2023-02-05' AS DATE)),
	('Molly', 'Duardo', 3, 25000, 'molly@gmail.com', CAST('2021-07-15' AS DATE)),
	('Blake', 'Graham', 1, 30000, 'blake@gmail.com', CAST('2020-11-30' AS DATE)),
	('Jose', 'White', 2, 25000, 'jose@gmai.com', CAST('2019-04-20' AS DATE)),
	('Adam', 'Clark', 3, 90000, 'adam@gmail.com', CAST('2023-02-05' AS DATE)),
	('Mila', 'Dean', 1, 40000, 'mila@gmail.com', CAST('2015-08-20' AS DATE)),
	('Lisa', 'David', 4, 35000, 'lisa@gmail.com', CAST('2021-12-25' AS DATE)),
	('Noah', 'Smith', 4, 15000, 'noah@gmail.com', CAST('2026-01-15' AS DATE)),
	('Lory', 'Gross', 2, 35000, 'lory@gmail.com', CAST('2020-12-25' AS DATE)),
	('Joseph', 'Harris', 3, 30000, 'jose[h@gmail.com', CAST('2023-01-26' AS DATE)),
	('Luis', 'Cooper', 3, 40000, 'luis@gmail.com', CAST('2023-01-26' AS DATE)),
	('Dora', 'Perry', 1, 30000, 'dora@gmail.com', CAST('2016-02-28' AS DATE)),
	('Pedro', 'Norris', 2, 50000, 'pedro@gmail.com', CAST('2018-04-21' AS DATE)),
	('Emma', 'Stanely', 3, 50000, 'emma@gmail.com', CAST('2023-02-14' AS DATE));
END


-- Procedure To Insert Records Into Table 'Project'
CREATE PROCEDURE spInsertIntoProject
AS
BEGIN
	INSERT INTO Project VALUES
	('IT Asset And Management System', CAST('2016-03-11' AS DATE), CAST('2022-07-20' AS DATE)),
	('Network Monitoring Tool', CAST('2021-01-22' AS DATE), NULL),
	('Server Maintaince And Automation', CAST('2015-09-11' AS DATE), NULL),
	('CI/CD Pipeline Automation', CAST('2019-05-03' AS DATE), CAST('2020-02-23' AS DATE)),
	('Cloud Infrastructure Automation', CAST('2021-03-17' AS DATE), CAST('2021-11-12' AS DATE)),
	('Monitoring And Logging System', CAST('2018-06-03' AS DATE), CAST('2019-09-15' AS DATE)),
	('Employee Management System', CAST('2023-02-17' AS DATE), CAST('2024-05-02' AS DATE)),
	('E-Commerce Web Application', CAST('2024-03-11' AS DATE), NULL),
	('LMS', CAST('2023-05-06' AS DATE), CAST('2025-01-11' AS DATE)),
	('Mobile Banking Application', CAST('2024-07-10' AS DATE), NULL),
	('Intrusion Detection System', CAST('2021-08-15' AS DATE), CAST('2023-09-14' AS DATE)),
	('Vulnerablity Assessment Tool', CAST('2024-03-22' AS DATE), NULL);
END


-- Procedure To Insert Records Into Table 'EmployeeProject'
CREATE PROCEDURE spInsertIntoEmployeeProject
AS
BEGIN
	INSERT INTO EmployeeProject VALUES
	(2, 101),
	(12, 101),
	(18, 101),
	(9, 102),
	(2, 102),
	(2, 103),
	(12, 103),
	(1, 104),
	(10, 104),
	(19, 104),
	(10, 105),
	(5, 105),
	(19, 105),
	(15, 105),
	(1, 106),
	(5, 106),
	(19, 106),
	(4, 107),
	(6, 107),
	(7, 107),
	(11, 107),
	(16, 107),
	(17, 107),
	(20, 107),
	(4, 108),
	(11, 108),
	(17, 108),
	(20, 108),
	(6, 109),
	(7, 109),
	(11, 109),
	(4, 110),
	(7, 110),
	(8, 110),
	(11, 110),
	(20, 110),
	(3, 111),
	(13, 111),
	(3, 112);
END



CREATE PROCEDURE spResetTables
AS
BEGIN
	EXEC spDropTables;
	EXEC spCreateTables;
	EXEC spInsertIntoDepartment;
	EXEC spInsertIntoEmployee;
	EXEC spInsertIntoProject;
	EXEC spInsertIntoEmployeeProject
END


-- Procedure To Display All Tables And Its Records.
CREATE PROCEDURE spShowTables
AS
BEGIN
	SELECT * FROM Department;
	SELECT * FROM Employee;
	SELECT * FROM Project;
	SELECT * FROM EmployeeProject;
END



-- View Containing Employee Id And No Of Projects Each Employee Worked On.
-- Used In Many Places 
CREATE VIEW vWEmployeeProjectCnt AS
WITH CTE AS (
	SELECT 
		emp_id,
		COUNT(emp_id) AS no_of_projects
	FROM EmployeeProject
	GROUP BY emp_id
), CTE2 AS(
	SELECT 
		Employee.emp_id,
		CASE
			WHEN CTE.no_of_projects IS NULL THEN 0
			ELSE CTE.no_of_projects
		END no_of_projects
	FROM Employee LEFT JOIN CTE
	ON Employee.emp_id = CTE.emp_id
)
SELECT * FROM CTE2;



--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
-- ASSIGNMENT STARTS FROM HERE
-------------------------------------------------------------------------------------------------------------------
-- Objective 1: Database & Table Creation

CREATE DATABASE DBCompany;
USE DBCompany;

CREATE TABLE Department (
	dept_id INT IDENTITY(1, 1) PRIMARY KEY,
	dept_name VARCHAR(50) NOT NULL DEFAULT NULL
);

CREATE TABLE Employee (
	emp_id INT IDENTITY(1, 1) PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL DEFAULT NULL,
	last_name VARCHAR(50),
	dept_id INT FOREIGN KEY REFERENCES Department(dept_id) ON DELETE CASCADE,
	salary DECIMAL(10, 2) NOT NULL CHECK (salary >= 10000) DEFAULT 10000,
	email VARCHAR(70) NOT NULL UNIQUE DEFAULT NULL,
	hire_date DATE DEFAULT CAST (GETDATE() AS DATE)
);

CREATE TABLE Project (
	project_id INT IDENTITY(101, 1) PRIMARY KEY,
	project_name VARCHAR(50) NOT NULL DEFAULT NULL,
	start_date DATE DEFAULT CAST (GETDATE() AS DATE),
	end_date DATE DEFAULT NULL
);

CREATE TABLE EmployeeProject (
	emp_id INT,
	project_id INT,
	PRIMARY KEY (emp_id, project_id)
);


-------------------------------------------------------------------------------------------------------------------

-- Objective 2:

-- Objective 2.1 -> Insert records into each table.
INSERT INTO Department VALUES
('IT'),
('DevOps'),
('Software Development'),
('Cyber Security');

INSERT INTO Employee VALUES
('Wade', 'Allen', 2, 60000, 'wade@gmail.com', CAST('2018-04-20' AS DATE)),
('Isabel', 'Lopez', 1, 55000, 'isabel@gmail.com', CAST('2014-12-21' AS DATE)),
('Seth', 'Green', 4, 40000, 'seth@gmail.com', CAST('2021-07-11' AS DATE)),
('Ivan', 'Terry', 3, 75000, 'ivan@gmail.com', CAST('2023-02-12' AS DATE)),
('Lucy', 'Shaw', 2, 60000, 'lucy@gmail.com', CAST('2021-01-06' AS DATE)),
('Glen', 'Hamittor', 3, 65000, 'glen@gmail.com', CAST('2023-02-05' AS DATE)),
('Vicki', 'Erick', 3, 70000, 'vicky@gmail.com', CAST('2023-02-05' AS DATE)),
('Molly', 'Duardo', 3, 25000, 'molly@gmail.com', CAST('2021-07-15' AS DATE)),
('Blake', 'Graham', 1, 30000, 'blake@gmail.com', CAST('2020-11-30' AS DATE)),
('Jose', 'White', 2, 25000, 'jose@gmai.com', CAST('2019-04-20' AS DATE)),
('Adam', 'Clark', 3, 90000, 'adam@gmail.com', CAST('2023-02-05' AS DATE)),
('Mila', 'Dean', 1, 40000, 'mila@gmail.com', CAST('2015-08-20' AS DATE)),
('Lisa', 'David', 4, 35000, 'lisa@gmail.com', CAST('2021-12-25' AS DATE)),
('Noah', 'Smith', 4, 15000, 'noah@gmail.com', CAST('2026-01-15' AS DATE)),
('Lory', 'Gross', 2, 35000, 'lory@gmail.com', CAST('2020-12-25' AS DATE)),
('Joseph', 'Harris', 3, 30000, 'jose[h@gmail.com', CAST('2023-01-26' AS DATE)),
('Luis', 'Cooper', 3, 40000, 'luis@gmail.com', CAST('2023-01-26' AS DATE)),
('Dora', 'Perry', 1, 30000, 'dora@gmail.com', CAST('2016-02-28' AS DATE)),
('Pedro', 'Norris', 2, 50000, 'pedro@gmail.com', CAST('2018-04-21' AS DATE)),
('Emma', 'Stanely', 3, 50000, 'emma@gmail.com', CAST('2023-02-14' AS DATE));


INSERT INTO Project VALUES
('IT Asset And Management System', CAST('2016-03-11' AS DATE), CAST('2022-07-20' AS DATE)),
('Network Monitoring Tool', CAST('2021-01-22' AS DATE), NULL),
('Server Maintaince And Automation', CAST('2015-09-11' AS DATE), NULL),
('CI/CD Pipeline Automation', CAST('2019-05-03' AS DATE), CAST('2020-02-23' AS DATE)),
('Cloud Infrastructure Automation', CAST('2021-03-17' AS DATE), CAST('2021-11-12' AS DATE)),
('Monitoring And Logging System', CAST('2018-06-03' AS DATE), CAST('2019-09-15' AS DATE)),
('Employee Management System', CAST('2023-02-17' AS DATE), CAST('2024-05-02' AS DATE)),
('E-Commerce Web Application', CAST('2024-03-11' AS DATE), NULL),
('LMS', CAST('2023-05-06' AS DATE), CAST('2025-01-11' AS DATE)),
('Mobile Banking Application', CAST('2024-07-10' AS DATE), NULL),
('Intrusion Detection System', CAST('2021-08-15' AS DATE), CAST('2023-09-14' AS DATE)),
('Vulnerablity Assessment Tool', CAST('2024-03-22' AS DATE), NULL);

INSERT INTO EmployeeProject VALUES
(2, 101),
(12, 101),
(18, 101),
(9, 102),
(2, 102),
(2, 103),
(12, 103),
(1, 104),
(10, 104),
(19, 104),
(10, 105),
(5, 105),
(19, 105),
(15, 105),
(1, 106),
(5, 106),
(19, 106),
(4, 107),
(6, 107),
(7, 107),
(11, 107),
(16, 107),
(17, 107),
(20, 107),
(4, 108),
(11, 108),
(17, 108),
(20, 108),
(6, 109),
(7, 109),
(11, 109),
(4, 110),
(7, 110),
(8, 110),
(11, 110),
(20, 110),
(3, 111),
(13, 111),
(3, 112);


-- Objective 2.2 -> Update a specific record based on a condition (e.g., increase salary for employees in IT).
-- Update Salary Of Employee From 'IT' Department By 20% 
UPDATE Employee
SET salary = salary * 1.2
WHERE dept_id = (SELECT dept_id FROM Department WHERE dept_name = 'IT');


-- Alternative Query
UPDATE Employee
SET salary = salary * 1.2
WHERE dept_id = (SELECT dept_id
				 FROM Department
				 WHERE dept_name = 'IT' AND Department.dept_id = Employee.dept_id);





-- Resetting DB To Original Values
EXEC spResetTables;
EXEC spShowTables;




-- Objective 2.3 -> Delete a record based on a specific condition.
-- Delete Employees Who Joined In YEAR = 2021 And Working On Atmost 1 project
DELETE FROM Employee
WHERE YEAR(hire_date) = 2021 AND emp_id IN (SELECT 
												emp_id
											FROM vWEmployeeProjectCnt 
											WHERE no_of_projects <= 1);




-- Resetting DB To Original Values
EXEC spResetTables;
EXEC spShowTables;




-- Objective 2.4 -> Implement a transaction (COMMIT, ROLLBACK) for safe modifications.
-- Update Salary Of Each Employees With Department Id = 1 Or 4. 
-- For Department Id 1 -> new_salary = old_salary * (2 - 1/no_of_projects)
-- For Department Id 4 -> new_salary = old_salary * (2 - 1/no_of_projects)

-- In Department 1 There Is No Employee With 0 Projects -> 1st Update Statement Will Get Executed
-- But In Department 4 There Is 1 Employee With 0 Projects -> 1/no_of_projects Will Lead To Divide By Zero Error

BEGIN TRY
	BEGIN TRANSACTION
		UPDATE Employee
		SET Employee.salary = Employee.salary * (2 - (1.00) / (vWEmployeeProjectCnt.no_of_projects * 1.00))
		FROM
		Employee JOIN vWEmployeeProjectCnt
		ON Employee.emp_id = vWEmployeeProjectCnt.emp_id AND Employee.dept_id = 1;

		UPDATE Employee
		SET Employee.salary = Employee.salary * (2 - 1.20 / (vWEmployeeProjectCnt.no_of_projects * 1.00))
		FROM
		Employee JOIN vWEmployeeProjectCnt
		ON Employee.emp_id = vWEmployeeProjectCnt.emp_id AND Employee.dept_id = 4;
		COMMIT;
END TRY
BEGIN CATCH
		ROLLBACK;
END CATCH




-- Resetting DB To Original Values
EXEC spResetTables;
EXEC spShowTables;




-------------------------------------------------------------------------------------------------------------------
-- Objective 3: Stored Procedures & Views

-- Objective 3.1: Create a stored procedure.
-- Create Procedure To Get The Details Of Employee (full name, hire_date and no of projects) 
-- who has worked on maximum number of projects
-- From A Given Department

CREATE PROCEDURE spGetEmployeeWithMaxNoOfProjects
@dept_name VARCHAR(50),
@full_name VARCHAR(50) OUTPUT,
@no_of_projects INT OUTPUT,
@hire_date DATE OUTPUT
AS
BEGIN
	SELECT 
		TOP 1
		@full_name = CONCAT(Employee.first_name, ' ', Employee.last_name), 
		@no_of_projects = vWEmployeeProjectCnt.no_of_projects,
		@hire_date = Employee.hire_date
	FROM
	Employee JOIN Department
	ON Employee.dept_id = Department.dept_id
	JOIN vWEmployeeProjectCnt
	ON Employee.emp_id = vWEmployeeProjectCnt.emp_id
	WHERE Department.dept_name = @dept_name
	ORDER BY no_of_projects DESC;
END

DECLARE @full_name VARCHAR(50);
DECLARE @no_of_projects INT;
DECLARE @hire_date DATE; 
EXEC spGetEmployeeWithMaxNoOfProjects @dept_name = 'DevOps', @full_name = @full_name OUTPUT, @no_of_projects = @no_of_projects OUTPUT, @hire_date = @hire_date OUTPUT
IF(@full_name IS NULL)
	PRINT('Invalid Input');
ELSE
	PRINT('Name: ' + @full_name + ', No Of Projects: ' + CAST(@no_of_projects AS VARCHAR(20)) + ', Hiried Date: ' + CAST(@hire_date AS VARCHAR(20)))





-- Objective 3.2: Create a view.
-- Create View Which Displays Information Like Department Id, Department Name, Average Salary 
-- In Each Department And No Of Employees Working In Each Department
CREATE VIEW vWDeptEmployeeDeatils AS (
	SELECT
		Department.dept_id,
		Department.dept_name,
		COUNT(Department.dept_id) AS no_of_employees,
		CAST(AVG(Employee.salary) AS DECIMAL(10, 2)) AS average_salary
	FROM Department LEFT JOIN Employee
	ON Department.dept_id = Employee.dept_id
	GROUP BY Department.dept_id, Department.dept_name
);

SELECT * FROM vWDeptEmployeeDeatils;




---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Objective 4: Triggers

-- Objective 4.1: Create an AFTER INSERT trigger to log new employee entries into an AuditLog table.
CREATE TABLE AuditLog (
	id INT IDENTITY(1, 1) PRIMARY KEY,
	auditData VARCHAR(300)
);

CREATE TRIGGER tr_Employee_Insert
ON Employee
FOR INSERT
AS
BEGIN
	SELECT * FROM inserted;
	DECLARE @emp_id INT
	SELECT @emp_id = emp_id FROM inserted;
	INSERT INTO AuditLog VALUES
	('A New Employee Record With Employee Id = ' + CAST(@emp_id AS VARCHAR(5))  + ' Is Inserted Into Employee Table On ' + CAST(GETDATE() AS VARCHAR(20))); 
END


-- Trigger For Insert When Multiple Rows Are Inserted
CREATE TRIGGER tr_Employee_InsertMultipleRows
ON Employee
FOR INSERT
AS
BEGIN
	SELECT * INTO #tempTable FROM inserted;
	DECLARE @emp_id INT
	WHILE(EXISTS(SELECT emp_id FROM #tempTable))
	BEGIN
		SELECT @emp_id = emp_id FROM #tempTable;
		INSERT INTO AuditLog VALUES
		('A New Employee Record With Employee Id = ' + CAST(@emp_id AS VARCHAR(5))  + ' Is Inserted Into Employee Table On ' + CAST(GETDATE() AS VARCHAR(20))); 
		DELETE FROM #tempTable WHERE emp_id = @emp_id;
	END
END

INSERT INTO Employee VALUES
('Mike', 'Paul', 2, 16000, 'mike@gmail.com', '2021/04/20'),
('raj', 'Paul', 2, 16000, 'raj@gmail.com', '2021/04/20'),
('riha', 'Paul', 2, 16000, 'riha@gmail.com', '2021/04/20'),


SELECT * FROM AuditLog;

-- Resetting DB To Original Values
EXEC spResetTables;
EXEC spShowTables;


-- Objective 4.2: Implement an INSTEAD OF DELETE trigger to prevent accidental deletion of records.
CREATE TRIGGER tr_EmployeeProject_InsteadOfDelete
ON EmployeeProject
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @old_no_of_rows INT = 0;
	DECLARE @no_of_rows_to_delete INT = 0;
	SELECT @no_of_rows_to_delete = COUNT(*) FROM deleted;
	SELECT @old_no_of_rows = COUNT(*) FROM EmployeeProject;
	if(@old_no_of_rows = @no_of_rows_to_delete)
	BEGIN
		PRINT('Can Not Delete All Records! Please Use Truncate To Force Delete All Records');
		RETURN;
	END
END

DELETE FROM EmployeeProject;




-- Resetting DB To Original Values
EXEC spResetTables;
EXEC spShowTables;




-----------------------------------------------------------------------------------------------------------------------------
-- Objective 5: Cursors
-- Objective 5.1: Write a cursor that loops through employee salaries and applies a bonus based on a certain condition.
-- Update Salary Of Each Employee By 15%
DECLARE EmployeeCursor CURSOR FOR
SELECT
	emp_id
FROM Employee;

DECLARE @emp_id INT;

OPEN EmployeeCursor;

FETCH NEXT FROM EmployeeCursor INTO @emp_id

WHILE(@@FETCH_STATUS = 0)
BEGIN
	UPDATE Employee 
	SET salary = salary * 1.15
	WHERE emp_id = @emp_id
	FETCH NEXT FROM EmployeeCursor INTO @emp_id
END

CLOSE EmployeeCursor;
DEALLOCATE EmployeeCursor;




-- Objective 5.2: Optimize performance by using set-based queries instead of cursors.
UPDATE Employee
SET salary = salary * 1.15
FROM Employee;




-- Resetting DB To Original Values
EXEC spResetTables;
EXEC spShowTables;