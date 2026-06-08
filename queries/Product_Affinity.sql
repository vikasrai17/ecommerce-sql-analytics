SELECT 
    o1.sub_category AS product_a,
    o2.sub_category AS product_b,
    COUNT(DISTINCT o1.orderid) AS co_purchase_frequency
FROM Orders o1
JOIN Orders o2 ON o1.orderid = o2.orderid 
    AND o1.sub_category < o2.sub_category -- Avoids duplication and self-matching
GROUP BY o1.sub_category, o2.sub_category
ORDER BY co_purchase_frequency DESC
LIMIT 10;