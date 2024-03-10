--10.Creation and Use of a Materialized View Create a materialized view that summarizes total sales by retailer and month. Then, write a
--query using this view to find the retailer with the highest sales for each month, including the retailer name, month, and total sales amount.

CREATE MATERIALIZED VIEW Sales_Summary_By_Retailer_Month AS
SELECT
    RetailerID,
    EXTRACT(YEAR FROM Date) AS Year,
    EXTRACT(MONTH FROM Date) AS Month,
    SUM(Quantity * Price) AS TotalSales
FROM
    Sales_Fact
GROUP BY
    RetailerID, EXTRACT(YEAR FROM Date), EXTRACT(MONTH FROM Date);
	
--Query the Materialized View to Find the Retailer with the Highest Sales for Each Month:
SELECT
    RetailerID,
    Year,
    Month,
    TotalSales
FROM
    Sales_Summary_By_Retailer_Month AS S1
WHERE
    TotalSales = (
        SELECT
            MAX(TotalSales)
        FROM
            Sales_Summary_By_Retailer_Month AS S2
        WHERE
            S1.Year = S2.Year AND
            S1.Month = S2.Month
    );

