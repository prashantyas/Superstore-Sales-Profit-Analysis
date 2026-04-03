/* =========================================================
   📊 Retail Sales & Profitability Analysis
   ========================================================= */

USE sql_0_to_100;

DROP TABLE IF EXISTS data;

/* =========================================================
   🧱 1. TABLE CREATION
   ========================================================= */

CREATE TABLE data (
    Row_ID INT,
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code INT,
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(150),
    Sales FLOAT,
    Quantity INT,
    Discount FLOAT,
    Profit FLOAT
);

/* =========================================================
   📥 2. DATA IMPORT
   ========================================================= */

-- Temporary change for date handling
ALTER TABLE data 
MODIFY Order_Date VARCHAR(50),
MODIFY Ship_Date VARCHAR(50);

-- Load dataset
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sample - Superstore.csv'
INTO TABLE data
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

/* =========================================================
   🧹 3. DATA CLEANING (DATE FORMATS)
   ========================================================= */

SET SQL_SAFE_UPDATES = 0;

UPDATE data
SET 
    Order_Date = CASE 
        WHEN Order_Date LIKE '%/%/%' 
             AND CAST(SUBSTRING_INDEX(Order_Date,'/',1) AS UNSIGNED) > 12
        THEN STR_TO_DATE(Order_Date, '%d/%m/%Y')
        WHEN Order_Date LIKE '%/%/%'
        THEN STR_TO_DATE(Order_Date, '%m/%d/%Y')
        ELSE Order_Date
    END,

    Ship_Date = CASE 
        WHEN Ship_Date LIKE '%/%/%' 
             AND CAST(SUBSTRING_INDEX(Ship_Date,'/',1) AS UNSIGNED) > 12
        THEN STR_TO_DATE(Ship_Date, '%d/%m/%Y')
        WHEN Ship_Date LIKE '%/%/%'
        THEN STR_TO_DATE(Ship_Date, '%m/%d/%Y')
        ELSE Ship_Date
    END;

-- Convert back to DATE
ALTER TABLE data
MODIFY Order_Date DATE,
MODIFY Ship_Date DATE;

/* =========================================================
   📈 4. BUSINESS ANALYSIS
   ========================================================= */

------------------------------------------------------------
-- Q1: Monthly Revenue & Profit Trend
------------------------------------------------------------

SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    ROUND(SUM(Sales), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit
FROM data
GROUP BY Month
ORDER BY Month;


------------------------------------------------------------
-- Q1.1: Revenue Growth Rate (MoM)
------------------------------------------------------------

SELECT
    Month,
    Revenue,
    ROUND(
        (Revenue - LAG(Revenue) OVER (ORDER BY Month)) /
        LAG(Revenue) OVER (ORDER BY Month) * 100, 2
    ) AS Revenue_Growth_Percent
FROM (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
        SUM(Sales) AS Revenue
    FROM data
    GROUP BY Month
) t;


------------------------------------------------------------
-- Q1.2: Profit Growth Rate (MoM)
------------------------------------------------------------

SELECT
    Month,
    Profit,
    ROUND(
        (Profit - LAG(Profit) OVER (ORDER BY Month)) /
        LAG(Profit) OVER (ORDER BY Month) * 100, 2
    ) AS Profit_Growth_Percent
FROM (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
        SUM(Profit) AS Profit
    FROM data
    GROUP BY Month
) t;


------------------------------------------------------------
-- Q2: Sub-Category Performance
------------------------------------------------------------

SELECT 
    Sub_Category,
    ROUND(SUM(Sales), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
FROM data
GROUP BY Sub_Category
ORDER BY Profit_Margin DESC;


------------------------------------------------------------
-- Q3: Loss Analysis
------------------------------------------------------------

SELECT 
    Region,
    Category,
    Sub_Category,
    ROUND(SUM(Profit), 2) AS Total_Loss
FROM data
WHERE Profit < 0
GROUP BY Region, Category, Sub_Category
ORDER BY Total_Loss ASC;


------------------------------------------------------------
-- Q4: Discount Impact Analysis
------------------------------------------------------------

SELECT 
    CASE 
        WHEN Discount = 0 THEN '0%'
        WHEN Discount <= 0.2 THEN '0–20%'
        WHEN Discount <= 0.4 THEN '20–40%'
        WHEN Discount <= 0.6 THEN '40–60%'
        WHEN Discount <= 0.8 THEN '60–80%'
        ELSE '80%+'
    END AS Discount_Range,

    ROUND(SUM(Sales), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,
    COUNT(*) AS Orders

FROM data
GROUP BY Discount_Range
ORDER BY Profit ASC;


------------------------------------------------------------
-- Q5: Customer Contribution Analysis
------------------------------------------------------------

SELECT 
    Customer_Name,
    Revenue,
    ROUND(Revenue / SUM(Revenue) OVER () * 100, 2) AS Contribution_Percent
FROM (
    SELECT 
        Customer_Name,
        ROUND(SUM(Sales), 2) AS Revenue
    FROM data
    GROUP BY Customer_Name
) t
ORDER BY Revenue DESC
LIMIT 10;