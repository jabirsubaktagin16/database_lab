CREATE DATABASE Lab7;
USE Lab7;

--Drop Table Customer_Online;

CREATE TABLE Customer_Online(
	
	CustomerID int IDENTITY(1,1),
	FirstName varchar (50) ,
	LastName varchar (50) ,
	CustomerAddress varchar (50) ,
	City varchar (50) ,
	Country varchar (50) 
);


INSERT INTO Customer_Online
VALUES ('Amy', 'Johnson', '11000 Beecher', 'Joliet',  'USA'),
       ('Bill', 'Brown', '7312 Bettis Ave.', 'Pittsburg','USA'),
       ('Janna', 'Smith', '200 E. Elm Apt. #32', 'Sparks','USA'),
       ('Evette', 'LeBlanc', '207 Queens Quay West', 'Toronto','CA'),
       ('Drew', 'Brisco', '1690 Hollis Street', 'Ottawa','CA')
SELECT * FROM Customer_Online;

--Drop Table Customer_Offline;
USE Lab7;
CREATE TABLE Customer_Offline(
	
	CustomerID int IDENTITY(1,1),
	FirstName varchar (50),
	LastName varchar (50),
	CustomerAddress varchar (50),
	City varchar (50),
	Country varchar (50) 
);


INSERT INTO Customer_Offline
VALUES ('David', 'Link', '567 Queens', 'Vacouver','CA'),
       ('Emily', 'Harper', '456 Elm Apt. #44', 'Dallas',  'USA'),
       ('Criss', 'Witt', '7312 GoergeTown.', 'South Carolina','USA'),
       ('Hansen', 'Jones', '11000 Hampton', 'Edmenton','CA'),
       ('Sophie', 'Watson', '1690 Hollis Street', 'Toronto','CA'),
	   ('Drew', 'Brisco', '1690 Hollis Street', 'Ottawa','CA');
	   SELECT * FROM Customer_Offline;

USE Lab7;
CREATE TABLE Customer(
	
	CustomerID int IDENTITY(1,1),
	FirstName varchar (50),
	LastName varchar (50),
	CustomerAddress varchar (50),
	City varchar (50),
	Country varchar (50)
);

INSERT INTO CUSTOMER 
VALUES ('Amy', 'Johnson', '11000 Beecher', 'Joliet',  'USA'),
       ('Bill', 'Brown', '7312 Bettis Ave.', 'Pittsburg','USA'),
       ('Janna', 'Smith', '200 E. Elm Apt. #32', 'Sparks','USA'),
       ('Evette', 'LeBlanc', '207 Queens Quay West', 'Toronto','CA'),
       ('Drew', 'Brisco', '1690 Hollis Street', 'Ottawa','CA')
       SELECT * FROM Customer;

--Drop Table CustomerOrder
USE Lab7;
CREATE TABLE CustomerOrder(
	
	OrderID int IDENTITY(101,1),
	OrderDate date ,
	CustomerID int,
	Bill money
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
		('2018-11-11' , 4, 8.9500),
		('2018-12-12' , 4, 9.9500)
SELECT * FROM CustomerOrder;

--Intersect--
SELECT FirstName, LastName FROM Customer_Online
INTERSECT
SELECT FirstName, LastName FROM Customer_Offline;

--Except--
SELECT FirstName, LastName FROM Customer_Online
EXCEPT
SELECT FirstName, LastName FROM Customer_Offline;

--Unique--
ALTER TABLE Customer ADD UNIQUE(CustomerID);

--Check--
ALTER TABLE Customer ADD CHECK( CustomerID > 0 );

--Not Null--
ALTER TABLE Customer ALTER COLUMN CustomerID INT NOT NULL;

--Execute Later
Drop TABLE CustomerOrder;
Drop TABLE Customer;

USE Lab7;
CREATE TABLE Customer(
	
	CustomerID int IDENTITY(1,1) not null,
	FirstName varchar (50),
	LastName varchar (50) not null,
	CustomerAddress varchar (50),
	City varchar (50),
	Country varchar (50)
	CONSTRAINT pk_customer PRIMARY KEY(CustomerID, LastName)
);
INSERT INTO CUSTOMER(FirstName,LastName,CustomerAddress,Country) 
VALUES ('Stewart', 'Little', '11000 Beecher', 'USA');
--DEFAULT--
ALTER TABLE Customer ADD CONSTRAINT customer_default DEFAULT 'California' FOR City;
SELECT * FROM Customer;