--cwiczenia 9

--1
WITH TempEmployeeInfo AS 
(SELECT [FirstName], [LastName], [Rate] FROM AdventureWorks2022.Person.Person
JOIN AdventureWorks2022.HumanResources.EmployeePayHistory ON 
AdventureWorks2022.HumanResources.EmployeePayHistory.BusinessEntityID = Person.Person.BusinessEntityID
)

SELECT FirstName,LastName,TempEmployeeInfo.Rate FROM TempEmployeeInfo 

--2
WITH CompanySalesInfo AS
(
SELECT Customer.CompanyName, SalesOrderDetail.LineTotal AS Revenue,  
	   SalesOrderDetail.SalesOrderID, Customer.FirstName, Customer.LastName
FROM SalesLT.SalesOrderDetail

JOIN SalesLT.SalesOrderHeader ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
JOIN SalesLT.Customer ON SalesOrderHeader.CustomerID = Customer.CustomerID
)

SELECT CONCAT(Customer.CompanyName, ' (', Customer.FirstName, ' ', Customer.LastName, ') ' ) AS CompanyContact, Revenue 
FROM CompanySalesInfo
JOIN SalesLT.SalesOrderHeader ON CompanySalesInfo.SalesOrderID = SalesOrderHeader.SalesOrderID
JOIN SalesLT.Customer ON SalesOrderHeader.CustomerID = Customer.CustomerID

--3
WITH TempTable AS 
( SELECT Name, ProductCategoryID FROM AdventureWorksLT2022.SalesLT.ProductCategory ) 

SELECT TempTable.Name AS Category,SUM(LineTotal) AS SalesValue FROM TempTable
INNER JOIN SalesLT.Product ON Product.ProductCategoryID = TempTable.ProductCategoryID
INNER JOIN SalesLT.SalesOrderDetail ON Product.ProductID = SalesLT.SalesOrderDetail.ProductID
GROUP BY TempTable.Name
