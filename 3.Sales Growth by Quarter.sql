--3.Sales Growth by Quarter Write a SQL query to calculate the percentage growth in sales (in terms of quantity sold) from one quarter
--to the next for each product. Include product name in the results and sort by the highest growth to identify the fastest growing products.

WITH QuarterlySales AS (
    SELECT
        p.Name AS ProductName,
        dd.Quarter,
        SUM(sf.Quantity) AS TotalQuantity,
        LEAD(SUM(sf.Quantity)) OVER(PARTITION BY p.Name ORDER BY dd.Quarter) AS NextQuarterQuantity
    FROM
        Sales_Fact sf
    JOIN
        Product_Dim p ON sf.ProductID = p.ProductID
    JOIN
        Date_Dim dd ON sf.Date = dd.Date
    GROUP BY
        p.Name,
        dd.Quarter
)
SELECT
    ProductName,
    Quarter AS CurrentQuarter,
    TotalQuantity AS QuantityCurrentQuarter,
    LEAD(Quarter) OVER(PARTITION BY ProductName ORDER BY Quarter) AS NextQuarter,
    NextQuarterQuantity AS QuantityNextQuarter,
    ROUND(((NextQuarterQuantity - TotalQuantity) / TotalQuantity) * 100, 2) AS GrowthPercentage
FROM
    QuarterlySales
WHERE
    NextQuarterQuantity IS NOT NULL
ORDER BY
    GrowthPercentage DESC;