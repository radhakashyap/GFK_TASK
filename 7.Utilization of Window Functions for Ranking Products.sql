--7.Utilization of Window Functions for Ranking Products Leverage window functions to rank products within each category by total sales
--quantity. Include product name, category, and rank in the output, sorted by category and then by rank.

WITH RankedProducts AS (
    SELECT
        ProductID,
        Name AS ProductName,
        Category,
        SUM(Quantity) AS TotalSalesQuantity,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY SUM(Quantity) DESC) AS Rank
    FROM
        Sales_Fact sf
    JOIN
        Product_Dim pd ON sf.ProductID = pd.ProductID
    GROUP BY
        ProductID, Name, Category
)
SELECT
    ProductID,
    ProductName,
    Category,
    TotalSalesQuantity,
    Rank
FROM
    RankedProducts
ORDER BY
    Category, Rank;