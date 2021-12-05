-- CREATING DATABASE ASSIGNMENT -- 
CREATE DATABASE assignment;
USE assignment;


--   CREATING AND POPULATING TABLE SALESPEOPLE -- 
CREATE TABLE SalesPeople(Snum INT PRIMARY KEY, Sname VARCHAR(20) UNIQUE, city VARCHAR(20), Comm INT);
DESCRIBE SalesPeople;
INSERT INTO SalesPeople VALUES(1001,'Peel','London',12),(1002,'Serres','Sanjose',13),
(1004,'Motika','London',11),(1007,'Rifkin','Barcelona',15),
(1003,'Axelrod','Newyork',10);
SELECT * FROM SalesPeople;


-- CREATINF AND POPULATING TABLE CUSTOMERS --  
CREATE TABLE Customers(Cnum INT PRIMARY KEY,Cname VARCHAR(20), City VARCHAR(20) NOT NULL, Snum INT,
FOREIGN KEY(Snum) REFERENCES SalesPeople(Snum) ON DELETE SET NULL);
DESCRIBE Customers;
INSERT INTO Customers VALUES(2001,'Hoffman','London', 1001),
(2002  ,'Giovanni', 'Rome', 1003),
(2003  ,'Liu', 'Sanjose', 1002),
(2004  ,'Grass', 'Berlin', 1002),
(2006 ,'Clemens', 'London', 1001),
(2008 ,'Cisneros', 'Sanjose', 1007),
(2007 ,'Pereira', 'Rome', 1004);
SELECT * FROM Customers;


--  CREATING AND POPULATING TABLE ORDERS -- 
CREATE TABLE Orders(Onum INT PRIMARY KEY,Amt DECIMAL(3,2),Odate DATE,Cnum INT,Snum INT,
FOREIGN KEY(Cnum) REFERENCES Customers(Cnum) ON DELETE SET NULL,
FOREIGN KEY(Snum) REFERENCES SalesPeople(Snum) ON DELETE SET NULL);
DESCRIBE Orders;
INSERT INTO Orders VALUES(3001 ,18.69 ,'1990-10-3', 2008 ,1007),
(3003 ,767.19, '1990-10-3', 2001, 1001),
(3002 ,1900.10, '1990-10-3', 2007, 1004),
(3005  ,5160.45, '1990-10-3', 2003, 1002),
(3006  ,1098.16, '1990-10-3', 2008, 1007),
(3009 ,1713.23 ,'1990-10-4', 2002, 1003),
(3007  ,75.75, '1990-10-4', 2004, 1002),
(3008  ,4273.00, '1990-10-5', 2006, 1001),
(3010  ,1309.95, '1990-10-6', 2004, 1002),
(3011  ,9891.88, '1990-10-6', 2006, 1001);
SELECT * FROM Orders;

-- QS1--> Count the number of Salesperson whose name begin with ‘a’/’A’ -- 
SELECT COUNT(Sname) FROM SalesPeople WHERE Sname LIKE 'A%';

-- 2ND QSN--> Display all the Salesperson whose all orders worth is more than Rs. 2000.--  
SELECT Sname, SUM(Amt) FROM SalesPeople JOIN Orders ON SalesPeople.Snum=Orders.Snum 
GROUP BY Sname HAVING SUM(Amt)>2000;
 
-- 3RD QSN--> Count the number of Salesperson belonging to Newyork. -- 
SELECT COUNT(Sname) FROM SalesPeople WHERE City='Newyork';

-- 4TH QSN--> Display the number of Salespeople belonging to London and belonging to Paris.-- 
SELECT City,COUNT(City) FROM SalesPeople WHERE City='London' OR City='Paris';

-- 5TH QSN--> Display the number of orders taken by each Salesperson and their date of orders.-- 
SELECT Orders.Snum, SalesPeople.Sname,COUNT(Orders.Snum) AS 'NO_OF_ORDERS',
GROUP_CONCAT(Orders.Odate) AS 'ORDER_DATES' FROM SalesPeople
JOIN Orders ON Orders.Snum=SalesPeople.Snum GROUP BY Snum;
