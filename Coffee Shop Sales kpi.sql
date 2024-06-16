use  coffee_shop_sales

SELECT * FROM coffee_shop_sales.`coffee_ shop`;

describe coffee_shop_sales.`coffee_ shop`;

update coffee_shop_sales.`coffee_ shop`
set transaction_date = str_to_date(transaction_date,'%m/%d/%Y') ;

ALTER TABLE coffee_shop_sales.`coffee_ shop`
MODIFY COLUMN transaction_date DATE ;

update coffee_shop_sales.`coffee_ shop`
set transaction_time = str_to_date(transaction_time,'%H:%i:%s') ;

ALTER TABLE coffee_shop_sales.`coffee_ shop`
MODIFY COLUMN transaction_time time ;

#1- total sales for each month
select round(sum(unit_price * transaction_qty)) as total_sales from coffee_shop_sales.`coffee_ shop`
where 
month(transaction_date) = 5;

#- MOM DIFFERENCE AND MOM GROWTH
SELECT 
MONTH(transaction_date) AS month,
ROUND(SUM(unit_price * transaction_qty)) AS total_sales,
    (SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty), 1) -- months sales difference
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(unit_price * transaction_qty), 1) -- division by PM sales 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage -- percentage
FROM 
coffee_shop_sales.`coffee_ shop`
WHERE
MONTH(transaction_date) IN (4, 5) -- for months of April and May
GROUP BY 
MONTH(transaction_date)
ORDER BY 
MONTH(transaction_date);

#2- Total Orders
SELECT COUNT(transaction_id) as Total_Orders
FROM coffee_shop_sales.`coffee_ shop`
WHERE MONTH(transaction_date)= 5 ;-- for month of (CM-May)

#- MOM DIFFERENCE AND MOM GROWTH
SELECT 
MONTH(transaction_date) AS month,
    ROUND(COUNT(transaction_id)) AS total_orders,
    (COUNT(transaction_id) - LAG(COUNT(transaction_id), 1) 
    OVER (ORDER BY MONTH(transaction_date))) / LAG(COUNT(transaction_id), 1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM 
`coffee_ shop`
WHERE
MONTH(transaction_date) IN (4, 5) -- for April and May
GROUP BY 
MONTH(transaction_date)
ORDER BY 
MONTH(transaction_date);

#3- Total Quantity
select sum(transaction_qty) as total_quantity
from `coffee_ shop`
where 
month(transaction_date) = 5;

#- MOM DIFFERENCE AND MOM GROWTH
SELECT 
MONTH(transaction_date) AS month,
    ROUND(sum(transaction_qty)) AS total_quantity,
    (sum(transaction_qty) - LAG(sum(transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date))) / LAG(sum(transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM 
`coffee_ shop`
WHERE
MONTH(transaction_date) IN (4, 5) -- for April and May
GROUP BY 
MONTH(transaction_date)
ORDER BY 
MONTH(transaction_date);

