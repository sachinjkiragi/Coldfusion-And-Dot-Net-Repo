CREATE DATABASE DBMedicalManagementSystem;
USE DBMedicalManagementSystem;

ALTER PROCEDURE spInit
AS
BEGIN
	DROP TABLE IF EXISTS Medicine_Prescriptions;
	DROP TABLE IF EXISTS Prescriptions;
	DROP TABLE IF EXISTS Medicines;
	DROP TABLE IF EXISTS Appointments;
	DROP TABLE IF EXISTS Role_Permissions;
	DROP TABLE IF EXISTS Permissions;
	DROP TABLE IF EXISTS Users;
	DROP TABLE IF EXISTS Roles;
	DROP TABLE IF EXISTS Departments;
	DROP TABLE IF EXISTS All_Slots;
	DROP TABLE IF EXISTS Time_Slots;

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
		department_id INT,
		dob DATE,
		qualification VARCHAR(30),
		FOREIGN KEY (role_id) REFERENCES Roles(role_id) ON DELETE CASCADE ,
		FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE CASCADE
	);

	CREATE TABLE Permissions (
		permission_id INT PRIMARY KEY IDENTITY(1,1),
		permission_tag VARCHAR(50) NOT NULL
	);

	CREATE TABLE Role_Permissions (
		role_id INT NOT NULL,
		permission_id INT NOT NULL,
		PRIMARY KEY (role_id, permission_id),
		FOREIGN KEY (role_id) REFERENCES Roles(role_id) ON DELETE CASCADE,
		FOREIGN KEY (permission_id) REFERENCES Permissions(permission_id) ON DELETE CASCADE
	);


	CREATE TABLE Time_Slots (
		timeslot_id INT PRIMARY KEY IDENTITY(1,1),
		start_time TIME NOT NULL,
		end_time TIME NOT NULL
	);


	CREATE TABLE Appointments (
		appointment_id INT PRIMARY KEY IDENTITY(1,1),
		doctor_id INT NOT NULL,
		patient_id INT NOT NULL,
		status VARCHAR(20) NOT NULL,
		appointment_charges DECIMAL(10,2) NOT NULL,
		timeslot_id INT NOT NULL,
		slot_date DATE NOT NULL,
		FOREIGN KEY (timeslot_id) REFERENCES Time_Slots(timeslot_id) ON DELETE CASCADE,
		FOREIGN KEY (doctor_id) REFERENCES Users(user_id) ON DELETE NO ACTION,
		FOREIGN KEY (patient_id) REFERENCES Users(user_id) ON DELETE NO ACTION
	);

	CREATE TABLE Prescriptions(
		prescription_id INT PRIMARY KEY IDENTITY(1,1),
		appointment_id INT NOT NULL,
		diagnosis VARCHAR(500),
		diagnosis_notes VARCHAR(MAX),
		digital_signature VARCHAR(500),
		FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
	);

	CREATE TABLE Medicines (
		medicine_id INT PRIMARY KEY IDENTITY(1,1),
		medicine_name VARCHAR(100) NOT NULL,
		unit_price DECIMAL(10,2) NOT NULL
	);


	CREATE TABLE Medicine_Prescriptions (
		medicine_id INT,
		prescription_id INT NOT NULL,
		dosage_info VARCHAR(MAX),
		quantity INT NOT NULL,
		PRIMARY KEY (medicine_id, prescription_id),
		FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id) ON DELETE CASCADE,
		FOREIGN KEY (prescription_id) REFERENCES Prescriptions(prescription_id) ON DELETE CASCADE
	);


	INSERT INTO Roles (role_name) VALUES 
	('Admin'),
	('Doctor'),
	('Receptionist'),
	('Patient');

	INSERT INTO Permissions (permission_tag) VALUES
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
	('Cough Syrup 100ml', 45.00),
	('No Medicine', 0.00);

	CREATE TABLE All_Slots (
		slot_id INT PRIMARY KEY IDENTITY(1,1),
		start_time TIME NOT NULL,
		end_time TIME NOT NULL
	);

	INSERT INTO All_Slots (start_time, end_time) VALUES
	('09:00:00','09:30:00'),
	('09:30:00','10:00:00'),
	('10:00:00','10:30:00'),
	('10:30:00','11:00:00'),
	('11:00:00','11:30:00'),
	('11:30:00','12:00:00'),
	('12:00:00','12:30:00'),
	('12:30:00','13:00:00'),
	('13:00:00','13:30:00'),
	('13:30:00','14:00:00'),
	('14:00:00','14:30:00'),
	('14:30:00','15:00:00'),
	('15:00:00','15:30:00'),
	('15:30:00','16:00:00');

	INSERT INTO Time_Slots (start_time, end_time) VALUES
	('09:00:00', '09:30:00'),
	('09:30:00', '10:00:00'),
	('10:00:00', '10:30:00'),
	('10:30:00', '11:00:00'),
	('11:00:00', '11:30:00'),
	('11:30:00', '12:00:00'),
	('14:00:00', '14:30:00'),
	('14:30:00', '15:00:00'),
	('15:00:00', '15:30:00'),
	('15:30:00', '16:00:00');

	INSERT INTO Users 
	(first_name, last_name, email, password, role_id, gender, phone, department_id)
	VALUES
	('Neha', 'Kapoor', 'neha.reception@hospital.com', 'Neha@123', 3, 'F', '9001112222', 1);

	INSERT INTO Users 
	(first_name, last_name, email, password, role_id, gender, phone, department_id, dob, qualification)
	VALUES
	('Dr. Arjun', 'Mehta', 'arjun.mehta@hospital.com', 'Arjun@123', 2, 'M', '9876500001', 2, '1985-06-15', 'MBBS, MD'),
	('Dr. Priya', 'Nair', 'priya.nair@hospital.com', 'Priya@123', 2, 'F', '9876500002', 3, '1988-09-22', 'MBBS, DGO'),
	('Dr. Rohan', 'Singh', 'rohan.singh@hospital.com', 'Rohan@123', 2, 'M', '9876500003', 4, '1982-01-10', 'MBBS, MS'),
	('Dr. Kavya', 'Reddy', 'kavya.reddy@hospital.com', 'Kavya@123', 2, 'F', '9876500004', 5, '1990-03-05', 'MBBS, MD');

	INSERT INTO Users 
	(first_name, last_name, email, password, role_id, gender, phone, department_id, dob, qualification)
	VALUES
	('Rahul', 'Sharma', 'rahul@gmail.com', 'Rahul@123', 4, 'M', '9011111111', NULL, '1995-07-12', NULL),
	('Anita', 'Patel', 'anita@gmail.com', 'Anita@123', 4, 'F', '9022222222', NULL, '1992-11-30', NULL),
	('Vikram', 'Joshi', 'vikram@gmail.com', 'Vikram@123', 4, 'M', '9033333333', NULL, '1989-04-18', NULL),
	('Sneha', 'Iyer', 'sneha@gmail.com', 'Sneha@123', 4, 'F', '9044444444', NULL, '1998-02-25', NULL),
	('Manoj', 'Kumar', 'manoj@gmail.com', 'Manoj@123', 4, 'M', '9055555555', NULL, '1987-12-09', NULL);

	INSERT INTO Appointments
	(doctor_id, patient_id, status, appointment_charges, timeslot_id, slot_date)
	VALUES
	(2, 6, 'Booked', 500.00, 1, '2026-03-10'),
	(3, 7, 'Booked', 600.00, 2, '2026-03-10'),
	(4, 8, 'Completed', 450.00, 3, '2026-03-11'),
	(5, 9, 'Booked', 700.00, 4, '2026-03-11'),
	(2, 10, 'Cancelled', 500.00, 7, '2026-03-12'),
	(3, 6, 'Booked', 600.00, 8, '2026-03-12');


	INSERT INTO Prescriptions 
	(appointment_id, diagnosis, diagnosis_notes, digital_signature)
	VALUES
	(3, 'Headache', 'Stress related headache. Maintain hydration.', 'Dr. Rohan Singh'),
	(5, 'Viral Fever', 'Body pain and fever for 3 days.', 'Dr. Arjun Mehta'),
	(6, 'Cold & Cough', 'Mild cough with throat irritation.', 'Dr. Priya Nair'),
	(1, 'Migraine', 'Recurring migraine episodes.', 'Dr. Arjun Mehta'),
	(2, 'Gastric Issue', 'Acidity and bloating.', 'Dr. Priya Nair'),
	(4, 'Knee Pain', 'Inflammation in knee joint.', 'Dr. Rohan Singh'),
	(6, 'Allergy', 'Seasonal allergy symptoms.', 'Dr. Priya Nair'),
	(5, 'Muscle Pain', 'Post-exercise muscle soreness.', 'Dr. Arjun Mehta');

	INSERT INTO Medicine_Prescriptions (medicine_id, prescription_id, dosage_info, quantity) VALUES
	(3,5,'1 tablet twice daily after food',6),
	(1,1,'1 tablet three times daily',9),
	(1,6,'1 tablet twice daily',6),
	(3,2,'1 tablet during migraine attack',5),
	(2,3,'1 capsule before food twice daily',10),
	(3,4,'1 tablet twice daily',8),
	(2,8,'1 capsule once daily',5),
	(1,7,'1 tablet if fever occurs',4);


	INSERT INTO Users 
	(first_name, last_name, email, password, role_id, gender, phone, department_id)
	VALUES
	('Admin', 'User', 'admin@hospital.com', 'E86F78A8A3CAF0B60D8E74E5942AA6D86DC150CD3C03338AEF25B7D2D7E3ACC7', 1, 'M', '9999999999', NULL);


	INSERT INTO Role_Permissions (role_id, permission_id)
	SELECT 3, permission_id
	FROM Permissions
	WHERE permission_tag IN (
	'View_Users',
	'Create_Users',
	'Update_Users',
	'Delete_Users',
	'View_Appointments',
	'Create_Appointments',
	'Update_Appointments'
	);

	INSERT INTO Role_Permissions (role_id, permission_id)
	SELECT 4, permission_id
	FROM Permissions
	WHERE permission_tag IN (
	'View_Appointments',
	'View_Prescriptions',
	'View_Medicine_Prescriptions'
	);

	INSERT INTO Role_Permissions (role_id, permission_id)
	SELECT 2, permission_id
	FROM Permissions
	WHERE permission_tag IN (
	'View_Appointments',
	'Update_Appointments',
	'View_Medicines',
	'View_Prescriptions',
	'Create_Prescriptions',
	'Update_Prescriptions',
	'View_Medicine_Prescriptions',
	'Create_Medicine_Prescriptions',
	'Update_Medicine_Prescriptions'
	);

	CREATE INDEX idx_email
	ON Users (email);
END

EXEC spInit;

SELECT * FROM Users;

SELECT * FROM Roles;
SELECT * FROM Appointments;