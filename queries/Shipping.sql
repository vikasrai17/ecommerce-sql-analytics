WITH NEW_ORDERDATE AS (
SELECT
SALES,
PROFIT,
SHIPMODE,
str_to_date(SHIPDATE, '%m/%d/%Y') as new_ship_date,
str_to_date(orderdate, '%m/%d/%Y') as new_order_date
FROM ORDERS
)
SELECT 
    shipmode,
    ROUND(AVG(new_ship_date - new_order_date), 2) AS avg_days_to_ship,
    ROUND(SUM(sales), 2) AS aggregate_sales,
    ROUND(SUM(profit), 2) AS aggregate_profit
FROM NEW_ORDERDATE
GROUP BY shipmode
ORDER BY avg_days_to_ship;