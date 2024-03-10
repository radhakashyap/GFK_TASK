--2.Average Sales Price by Product Write a SQL query to calculate the average selling price of each product, along with the product name.
--Sort the results by the average selling price in descending order. Consider how to efficiently handle any variations in price.

SELECT p.Name AS Product_Name, AVG(s.Price) AS Avg_SellingPrice
FROM Sales_Fact s
JOIN Product_Dim p ON s.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY Avg_SellingPrice DESC;