--4.Customer Reach by Retailer Write a SQL query to count the number of unique products sold by each retailer, indicating the diversity
--of their offerings. Sort the results by the count of unique products in descending order.

SELECT r.Name AS RetailerName, COUNT(DISTINCT sf.ProductID) AS UniqueProductsSold
FROM Sales_Fact sf
JOIN Retailer_Dim r ON sf.RetailerID = r.RetailerID
GROUP BY r.Name
ORDER BY UniqueProductsSold DESC;
