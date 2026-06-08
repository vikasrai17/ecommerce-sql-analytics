WITH New_OrderDate AS (
    SELECT
        str_to_date(orderdate, '%m/%d/%Y') AS new_date,
        Sales 
    FROM
        orders
), 
YearlySales AS (
    SELECT
        EXTRACT(YEAR FROM new_date) AS Order_Year, 
        ROUND(SUM(Sales), 2) AS Total_Sales
    FROM
        New_OrderDate 
    GROUP BY
        EXTRACT(YEAR FROM new_date)
)
SELECT
    Order_Year,
    Total_Sales,
    LAG(Total_Sales) OVER(ORDER BY Order_Year) AS Previous_Year_Sales,
    ROUND(((Total_Sales - LAG(Total_Sales) OVER(ORDER BY Order_Year)) / LAG(Total_Sales) OVER(ORDER BY Order_Year)) * 100, 2) AS YoY_Growth_Pct
FROM
    YearlySales;