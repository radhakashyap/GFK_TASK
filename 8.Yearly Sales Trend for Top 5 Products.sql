--8.Yearly Sales Trend for Top 5 Products Identify the top 5 products by total sales amount across all time, then write a SQL query to
--show the yearly sales trend for these top products. Include product name, year, and total sales amount in the output, sorted by product and year.

WITH RankedProducts AS (
    SELECT
        ProductID,
        SUM(Quantity * Price) AS TotalSalesAmount,
        RANK() OVER (ORDER BY SUM(Quantity * Price) DESC) AS SalesRank
    FROM
        Sales_Fact
    GROUP BY
        ProductID
)
SELECT
    rp.ProductID,
    pd.Name AS ProductName,
    YEAR(sf.Date) AS SalesYear,
    SUM(sf.Quantity * sf.Price) AS TotalSalesAmount
FROM
    Sales_Fact sf
JOIN
    RankedProducts rp ON sf.ProductID = rp.ProductID
JOIN
    Product_Dim pd ON sf.ProductID = pd.ProductID
WHERE
    rp.SalesRank <= 5
GROUP BY
    rp.ProductID, pd.Name, YEAR(sf.Date)
ORDER BY
    rp.ProductID, SalesYear;
