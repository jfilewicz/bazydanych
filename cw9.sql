--cwiczenia 9

--1
WITH TempEmployeeInfo AS 
(SELECT [FirstName], [LastName], [Rate] FROM AdventureWorks2022.Person.Person
JOIN AdventureWorks2022.HumanResources.EmployeePayHistory ON 
AdventureWorks2022.HumanResources.EmployeePayHistory.BusinessEntityID = Person.Person.BusinessEntityID
)

SELECT FirstName,LastName,TempEmployeeInfo.Rate FROM TempEmployeeInfo 

--2
WITH TempRevTable AS (
SELECT CONCAT( SalesLT.Customer.CompanyName, ' (', Customer.FirstName, ' ', Customer.LastName, ')' )
AS CompanyContact, 
SUM(SalesLT.SalesOrderDetail.UnitPrice * SalesLT.SalesOrderDetail.OrderQty) AS Revenue 
FROM SalesLT.SalesOrderDetail
JOIN SalesLT.SalesOrderHeader ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
JOIN SalesLT.Customer ON Customer.CustomerID = SalesOrderHeader.CustomerID 
GROUP BY CompanyName,Customer.FirstName,Customer.LastName
) 

Select * FROM TempRevTable

--3
WITH TempTable AS 
( SELECT Name, ProductCategoryID FROM AdventureWorksLT2022.SalesLT.ProductCategory ) 

SELECT TempTable.Name AS Category,SUM(LineTotal) AS SalesValue FROM TempTable
INNER JOIN SalesLT.Product ON Product.ProductCategoryID = TempTable.ProductCategoryID
INNER JOIN SalesLT.SalesOrderDetail ON Product.ProductID = SalesLT.SalesOrderDetail.ProductID
GROUP BY TempTable.Name
