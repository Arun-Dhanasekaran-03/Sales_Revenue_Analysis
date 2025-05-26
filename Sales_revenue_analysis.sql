/* Creating Database and Table for Analysis*/
CREATE DATABASE project;
USE project;
CREATE TABLE `Sales_Revenue_Analysis` (
  `Location ID` int,
  `City` text,
  `State` text,
  `Country` text,
  `Latitude` double,
  `Longitude` double,
  `Product ID` text,
  `Product Category` text,
  `Sales Volume` double,
  `Sales Revenue` double,
  `Date` date 
);

/* Loading Data into Table */
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/geographic_product_demand_dataset_10M.csv"
INTO TABLE Sales_Revenue_Analysis
FIELDS TERMINATED BY ","
LINES TERMINATED BY "\n"
IGNORE 1 ROWS;
SELECT * FROM sales_revenue_analysis LIMIT 1;

/* Total Revenue Analysis by Product Category (2022-24) */
SELECT YEAR(Date) AS Sales_year,`Product Category` as Product_category,CONCAT('$',round(SUM(`Sales Revenue`)/1000000000,1),'B') AS `Total Revenue`
FROM Sales_Revenue_Analysis
group by Sales_year,Product_category Order by Sales_year,SUM(`Sales Revenue`) DESC;

/* Country Wise Total Sales Revenue Comparison */
SELECT Country,CONCAT('$',round(SUM(`Sales Revenue`)/1000000000,1),'B') AS `Total Revenue`
FROM Sales_Revenue_Analysis GROUP BY Country
ORDER BY SUM(`Sales Revenue`) DESC;

/* Yearly Total Sales Revenue Comparison */
SELECT YEAR(Date) AS Sales_year,CONCAT('$',round(SUM(`Sales Revenue`)/1000000000,1),'B') AS `Total Revenue`
FROM Sales_Revenue_Analysis GROUP BY Sales_year
ORDER BY Sales_year ASC; 

/* India's Total Sales Revenue Analysis (2022-24) */
SELECT `Product Category` as Product_category,CONCAT('$',round(SUM(`Sales Revenue`)/1000000000,1),'B') AS `Total Revenue`
FROM Sales_Revenue_Analysis WHERE Country="India"
group by Product_category Order by SUM(`Sales Revenue`) DESC;