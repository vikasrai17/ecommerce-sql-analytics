SELECT 
    customerid,
    customername,
    ROUND(SUM(sales), 2) AS total_lifetime_spend,
    COUNT(DISTINCT orderid) AS order_frequency,
    CASE 
        WHEN SUM(sales) >= 5000 THEN 'Platinum Tier'
        WHEN SUM(sales) BETWEEN 2000 AND 4999.99 THEN 'Gold Tier'
        ELSE 'Silver Tier'
    END AS customer_segment
FROM Orders
GROUP BY customerid, customername
ORDER BY total_lifetime_spend DESC;