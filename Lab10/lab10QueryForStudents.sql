CREATE DATABASE Lab10;
USE Lab10;

DROP TABLE Customer;
CREATE TABLE Customer(
	
	CustomerID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName varchar (50) ,
	LastName varchar (50) ,
	CustomerAddress varchar (50) ,
	City varchar (50) ,
	Country varchar (50)
);

INSERT INTO CUSTOMER 
VALUES ('Amy', 'Johnson', '11000 Beecher', 'Joliet',  'USA'),
       ('Bill', 'Brown', '7312 Bettis Ave.', 'Pittsburg','USA'),
       ('Janna', 'Smith', '200 E. Elm Apt. #32', 'Sparks','USA'),
       ('Evette', 'LeBlanc', '207 Queens Quay West', 'Toronto','CA'),
       ('Drew', 'Brisco', '1690 Hollis Street', 'Ottawa','CA')

SELECT * FROM CUSTOMER;

DROP TABLE CustomerOrder;

CREATE TABLE CustomerOrder(
	
	OrderID int IDENTITY(101,1) NOT NULL PRIMARY KEY,
	OrderDate date ,
	CustomerID int NOT NULL,
	Bill money ,
	Country varchar (50) ,
	SalesmanId int NOT NULL
);


INSERT INTO CustomerOrder
VALUES  ('2019-01-13' , 3, 12.9500, 'USA',1005),
		('2019-01-12' , 5, 7.9500 , 'CA',1002),
		('2019-01-05' , 2, 9.9500 , 'USA',1003),
		('2019-01-07' , 1, 12.9500 , 'USA',1001),
		('2019-01-09' , 5, 7.9500 , 'CA',1005),
		('2019-01-04' , 1, 7.9500 , 'USA',1003),
		('2019-01-04' , 5, 7.9500 , 'CA',1004),
		('2019-01-06' , 2, 12.9500 , 'USA',1004),
		('2019-01-07' , 3,  9.9500 , 'USA',1005),
		('2019-01-08' , 3,  5.9500 , 'USA',1001),
		('2018-11-11' , 9, 8.9500 , 'CA',1004),
		('2018-12-12' , 8, 9.9500 , 'CA',1002)

Select * From CUSTOMERORDER;

Drop table Salesman
CREATE TABLE  Salesman(
	SalesmanId Int PRIMARY KEY IDENTITY(1001,1),
	FirstName varchar(50) ,
	LastName varchar(50) ,
	Area varchar(15) ,
	YearOfService Int ,
	Salary Decimal(7,2)
)


INSERT INTO Salesman VALUES ('Nicholas', 'Graham', 'Mirpur', 5, 20000),
							('Rachel', 'Wood', 'Dhanmondi', 9, 40000),
							('Emily', 'Blunt', 'Shantinagar', 8, 35000),
							('Robert', 'Smith', 'Gulshan', 11, 50000),
							('Amy', 'Watson', 'Banani', 3, 15000);

select * from Salesman;

--Subqueries that return only one value--
SELECT * FROM Customer WHERE
CustomerID=(SELECT CustomerID
FROM CustomerOrder WHERE OrderDate='2019-01-13');

SELECT * FROM Customer WHERE
CustomerID<=(SELECT CustomerID
FROM CustomerOrder WHERE OrderDate='2019-01-13');

--Using Between--
SELECT * FROM Customer WHERE
CustomerID BETWEEN (SELECT CustomerID
FROM CustomerOrder WHERE OrderDate='2019-01-13')
AND 5;

SELECT * FROM Customer WHERE
CustomerID BETWEEN (SELECT CustomerID
FROM CustomerOrder WHERE OrderDate='2019-01-13')
AND 
(SELECT CustomerID
FROM CustomerOrder WHERE OrderDate='2019-01-12');

--Subqueries that return multiple values--
SELECT * FROM Customer WHERE
CustomerID IN (SELECT CustomerID
FROM CustomerOrder WHERE Bill>10);

--Any Keyword--
SELECT * FROM Customer WHERE
CustomerID > ANY (SELECT CustomerID
FROM CustomerOrder WHERE Bill>10);

--Some Keyword--
SELECT * FROM Customer WHERE
CustomerID > SOME (SELECT CustomerID
FROM CustomerOrder WHERE Bill>10);

--ALL Keyword--
SELECT * FROM Customer WHERE
CustomerID > ALL (SELECT CustomerID
FROM CustomerOrder WHERE Bill>10);

--ORDER BY Error_GROUP BY--
SELECT * FROM Customer WHERE
CustomerID IN (SELECT CustomerID
FROM CustomerOrder WHERE Bill>10 GROUP BY CustomerID);

--Aggregate Functions--
SELECT CustomerID FROM CustomerOrder
GROUP BY CustomerID HAVING
AVG(BILL)>(SELECT AVG(BILL) FROM CustomerOrder);

 --Nested Subqueries--
 --Show the OrderIDs of the Orders Placed Under the Salesmen whose salary is more than the average of all salesmen --
 SELECT OrderID FROM CustomerOrder
 WHERE SalesmanId IN (SELECT SalesmanId
 FROM Salesman WHERE Salary>(SELECT AVG(SALARY)
 FROM Salesman));

 --Show the FirstName , LastName of those Customers who are attended by Salesman whose salary is greater than 30,000--
 SELECT FirstName,LastName FROM Customer
 WHERE CustomerID IN(
 SELECT CustomerID FROM CustomerOrder
 WHERE SalesmanId=ANY(
 SELECT SalesmanId FROM Salesman WHERE SALARY>30000));

 --EXISTS Keyword--
 SELECT * FROM Customer WHERE
 EXISTS(SELECT CustomerID
 FROM CustomerOrder
 WHERE Bill>10);

 --NOT EXISTS Keyword--
 SELECT * FROM Customer WHERE
 NOT EXISTS(SELECT CustomerID
 FROM CustomerOrder
 WHERE Bill>10);

 --A subquery can also be found in the Select clause.--
 SELECT CustomerID,FirstName,
 (SELECT SUM(Bill) FROM CustomerOrder
 WHERE Customer.CustomerID=CustomerOrder.CustomerID
 GROUP BY CustomerID) AS TotalBill
 FROM Customer;

 --Renaming the table--
 SELECT CustomerID,FirstName,
 (SELECT SUM(Bill) FROM CustomerOrder c2
 WHERE c1.CustomerID=c2.CustomerID
 GROUP BY CustomerID) AS TotalBill
 FROM Customer c1;

 --A subquery can also be found in the FROM clause--
 SELECT Customer.CustomerID,subquery.total_amt
 from Customer,
 (SELECT CustomerOrder.CustomerID,Sum(CustomerOrder.Bill) as total_amt
 from CustomerOrder
 group by CustomerID) subquery
 WHERE subquery.CustomerID=Customer.CustomerID;

 --Subquery in Insert Statement--
 INSERT INTO Customer(FirstName,LastName)
 SELECT FirstName,LastName FROM Customer
 WHERE CustomerID IN (SELECT CustomerID
 FROM CustomerOrder
 GROUP BY CustomerID HAVING AVG(BILL)>10);

--Subquery in Update Statement--
UPDATE Customer
SET Country='USA'
Where FirstName IN (SELECT FirstName FROM
Customer WHERE CustomerID>5);
SELECT * FROM Customer;

--Subquery in Delete Statement--
DELETE FROM Customer
WHERE CustomerID Not IN
(SELECT CustomerID FROM CustomerOrder);