--5.Most Profitable Retailer Location Write a SQL query to determine the most profitable location for each retailer, based on 
--the total sales amount. Group the results by retailer and location, and sort by the total sales amount in descending order.

SELECT r.Name AS RetailerName, r.Location, SUM(sf.Quantity * sf.Price) AS TotalSalesAmount
FROM Sales_Fact sf
JOIN Retailer_Dim r ON sf.RetailerID = r.RetailerID
GROUP BY r.Name, r.Location
ORDER BY TotalSalesAmount DESC;