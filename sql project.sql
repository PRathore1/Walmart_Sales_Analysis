select*from walmart.sales;

#1 number of rows present in the dataset

select count(*) from walmart.sales;
---------------------------------------------------------------------------

#2 Data cleaning

-- Add the time_of_day column

SELECT time,
(CASE
WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
ELSE 'Evening'
END) AS time_of_day
FROM walmart.sales;

-- Add day_name column

SELECT date, DAYNAME(date)
FROM walmart.sales;
ALTER TABLE walmart.sales ADD COLUMN time_of_day VARCHAR(20);

-- Add month_name column

SELECT date, MONTHNAME(date)
FROM walmart.sales;
ALTER TABLE walmart.sales ADD COLUMN month_name VARCHAR(10);

----------------------------------------------------------------------------

#3 How many unique cities does the data have?

SELECT DISTINCT city
FROM walmart.sales;


#4 In which city is each branch?

SELECT DISTINCT city, branch
FROM walmart.sales;


#5 How many unique product lines does the data have?

SELECT distinct `product line` FROM walmart.sales;


#6 What is the most selling product line

SELECT SUM(quantity) as qty,
`product line`
FROM walmart.sales
GROUP BY `product line`
ORDER BY qty DESC;


#7  What is the total revenue by month

SELECT month_name AS month, SUM(total) AS total_revenue
FROM walmart.sales
GROUP BY month_name 
ORDER BY total_revenue;


#8 What month had the largest COGS?

SELECT month_name AS month, SUM(cogs) AS cogs
FROM walmart.sales
GROUP BY month_name 
ORDER BY cogs;


#9 What product line had the largest revenue?

SELECT `product line`,
SUM(total) as total_revenue
FROM walmart.sales
GROUP BY `product line`
ORDER BY total_revenue DESC;


#10 What is the city with the largest revenue?

SELECT branch,city,
SUM(total) AS total_revenue
FROM walmart.sales
GROUP BY city, branch 
ORDER BY total_revenue;


#11 What product line had the largest VAT?

SELECT `product line`,
AVG(`tax 5%`) as avg_tax
FROM walmart.sales
GROUP BY `product line`
ORDER BY avg_tax DESC;


#12 Which branch sold more products than average product sold?

SELECT branch, SUM(quantity)
FROM walmart.sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM walmart.sales);


#13 What is the most common product line by gender

SELECT gender, `product line`,
COUNT(gender) AS total
FROM walmart.sales
GROUP BY gender, `product line`
ORDER BY total DESC;


#14 How many unique customer types does the data have?

SELECT DISTINCT `customer type`
FROM walmart.sales;


#15 How many unique payment methods does the data have?

SELECT DISTINCT payment
FROM walmart.sales;


#16 Which customer type buys the most?

SELECT `customer type`, COUNT(*)
FROM walmart.sales
GROUP BY `customer type`;


#17 Which time of the day do customers give most ratings?

SELECT time,
AVG(rating) as avg_rating
FROM walmart.sales
GROUP BY time
ORDER BY avg_rating DESC;


#18 Which day for the week has the best avg ratings?

SELECT dayname(date),
AVG(rating) AS avg_rating
FROM walmart.sales
GROUP BY dayname(date) 
ORDER BY avg_rating DESC;


#19 Number of sales made in each time of the day per weekday 

SELECT time, COUNT(*) AS total_sales
FROM walmart.sales
WHERE dayname(date) = "Sunday"
GROUP BY time
ORDER BY total_sales DESC;


#20 Which city has the largest tax/VAT percent?

SELECT city,
ROUND(AVG(`tax 5%`), 2) AS avg_tax
FROM walmart.sales
GROUP BY city
ORDER BY avg_tax DESC;


