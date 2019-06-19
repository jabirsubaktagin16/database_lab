CREATE DATABASE Lab6;
USE Lab6;

-------------------------Tables for JOIN Operation--------------------------------

--DROP TABLE Customer;
CREATE TABLE Customer(
	
	CustomerID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName varchar (50) NOT NULL,
	LastName varchar (50) NOT NULL,
	CustomerAddress varchar (50) NOT NULL,
	City varchar (50) NOT NULL,
	Country varchar (50) NOT NULL
);

INSERT INTO CUSTOMER 
VALUES ('Amy', 'Johnson', '11000 Beecher', 'Joliet',  'USA'),
       ('Bill', 'Brown', '7312 Bettis Ave.', 'Pittsburg','USA'),
       ('Janna', 'Smith', '200 E. Elm Apt. #32', 'Sparks','USA'),
       ('Evette', 'LeBlanc', '207 Queens Quay West', 'Toronto','CA'),
       ('Drew', 'Brisco', '1690 Hollis Street', 'Ottawa','CA')
	   
SELECT * FROM Customer;	   
--DROP TABLE CustomerOrder;
USE Lab6;
CREATE TABLE CustomerOrder(
	
	OrderID int IDENTITY(101,1) NOT NULL PRIMARY KEY,
	OrderDate date NOT NULL,
	CustomerID int NOT NULL,
	Bill money NOT NULL
);


INSERT INTO CustomerOrder
VALUES  ('2019-01-13' , 3, 12.9500),
		('2019-01-12' , 5, 7.9500),
		('2019-01-05' , 2, 9.9500),
		('2019-01-07' , 1, 12.9500),
		('2019-01-09' , 5, 7.9500),
		('2019-01-04' , 1, 7.9500),
		('2019-01-04' , 5, 7.9500),
		('2019-01-06' , 2, 12.9500),
		('2019-01-07' , 3,  9.9500),
		('2019-01-08' , 3,  5.9500),
		('2018-11-11' , 9, 8.9500),
		('2018-12-12' , 8, 9.9500)
		
SELECT * FROM CustomerOrder;		
		
		
-------------------------Tables for UNION Operation--------------------------
USE Lab6;
CREATE TABLE Customer_Online(
	
	CustomerID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName varchar (50) NOT NULL,
	LastName varchar (50) NOT NULL,
	CustomerAddress varchar (50) NOT NULL,
	City varchar (50) NOT NULL,
	Country varchar (50) NOT NULL
);


INSERT INTO Customer_Online
VALUES ('Amy', 'Johnson', '11000 Beecher', 'Joliet',  'USA'),
       ('Bill', 'Brown', '7312 Bettis Ave.', 'Pittsburg','USA'),
       ('Janna', 'Smith', '200 E. Elm Apt. #32', 'Sparks','USA'),
       ('Evette', 'LeBlanc', '207 Queens Quay West', 'Toronto','CA'),
       ('Drew', 'Brisco', '1690 Hollis Street', 'Ottawa','CA')
SELECT * FROM Customer_Online;

USE Lab6;
CREATE TABLE Customer_Offline(
	
	CustomerID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName varchar (50) NOT NULL,
	LastName varchar (50) NOT NULL,
	CustomerAddress varchar (50) NOT NULL,
	City varchar (50) NOT NULL,
	Country varchar (50) NOT NULL
);


INSERT INTO Customer_Offline
VALUES ('David', 'Link', '567 Queens', 'Vacouver','CA'),
       ('Emily', 'Harper', '456 Elm Apt. #44', 'Dallas',  'USA'),
       ('Criss', 'Witt', '7312 GoergeTown.', 'South Carolina','USA'),
       ('Hansen', 'Jones', '11000 Hampton', 'Edmenton','CA'),
       ('Sophie', 'Watson', '1690 Hollis Street', 'Toronto','CA'),
	   ('Drew', 'Brisco', '1690 Hollis Street', 'Ottawa','CA')
SELECT * FROM Customer_Offline;	   
	   
--Different Column Names can also be used in UNION if the datatype is same	   
USE Lab6;	   
CREATE TABLE CLIENT(
	
	ClientID int IDENTITY(500,1) NOT NULL PRIMARY KEY,
	ClientFirstName varchar (50) NOT NULL,
	ClientLastName varchar (50) NOT NULL,
	ClientAddress varchar (50) NOT NULL,
	ClientCity varchar (50) NOT NULL,
	ClientCountry varchar (50) NOT NULL
);

INSERT INTO CLIENT
VALUES ('David', 'Link', '567 Queens', 'Vacouver','CA'),
       ('Emily', 'Harper', '456 Elm Apt. #44', 'Dallas',  'USA'),
       ('Criss', 'Witt', '7312 GoergeTown.', 'South Carolina','USA'),
       ('Hansen', 'Jones', '11000 Hampton', 'Edmenton','CA'),
       ('Sophie', 'Watson', '1690 Hollis Street', 'Toronto','CA'),
	   ('Drew', 'Brisco', '1690 Hollis Street', 'Ottawa','CA')

--Inner Join--
SELECT Customer.LastName, Customer.FirstName, CustomerOrder.Bill
FROM Customer INNER JOIN CustomerOrder
ON Customer.CustomerID=CustomerOrder.CustomerID;

--Left Join--
SELECT Customer.LastName, Customer.FirstName, CustomerOrder.Bill
FROM Customer
LEFT JOIN CustomerOrder
ON Customer.CustomerID=CustomerOrder.CustomerID;

--Right Join--
SELECT Customer.CustomerID,Customer.LastName, Customer.FirstName, CustomerOrder.Bill
FROM Customer
RIGHT JOIN CustomerOrder
ON Customer.CustomerID=CustomerOrder.CustomerID;

--Full Join--
SELECT Customer.LastName, Customer.FirstName,CustomerOrder.Bill
FROM Customer
FULL JOIN CustomerOrder
ON Customer.CustomerID=CustomerOrder.CustomerID
ORDER BY Customer.LastName;

--UNION--
SELECT FirstName, LastName FROM Customer_Online
UNION
SELECT FirstName, LastName FROM Customer_Offline;

--UNION ALL--
SELECT FirstName, LastName FROM Customer_Online
UNION ALL
SELECT FirstName, LastName FROM Customer_Offline;

--Task 1--
SELECT Customer.CustomerID,Customer.LastName,Customer.FirstName,CustomerOrder.Bill 
FROM Customer 
INNER JOIN CustomerOrder
ON Customer.CustomerID=CustomerOrder.CustomerID
WHERE Customer.LastName IN('Brown','Smith','Brisco')
ORDER BY CustomerID;

--Task 2--
SELECT Customer.CustomerID,Customer.FirstName,Customer.LastName,SUM(CustomerOrder.Bill)AS 'Total Bill'
FROM Customer
INNER JOIN CustomerOrder
ON Customer.CustomerID=CustomerOrder.CustomerID
Group By Customer.CustomerID,Customer.FirstName,Customer.LastName;

--Task 3--
SELECT Customer.CustomerID,Customer.FirstName,Customer.LastName,SUM(CustomerOrder.Bill)AS 'Total Bill'
FROM Customer
INNER JOIN CustomerOrder
ON Customer.CustomerID=CustomerOrder.CustomerID
WHERE CustomerOrder.OrderDate>='2019-01-10'
Group By Customer.CustomerID,Customer.FirstName,Customer.LastName;

--Task 4--
SELECT Customer.CustomerID,Customer.FirstName,Customer.LastName,SUM(CustomerOrder.Bill)AS 'Total Bill'
FROM Customer
INNER JOIN CustomerOrder
ON Customer.CustomerID=CustomerOrder.CustomerID
WHERE CustomerOrder.OrderDate>='2019-01-10'
Group By Customer.CustomerID,Customer.FirstName,Customer.LastName
HAVING SUM(CustomerOrder.Bill)>10;
