CREATE DATABASE LibraryDB;

USE LibraryDB;

CREATE TABLE Books (
	book_id INT IDENTITY(1, 1) PRIMARY KEY,
	book_name VARCHAR(100) NOT NULL,
	genre VARCHAR(100) NOT NULL,
	is_available BIT NOT NULL
);

CREATE TABLE Members (
	member_id INT IDENTITY(101, 1) PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100),
	joined_date DATE NOT NULL,
	gender CHAR(1) NOT NULL
);

CREATE TABLE BorrowingRecords (
	borrowing_id INT IDENTITY(1,1) PRIMARY KEY,
	book_id INT FOREIGN KEY REFERENCES Books(book_id) NOT NULL,
	member_id INT FOREIGN KEY REFERENCES Members(member_id) NOT NULL,
	issued_date DATE NOT NULL,
	due_date DATE NOT NULL,
	returned_date DATE 
);

INSERT INTO Books(book_name, genre, is_available)
VALUES
('Animal Farm', 'Fiction', 1),
('Click', 'Drama', 1),
('Haunting', 'Horror', 0),
('The Shining', 'Horror', 0),
('Ashes', 'Action', 1),
('Hamit', 'Drama', 0),
('Window', 'Thriller', 1),
('Ghost', 'Horror', 1),
('Batman', 'Action', 0),
('The Hobbit', 'Fiction', 1),
('Death Of Sales Man', 'Drama', 1),
('Fire', 'Action', 1),
('Wrong Place', 'Thriller', 1),
('Window', 'Thriller', 1),
('Click', 'Drama', 1);


INSERT INTO Members (first_name, last_name, joined_date, gender)
VALUES
('Johan', 'Oliver', '2024/07/27', 'M'),
('Emily', 'Hart', '2024/09/11', 'F'),
('Zaria', 'Leal', '2024/11/30', 'F'),
('Richard', 'Noah', '2025/02/03', 'M'),
('Ford', 'Lin', '2025/05/17', 'M'),
('Erin', 'Lemon', '2026/01/02', 'M'),
('Elisa', 'Doe', '2026/01/10', 'F');


INSERT INTO BorrowingRecords(book_id, member_id, issued_date, due_date, returned_date)
VALUES
(4, 102, '2024/06/11', '2024/07/11', '2024/06/25'),
(11, 101, '2024/06/20', '2024/06/29', '2024/06/28'),
(1, 101, '2024/07/02', '2024/07/15', '2024/07/13'),
(1, 102, '2024/09/15', '2024/10/25', '2024/10/20'),
(5, 103, '2024/11/23', '2024/12/20', '2024/12/18'),
(12, 107, '2024/12/03', '2024/12/10', '2024/12/11'),
(2, 107, '2024/12/07', '2025/01/07', '2025/01/20'),
(9, 101, '2025/01/03', '2025/02/03', '2025/02/02'),
(5, 102, '2025/05/13', '2025/05/25', '2025/05/21'),
(6, 106, '2025/05/19', '2025/05/21', '2025/05/25'),
(8, 101, '2025/05/27', '2025/06/07', '2025/06/09'),
(7, 101, '2025/05/28', '2025/05/29', '2025/05/29'),
(9, 106, '2025/06/05', '2025/06/23', NULL),
(12, 106, '2025/06/11', '2025/06/15', '2025/06/21'),
(3, 106, '2025/06/21', '2025/07/03', '2025/07/05'),
(2, 103, '2025/11/25', '2025/12/02', '2025/12/01'),
(1, 103, '2025/12/09', '2026/01/05', '2026/01/02'),
(4, 105, '2026/01/10', '2026/01/15', NULL),
(3, 107, '2026/01/10', '2026/01/30', NULL),
(6, 105, '2026/01/10', '2026/01/15', NULL);



SELECT * FROM Books;
SELECT * FROM Members;
SELECT * FROM BorrowingRecords;



-- Fetch Books By Genre
-- Fetch Details Of Books From Genre Action
SELECT 
	*
FROM Books
WHERE genre = 'Action';



-- List Members Who Recently Joined
-- Fetch Details Of Members Who Joined In Last 9 Months
SELECT 
	*,
	DATEDIFF(Month, joined_date, CAST(GETDATE() AS Date)) AS [diff(Months)]
FROM Members
WHERE DATEDIFF(Month, joined_date, CAST(GETDATE() AS Date)) <= 9;



-- Check Book Availability
-- Fetch Details Of Books From Genre Action Which Are Available And Display Them As Available
SELECT 
	book_id,
	book_name,
	CASE
		WHEN is_available = 1 THEN 'Available'
	END AS Availabilty
FROM Books WHERE genre = 'Action' AND is_available = 1;



--Follow Up Query
-- Fetch Details Of Books From Genre Action And If Book Is Available Then Display It As Available Else Not Available
SELECT 
	book_id,
	book_name,
CASE
	WHEN is_available = 1 THEN 'Available'
	ELSE 'Not Available'
END AS Availabilty
FROM Books
WHERE genre = 'Action';



-- Generate Reports On Borrowed Books Using JOIN
-- Display Read Count (By Male Members) For Each Genre, Order List By Read Count From High To Low
WITH CTE1 AS (
SELECT
	BorrowingRecords.book_id,
	Members.gender
FROM 
Members JOIN BorrowingRecords
ON Members.member_id = BorrowingRecords.member_id),
CTE2 AS (
SELECT 
	CTE1.book_id,
	CTE1.gender,
	Books.genre
FROM Books JOIN CTE1
ON CTE1.book_id = Books.book_id)
SELECT 
	CTE2.genre,
	COUNT(CTE2.genre) AS read_count_by_males
FROM CTE2 
WHERE CTE2.gender = 'M'
GROUP BY CTE2.genre
ORDER BY read_count_by_males DESC;



-- Count Total Borrowed Books By Each Member And Display Member Details
SELECT
	Members.member_id,
	Members.first_name,
	Members.last_name,
	COUNT(BorrowingRecords.member_id) AS no_of_borrows
FROM Members LEFT JOIN BorrowingRecords
ON Members.member_id = BorrowingRecords.member_id
GROUP BY Members.member_id, Members.first_name, Members.last_name;


-- Identify Overdue Returns By Each Member And His Member ID
WITH CTE_Over_Dues AS (
SELECT
	*
FROM BorrowingRecords 
WHERE returned_date > due_date )
SELECT
	Members.member_id,
	COUNT(CTE_Over_Dues.member_id) AS over_due_returns
FROM Members LEFT JOIN CTE_Over_Dues
ON Members.member_id = CTE_Over_Dues.member_id
GROUP BY Members.member_id;



-- Extra Queries
-- Display Details Of Members Who Have Not Borrowed Any Book Using NOT IN
SELECT
*
FROM Members
WHERE member_id NOT IN (SELECT DISTINCT(member_id) FROM BorrowingRecords);


-- Display Details Of Books Who Have Not Borrowed By Any One Using NOT EXISTS
SELECT
*
FROM Books
WHERE NOT EXISTS (SELECT 1
				  FROM BorrowingRecords
				  WHERE BorrowingRecords.book_id = books.book_id);


-- Dsiplay Details Of Book Which Is Borrowed Most
SELECT 
* 
FROM Books
WHERE book_id = (SELECT TOP 1
				 book_id
				 FROM BorrowingRecords
				 GROUP BY book_id
				 ORDER BY COUNT(*) DESC);
