--------------------------------------------------------------------------------------
--Exercise 1: Using the TOP n Keyword
--------------------------------------------------------------------------------------
USE Northwind

SELECT Top 10 with ties [OrderID], (unitprice * quantity) AS Totalsale
 FROM [order details]
 ORDER BY (unitprice * quantity) DESC
GO
--------------------------------------------------------------------------------------
--    Summarizing Data
--   EXERCISE 2:  Using the GROUP BY and HAVING Clauses
--------------------------------------------------------------------------------------
USE northwind

SELECT orderid, SUM(quantity) AS total_quantity
 FROM [order details] AS od
 INNER JOIN products
 ON od.productid = products.productid
 GROUP BY orderid 
 Having SUM(quantity) > 250	--���z��B��L�����A�����ϥ�having��k
GO
--------------------------------------------------------------------------------------
--    Summarizing Data
--   EXERCISE 3:  Using the ROLLUP and CUBE Operators
--------------------------------------------------------------------------------------
USE northwind

SELECT productid, Grouping(ProductID) as '�e�@�欰�p�por���',orderid,Grouping(OrderID) as '�e�@�欰�p�por���', SUM(quantity) AS total_quantity
 FROM [order details]
 --Where ProductID = 50
 GROUP BY productid, orderid
 WITH Cube
 ORDER BY productid, orderid
GO
-----------------------------------------------------------------------