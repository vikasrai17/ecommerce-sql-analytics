WITH Ranked_Customers AS (
    SELECT 
        region,
        customername,
        ROUND(SUM(sales), 2) AS total_spent,
        DENSE_RANK() OVER (PARTITION BY region ORDER BY SUM(sales) DESC) AS ranking
    FROM Orders
    GROUP BY region, customername
)
SELECT 
    region,
    ranking,
    customername,
    total_spent
FROM Ranked_Customers
WHERE ranking <= 3
ORDER BY region, ranking;