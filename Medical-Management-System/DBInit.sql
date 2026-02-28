CREATE DATABASE DBMedicalManagementSystem;
USE DBMedicalManagementSystem;

CREATE USER mms_user FOR LOGIN mms_user;
ALTER ROLE db_owner ADD MEMBER mms_user;

CREATE TABLE Departments (
	department_id INT PRIMARY KEY IDENTITY(1,1),
	department_name VARCHAR(100) NOT NULL
);

CREATE TABLE Roles (
	role_id INT PRIMARY KEY IDENTITY(1,1),
	role_name VARCHAR(50) NOT NULL
);

CREATE TABLE Users(
	user_id INT PRIMARY KEY IDENTITY(1,1),
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30),
	email VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(100) NOT NULL,
	role_id INT,
	gender CHAR(1) NOT NULL,
	phone VARCHAR(10),
	speciality VARCHAR(50),
	department_id INT,
	FOREIGN KEY (role_id) REFERENCES Roles(role_id) ON DELETE NO ACTION ,
	FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE NO ACTION 
);

CREATE TABLE UserPermissions (
	permission_id INT PRIMARY KEY IDENTITY(1,1),
	permission_tag VARCHAR(50) NOT NULL
);

CREATE TABLE Role_Permissions (
	role_id INT NOT NULL,
	permission_id INT NOT NULL,
	PRIMARY KEY (role_id, permission_id),
	FOREIGN KEY (role_id) REFERENCES Roles(role_id) ON DELETE CASCADE,
	FOREIGN KEY (permission_id) REFERENCES UserPermissions(permission_id) ON DELETE NO ACTION 
);

CREATE TABLE Appointments (
	appointment_id INT PRIMARY KEY IDENTITY(1,1),
	doctor_id INT NOT NULL,
	patient_id INT NOT NULL,
	start_time DATETIME NOT NULL,
	end_time DATETIME NOT NULL,
	status VARCHAR(20) NOT NULL,
	appointment_charges DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (doctor_id) REFERENCES Users(user_id) ON DELETE NO ACTION,
	FOREIGN KEY (patient_id) REFERENCES Users(user_id) ON DELETE NO ACTION 
);

CREATE TABLE Prescriptions(
	prescription_id INT PRIMARY KEY IDENTITY(1,1),
	appointment_id INT NOT NULL,
	diagnosis VARCHAR(500),
	diagnosis_notes VARCHAR(MAX),
	digital_signature VARCHAR(500),
	prescription_charges DECIMAL(10,2),
	FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE NO ACTION 
);

CREATE TABLE Medicines (
	medicine_id INT PRIMARY KEY IDENTITY(1,1),
	medicine_name VARCHAR(100) NOT NULL,
	unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Medicine_Prescriptions (
	medicine_id INT NOT NULL,
	prescription_id INT NOT NULL,
	dosage_info VARCHAR(MAX),
	quantity INT NOT NULL,
	PRIMARY KEY (medicine_id, prescription_id),
	FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id) ON DELETE NO ACTION ,
	FOREIGN KEY (prescription_id) REFERENCES Prescriptions(prescription_id)ON DELETE NO ACTION 
);

DROP TABLE IF EXISTS Medicines;
DROP TABLE IF EXISTS Medicine_Prescriptions;
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Role_Permissions;
DROP TABLE IF EXISTS UserPermissions;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Departments;

TRUNCATE TABLE Roles;

INSERT INTO Roles (role_name) VALUES 
('Admin'),
('Doctor'),
('Receptionist'),
('Patient');

INSERT INTO UserPermissions (permission_tag) VALUES
('Create_Departments'),
('View_Departments'),
('Update_Departments'),
('Delete_Departments'),
('Create_Roles'),
('View_Roles'),
('Update_Roles'),
('Delete_Roles'),
('Create_Users'),
('View_Users'),
('Update_Users'),
('Delete_Users'),
('Create_UserPermissions'),
('View_UserPermissions'),
('Update_UserPermissions'),
('Delete_UserPermissions'),
('Create_Role_Permissions'),
('View_Role_Permissions'),
('Update_Role_Permissions'),
('Delete_Role_Permissions'),
('Create_Appointments'),
('View_Appointments'),
('Update_Appointments'),
('Delete_Appointments'),
('Create_Prescriptions'),
('View_Prescriptions'),
('Update_Prescriptions'),
('Delete_Prescriptions'),
('Create_Medicines'),
('View_Medicines'),
('Update_Medicines'),
('Delete_Medicines'),
('Create_Medicine_Prescriptions'),
('View_Medicine_Prescriptions'),
('Update_Medicine_Prescriptions'),
('Delete_Medicine_Prescriptions');

INSERT INTO Departments (department_name) VALUES
('Reception'),
('Cardiology'),
('Neurology'),
('Orthopedics'),
('General Medicine');

INSERT INTO Medicines (medicine_name, unit_price) VALUES
('Paracetamol 500mg', 5.00),
('Amoxicillin 250mg', 12.50),
('Ibuprofen 400mg', 8.75),
('Cough Syrup 100ml', 45.00);