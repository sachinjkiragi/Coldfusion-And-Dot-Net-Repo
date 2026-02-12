CREATE DATABASE DBEms;
USE DBEms;

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



CREATE PROCEDURE spGetEmployeeByDept
@dept_id INT
AS
BEGIN
	SELECT 
        emp_id,
        first_name,
        last_name,
        dept_name,
        salary,
        email,
        hire_date
        FROM Employee JOIN Department
        ON employee.dept_id = Department.dept_id
        WHERE employee.dept_id = @dept_id;
END


CREATE PROCEDURE spEmployeeCrud
@emp_id INT,
@first_name VARCHAR(50),
@last_name VARCHAR(50),
@dept_id INT,
@salary DECIMAL(10, 2),
@email VARCHAR(70),
@hire_date DATE,
@operation INT
AS
BEGIN
     IF(@operation = 0)
        SELECT 
            emp_id,
            first_name,
            last_name,
            dept_name,
            salary,
            email,
            hire_date
        FROM Employee JOIN Department
        ON employee.dept_id = Department.dept_id;
    ELSE IF(@operation = 1)
		INSERT INTO Employee
		VALUES
		(@first_name, @last_name, @dept_id, @salary, @email, @hire_date)
    ELSE IF(@operation = 2)
		UPDATE Employee
            SET 
            first_name = @first_name,
            last_name = @last_name,
            dept_id = @dept_id,
            salary = @salary,
            email = @email,
            hire_date = @hire_date
            WHERE emp_id = @emp_id;
    ELSE 
        DELETE FROM Employee
        WHERE emp_id = @emp_id;
END