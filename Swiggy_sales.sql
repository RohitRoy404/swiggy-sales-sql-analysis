CREATE DATABASE Swiggy_Database;
USE Swiggy_Database;

DROP TABLE IF EXISTS swiggy_databse;

CREATE TABLE swiggy_database(
State VARCHAR(100),
City VARCHAR(100),
Order_Date DATE,
Restaurant_Name VARCHAR(150),
Location VARCHAR(150),
Category VARCHAR(150),
Dish_Name VARCHAR(150),
Price DECIMAL(10,2),
Rating DECIMAL(2,1),
Rating_Count INT
);

  SELECT * FROM swiggy_database ;
  SELECT COUNT(*) FROM swiggy_database;

SELECT * FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY State,City,Order_Date,Restaurant_Name,Location,Category,Dish_Name,Price,Rating,Rating_Count ORDER BY State DESC) AS rn 
FROM swiggy_database)t WHERE rn>1;
  
-- DATA Validation and Cleaning
-- Null check

SELECT 
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS null_state,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN Restaurant_Name IS NULL THEN 1 ELSE 0 END) AS null_restaurant,
    SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS null_location,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN Dish_Name IS NULL THEN 1 ELSE 0 END) AS null_dish,
    SUM(CASE WHEN Price IS NULL THEN 1 ELSE 0 END) AS null_price,
    SUM(CASE WHEN Rating IS NULL THEN 1 ELSE 0 END) AS null_rating,
    SUM(CASE WHEN Rating_Count IS NULL THEN 1 ELSE 0 END) AS null_rating_count
FROM swiggy_database;

-- Blank or Empty strings

-- this is for only strings
SELECT * FROM swiggy_database WHERE 
         State='' OR City='' OR Restaurant_Name='' OR Location='' OR Category='' OR Dish_Name='';

SET SQL_SAFE_UPDATES=0;

UPDATE swiggy_database
SET Rating = NULL
WHERE Rating_Count = 0;

-- Duplicate Detection
SELECT * ,COUNT(*) FROM swiggy_database GROUP BY State,City,Order_Date,Restaurant_Name,Location,Category,Dish_Name,Price,Rating,Rating_Count HAVING COUNT(*)>1;


-- Remove Duplicates
CREATE TABLE swiggy_cleaned AS 
SELECT DISTINCT * FROM swiggy_database;
SELECT COUNT(*) FROM swiggy_cleaned;

-- Price negative check 
SELECT Price FROM swiggy_database WHERE price<=0;
-- Rating Must be between 1 and 5 
SELECT Rating FROM swiggy_database WHERE Rating NOT BETWEEN 1 and 5;
-- OUTLIERS
SELECT MAX(price),MIN(Price) FROM swiggy_database;

-- Date Validation 
SELECT MIN(Order_Date), MAX(Order_Date)
FROM swiggy_database;


-- Data Anlysis

-- 1. Which top 5 restaurants generated the highest total revenue, and what is their average rating?
SELECT * FROM swiggy_database;
SELECT Restaurant_Name,SUM(Price) AS Total_Price,ROUND(AVG(Rating),2)AS Average_Rating FROM swiggy_database GROUP BY Restaurant_Name ORDER BY Total_Price DESC LIMIT 5;


-- 2. Which city generates the highest revenue per month?
SELECT * FROM swiggy_database;
SELECT City,SUM(price) AS Total_Price,MONTH(Order_Date) AS Month FROM swiggy_database GROUP BY City,MONTH(Order_Date) ORDER BY Total_Price DESC  ;

-- 3. For each city, which restaurant generated the highest revenue  
WITH revenue_cte AS (
    SELECT 
        City,
        Restaurant_Name,
        SUM(Price) AS Total_Revenue,
        ROW_NUMBER() OVER (
            PARTITION BY City
            ORDER BY SUM(Price) DESC
        ) AS rn
    FROM swiggy_database
    GROUP BY City, Restaurant_Name
)
SELECT City, Restaurant_Name, Total_Revenue
FROM revenue_cte
WHERE rn = 1;



-- WHich category performs best in each city 
WITH CTE AS(
SELECT City,Category,AVG(Rating) AS avg_rating, DENSE_RANK() OVER(partition by CITY ORDER BY AVG(Rating) DESC) AS rn  FROM swiggy_database GROUP BY City,category)
SELECT City,Category,avg_rating FROM CTE WHERE rn=1 OR rn=2;


-- Which restaurants have the highest average rating in each city?
WITH CTE AS
(SELECT city,Restaurant_Name,AVG(rating) AS avg_rating,ROW_NUMBER() OVER( partition by City ORDER BY AVG(rating) DESC) AS rn FROM swiggy_database
GROUP BY City,Restaurant_Name)
SELECT city,Restaurant_Name,avg_rating FROM CTE WHERE rn=1;


-- Highest Revenue Restaurant in Each City
WITH revenue_cte AS (
    SELECT
        City,
        Restaurant_Name,
        SUM(Price) AS Total_Revenue,
        ROW_NUMBER() OVER(
            PARTITION BY City
            ORDER BY SUM(Price) DESC
        ) AS rn
    FROM swiggy_database
    GROUP BY City,Restaurant_Name
)

SELECT *
FROM revenue_cte
WHERE rn=1;
