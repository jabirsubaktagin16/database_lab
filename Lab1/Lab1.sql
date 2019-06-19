--CREATE DATABASE labB1;

use labB1;

CREATE TABLE Student
(
ID int,
Name VARCHAR(50),
Phone VARCHAR (50),
Address VARCHAR(100)
);

INSERT INTO Student VALUES(1,'Adam','01611','Dhaka');

CREATE TABLE Person
(
ID int,
FirstName VARCHAR(25),
LastName VARCHAR(25),
Birthday Date,
Address VARCHAR(100),
Salary DECIMAL(7,2)
);
INSERT INTO Person VALUES(1,'Albert','Einstein','1889-03-14','Germany',5000.00);
INSERT INTO Person VALUES(2,'Rabindrantah','Tagore','1861-05-07','India',3000.00);
INSERT INTO Person VALUES(3,'Kazi','Nazrul','1899-05-24','Bangladesh',2000.00);
INSERT INTO Person VALUES(4,'Micheal','Jackson','1958-08-29','USA',70000.00);
INSERT INTO Person VALUES(5,'Shahrukh','Khan','1965-11-02','India',10000.00);