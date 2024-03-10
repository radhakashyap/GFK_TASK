--6.Monthly Sales Comparison to Previous Year Write a SQL query that compares the total sales amount for each month to the same month in 
--the previous year. The result should include the month, year, total sales for the current month, total sales for the same month previous year,
-- and the growth or decline percentage.
WITH CurrentYear AS (
    SELECT
        MONTH(Date) AS Month,
        YEAR(Date) AS Year,
        SUM(Quantity * Price) AS CurrentMonthSales
    FROM
        Sales_Fact
    GROUP BY
        MONTH(Date),
        YEAR(Date)
),
PreviousYear AS (
    SELECT
        MONTH(Date) AS Month,
        YEAR(Date) AS Year,
        SUM(Quantity * Price) AS PreviousMonthSales
    FROM
        Sales_Fact
    WHERE
        YEAR(Date) = (SELECT MAX(YEAR(Date)) - 1 FROM Sales_Fact)
    GROUP BY
        MONTH(Date),
        YEAR(Date)
)
SELECT
    c.Month,
    c.Year AS CurrentYear,
    c.CurrentMonthSales,
    p.Year AS PreviousYear,
    p.PreviousMonthSales,
    CASE
        WHEN p.PreviousMonthSales = 0 THEN 'N/A'
        ELSE ROUND(((c.CurrentMonthSales - p.PreviousMonthSales) / p.PreviousMonthSales) * 100, 2)
    END AS GrowthPercentage
FROM
    CurrentYear c
JOIN
    PreviousYear p ON c.Month = p.Month
ORDER BY
    c.Year,
    c.Month;
