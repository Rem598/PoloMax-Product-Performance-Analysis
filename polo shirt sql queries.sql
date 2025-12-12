CREATE SCHEMA product_analysis;
USE product_analysis;

-- 1. Average Rating and Review Count per Brand
SELECT Brand, 
       ROUND(AVG(Rating), 2) as Avg_Rating, 
       COUNT(*) as Review_Count 
FROM tshirts 
GROUP BY Brand;

-- 2. Brands with Highest Return Rates
SELECT Brand, 
       ROUND((SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) as Return_Rate_Percent
FROM tshirts 
GROUP BY Brand 
ORDER BY Return_Rate_Percent DESC;


-- 3. Average Price vs. Average Rating by Material
SELECT Color as Material_Proxy, 
       ROUND(AVG(Price), 2) as Avg_Price, 
       ROUND(AVG(Rating), 2) as Avg_Rating 
FROM tshirts 
GROUP BY Color;


-- 4. Top Performing Colors by Revenue
SELECT Color, 
       ROUND(SUM(Price), 2) as Revenue 
FROM tshirts 
GROUP BY Color 
ORDER BY Revenue DESC;


-- 5. Average Return Rate by Country of Origin
SELECT Location as Origin_Proxy, 
       ROUND((SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) as Return_Rate_Percent
FROM tshirts 
GROUP BY Location;


-- 6. Average Discount Applied by Brand
SELECT Brand, 
       ROUND(AVG(Discount), 2) as Avg_Discount 
FROM tshirts 
GROUP BY Brand;


-- 7. Top 10 SKUs by Review Growth
SELECT SKU,
       SUM(CASE WHEN Review_Date LIKE '%2024%' THEN 1 ELSE 0 END) as Reviews_2024,
       SUM(CASE WHEN Review_Date LIKE '%2025%' THEN 1 ELSE 0 END) as Reviews_2025,
       (SUM(CASE WHEN Review_Date LIKE '%2025%' THEN 1 ELSE 0 END) - 
        SUM(CASE WHEN Review_Date LIKE '%2024%' THEN 1 ELSE 0 END)) as Net_Growth
FROM tshirts
WHERE SKU != 'POLO-00000'
GROUP BY SKU
ORDER BY Net_Growth DESC
LIMIT 10;
