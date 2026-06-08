SELECT 
    CASE 
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount > 0 AND Discount <= 0.2 THEN 'Low Discount (1-20%)'
        WHEN Discount > 0.2 AND Discount <= 0.5 THEN 'Medium Discount (21-50%)'
        ELSE 'High Discount (>50%)'
    END AS Discount_Tier,
    COUNT("Order ID") AS Number_of_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Profit), 2) AS Average_Profit_Per_Order
FROM 
    orders
GROUP BY 
    CASE 
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount > 0 AND Discount <= 0.2 THEN 'Low Discount (1-20%)'
        WHEN Discount > 0.2 AND Discount <= 0.5 THEN 'Medium Discount (21-50%)'
        ELSE 'High Discount (>50%)'
    END
ORDER BY 
    Total_Profit DESC;