USE AdventureWorks2022

--1
BEGIN TRANSACTION;
UPDATE Production.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductID = 680;
COMMIT TRANSACTION;

--3
BEGIN TRANSACTION;
INSERT INTO Production.Product(Name, ProductNumber, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate)
VALUES('NewProduct', 'PN-1234', 'Black', 1000, 123, 22, 11, 1, GETDATE());
COMMIT TRANSACTION;

--2
BEGIN TRANSACTION;
DELETE FROM Production.Product
WHERE ProductID = 1006;
ROLLBACK TRANSACTION;

--4
BEGIN TRANSACTION;
UPDATE Production.Product
SET StandardCost = StandardCost * 1.1;
IF(SELECT SUM(StandardCost) FROM Production.Product) <= 50000
COMMIT TRANSACTION;
ELSE
ROLLBACK TRANSACTION;

--5
BEGIN TRANSACTION;
DROP INDEX AK_Product_ProductNumber 
ON Production.Product;
INSERT INTO Production.Product(Name, ProductNumber, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate)
VALUES('NewProduct2', 'PN-2234', 'Silver', 1000, 123, 22, 11, 1, GETDATE());
IF EXISTS (SELECT ProductNumber FROM Production.Product WHERE ProductNumber = 'PN-2234')
ROLLBACK TRANSACTION;
ELSE
COMMIT TRANSACTION;

--6
BEGIN TRANSACTION;
UPDATE Sales.SalesOrderDetail
SET OrderQty = OrderQty + 1;
IF EXISTS (SELECT OrderQty FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
ROLLBACK TRANSACTION;
ELSE
COMMIT TRANSACTION;

--7
BEGIN TRANSACTION;
SELECT StandardCost FROM Production.Product
DECLARE @ilosc INT
SELECT @ilosc = @@ROWCOUNT FROM Production.Product
DELETE FROM Production.Product
WHERE StandardCost > ( SELECT AVG(Product.StandardCost) FROM Production.Product )

SELECT StandardCost FROM Production.Product
DECLARE @nowailosc INT
SELECT @nowailosc = @@ROWCOUNT FROM Production.Product

IF ( @ilosc - @nowailosc > 10 )
BEGIN 
ROLLBACK TRANSACTION;
END

ELSE
BEGIN
COMMIT TRANSACTION;
END;

