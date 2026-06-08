SELECT 
    p.regional_manager,
    o.category,
    COUNT(DISTINCT o.orderid) AS gross_orders,
    COUNT(DISTINCT r.orderid) AS returned_orders,
    ROUND((COUNT(DISTINCT r.orderid) * 100.0) / COUNT(DISTINCT o.orderid), 2) AS return_rate_percentage
FROM Orders o
LEFT JOIN Returns r ON o.orderid = r.orderid
JOIN People p ON o.region = p.region
GROUP BY p.regional_manager, o.category
ORDER BY return_rate_percentage DESC;