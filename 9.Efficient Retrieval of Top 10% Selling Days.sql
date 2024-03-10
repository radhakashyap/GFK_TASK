--9.Efficient Retrieval of Top 10% Selling Days Write a SQL query to identify the top 10% of days with the highest total sales volume.
--Consider an efficient way to perform this percentile calculation and sort the results by date.

WITH RankedDays AS (
    SELECT
        Date,
        SUM(Quantity * Price) AS TotalSales,
        PERCENT_RANK() OVER (ORDER BY SUM(Quantity * Price) DESC) AS SalesPercentRank
    FROM
        Sales_Fact
    GROUP BY
        Date
)
SELECT
    Date,
    TotalSales
FROM
    RankedDays
WHERE
    SalesPercentRank <= 0.1
ORDER BY
    Date;