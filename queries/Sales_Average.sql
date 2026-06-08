WITH NEW_ORDERDATE AS (
	SELECT 
		STR_TO_DATE(ORDERDATE, '%m/%d/%Y') AS NEW_ORDERDATE,
        SALES
    FROM ORDERS
    ),
 Monthly_Totals AS (
    SELECT 
        YEAR(NEW_ORDERDATE) AS order_year,
        MONTH(NEW_ORDERDATE) AS order_month,
        SUM(sales) AS monthly_revenue
    FROM NEW_ORDERDATE
    GROUP BY YEAR(NEW_ORDERDATE), MONTH(NEW_ORDERDATE)
)
SELECT 
    order_year,
    order_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(AVG(monthly_revenue) OVER (
        ORDER BY order_year, order_month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS rolling_3_month_avg_sales
FROM Monthly_Totals;