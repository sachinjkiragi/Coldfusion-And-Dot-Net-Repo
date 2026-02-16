CREATE DATABASE DBTemp;
USE DBTemp;

CREATE TABLE Person (
	id INT PRIMARY KEY IDENTITY (1, 1),
	name VARCHAR(50) NOT NULL DEFAULT NULL,
	email VARCHAR(50) NOT NULL DEFAULT NULL UNIQUE,
	phone VARCHAR(10),
	age INT
);

INSERT INTO Person (name, email, phone, age) VALUES
('Amit', 'amit@gmail.com', 9876543210, 23),
('Riya', 'riya@gmail.com', 9123456789, 30),
('Neha', 'neha@gmail.com', 9988776655, 22),
('Rahul', 'rahul@gmail.com', 9012345678, 45);
