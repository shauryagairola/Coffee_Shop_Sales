#CALENDAR TABLE – DAILY SALES, QUANTITY and TOTAL ORDERS
SELECT 
CONCAT(ROUND(SUM(unit_price * transaction_qty) / 1000, 1),'K') AS total_sales,
    CONCAT(ROUND(COUNT(transaction_id) / 1000, 1),'K') AS total_orders,
    CONCAT(ROUND(SUM(transaction_qty) / 1000, 1),'K') AS total_quantity_sold
FROM 
`coffee_ shop`
WHERE
transaction_date = '2023-05-18'; 

#Sales by weekdays and weekends
SELECT 
    CASE 
        WHEN DAYOFWEEK(transaction_date) IN (1, 7) THEN 'Weekends'
        ELSE 'Weekdays'
    END AS day_type,
concat(ROUND(SUM(unit_price * transaction_qty)/1000,2),'K') AS total_sales
FROM 
`coffee_ shop`
WHERE
MONTH(transaction_date) = 5  -- Filter for May
GROUP BY day_type;
    
#Sales by Store location   
SELECT 
store_location,
SUM(unit_price * transaction_qty) as Total_Sales
FROM `coffee_ shop`
WHERE
MONTH(transaction_date) = 5 
GROUP BY store_location
ORDER BY Total_Sales DESC;

#Average daily sales
select concat(round(avg(total_sales)/1000,1),'k') as avg_sales
from
(select SUM(unit_price * transaction_qty) as total_sales
from `coffee_ shop`
where month(transaction_date) = 5
group by transaction_date
order by transaction_date) as ds;

#COMPARING DAILY SALES WITH AVERAGE SALES 
SELECT 
day_of_month,
    CASE 
        WHEN total_sales>avg_sales THEN 'Above Average'
        WHEN total_sales<avg_sales THEN 'Below Average'
        ELSE 'Average'
    END AS sales_status,
total_sales
FROM (
    SELECT 
DAY(transaction_date) AS day_of_month,
SUM(unit_price * transaction_qty) AS total_sales,
AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
    FROM 
coffee_shop_sales
WHERE
MONTH(transaction_date) = 5  -- Filter for May
    GROUP BY 
DAY(transaction_date)
) AS sales_data
ORDER BY 
day_of_month;

#DAILY SALES FOR MONTH SELECTED
SELECT 
DAY(transaction_date) AS day_of_month,
ROUND(SUM(unit_price * transaction_qty),1) AS total_sales
FROM 
`coffee_ shop`
WHERE
MONTH(transaction_date) = 5  -- Filter for May
GROUP BY 
day_of_month
ORDER BY 
day_of_month;

#sales by product category
select product_category,
round(sum(unit_price * transaction_qty),1) as total_sales
from `coffee_ shop`
WHERE
	MONTH(transaction_date) = 5 
group by product_category
order by total_sales desc;

#top 10 products by sales
select product_type,
round(sum(unit_price * transaction_qty),1) as total_sales
from `coffee_ shop`
WHERE
	MONTH(transaction_date) = 5 
group by product_type
order by total_sales desc
limit 10;

#sales by day and hours
SELECT 
ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales,
SUM(transaction_qty) AS Total_Quantity,
COUNT(*) AS Total_Orders
FROM 
`coffee_ shop`
WHERE
DAYOFWEEK(transaction_date) = 3 -- Filter for Tuesday (1 is Sunday, 2 is Monday, ..., 7 is Saturday)
    AND HOUR(transaction_time) = 8 -- Filter for hour number 8
    AND MONTH(transaction_date) = 5; -- Filter for May (month number 5)

# SALES FOR ALL HOURS FOR MONTH OF MAY
SELECT 
HOUR(transaction_time) AS Hour_of_Day,
ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
`coffee_ shop`
WHERE
MONTH(transaction_date) = 5 -- Filter for May (month number 5)
GROUP BY 
HOUR(transaction_time)
ORDER BY 
HOUR(transaction_time);

# SALES FROM MONDAY TO SUNDAY FOR MONTH OF MAY
SELECT 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END AS Day_of_Week,
ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
`coffee_ shop`
WHERE
MONTH(transaction_date) = 5 -- Filter for May (month number 5)
GROUP BY Day_of_Week;
    