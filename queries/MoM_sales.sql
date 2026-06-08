WITH Monthly_Sales AS (
    SELECT 
        month(orderdate) AS order_month,
        SUM(sales) AS current_month_sales
    FROM Orders
    GROUP BY month(orderdate)
),
Sales_With_Lag AS (
    SELECT 
        order_month,
        current_month_sales,
        LAG(current_month_sales, 1) OVER (ORDER BY order_month) AS previous_month_sales
    FROM Monthly_Sales
)
SELECT 
    order_month,
    ROUND(current_month_sales, 2) AS current_month_sales,
    ROUND(previous_month_sales, 2) AS previous_month_sales,
    ROUND(((current_month_sales - previous_month_sales) / previous_month_sales) * 100, 2) AS mom_growth_rate
FROM Sales_With_Lag;