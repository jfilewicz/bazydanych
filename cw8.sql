CREATE FUNCTION f_fibonacci(@n INT)
RETURNS TABLE
AS
RETURN
(
	WITH fib AS
    (
        SELECT 1 AS n, 1 AS fibonacci
        UNION ALL
        SELECT 2 AS n, 1 AS fibonacci
        UNION ALL
        SELECT n, fibonacci + LAG(fibonacci) OVER (ORDER BY n) AS fibonacci
        FROM fib
        WHERE n < @n
    )
    SELECT n, fibonacci FROM fib
);

CREATE PROCEDURE print_fibonacci
    @n INT
AS
BEGIN
    DECLARE @fibonacci INT;

    PRINT @n;

    SELECT n, fibonacci
	INTO t_fib
    FROM f_fibonacci(@n);

    DECLARE @i INT = 1;
    WHILE @i <= @n
    BEGIN
        SELECT @fibonacci = fibonacci FROM t_fib WHERE n = @i;
		PRINT @fibonacci;
		SET @i = @i + 1;  
    END;
	DROP TABLE t_fib;
END;

--zadanie2
USE AdventureWorks2022; 

CREATE TRIGGER person_uppercase
ON Person.Person
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Person.Person
    SET LastName = UPPER(i.LastName)
    FROM inserted i
    WHERE Person.BusinessEntityID = i.BusinessEntityID;
END;

--zadanie3

USE AdventureWorks2022; 

CREATE TRIGGER tax
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @old_tax DECIMAL(6,4);
    DECLARE @new_tax DECIMAL(6,4);
    
    SELECT @old_tax = TaxRate
    FROM deleted;

    SELECT @new_tax = TaxRate
    FROM inserted;

    IF ABS(@old_tax - @new_tax) > 0.30
    BEGIN
        THROW 123456789, 'zamiana wartoœci w polu TaxRate o wiêcej ni¿ 30% ', 1;
        ROLLBACK;
    END;
END;


