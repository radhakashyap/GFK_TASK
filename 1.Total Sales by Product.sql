--1.Total Sales by Product Write a SQL query to calculate the total sales amount for each product, sorted by the total sales amount in descending order.
SELECT ProductID AS ProductID, SUM(Quantity * Price) AS TotalSalesAmount
FROM Sales_Fact 
GROUP BY ProductID
ORDER BY TotalSalesAmount DESC;

--if we need product name from dimension table
SELECT p.Name AS ProductName, SUM(s.Quantity * s.Price) AS TotalSalesAmount
FROM Sales_Fact s
JOIN Product_Dim p ON s.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalSalesAmount DESC;