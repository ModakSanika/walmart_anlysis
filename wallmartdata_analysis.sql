--  -----------To display time --------------------------------

select time,
(case
when `time` between "00:00:00" and "12:00:00" then "Morning" 
when `time` between "12:01:00" and "16:00:00" then "Afternoon"
else
'evening'
end)AS time_of_date
from sales;

ALTER TABLE sales
ADD COLUMN time_of_day VARCHAR(20);
 SET SQL_SAFE_UPDATES = 0;
UPDATE sales
SET time_of_date=(
case
when `time` between "00:00:00" and "12:00:00" then "Morning" 
when `time` between "12:01:00" and "16:00:00" then "Afternoon"
else
'evening'
end
);

-- ----------- day_name-----------------------------------

select date ,
 DAYNAME(date) as day_name from sales;
 alter table sales add column day_name varchar(20);
 update sales
 set day_name=
  DAYNAME(date) ;

-- --------------------- month------------------------------------

select date ,
 MONTHNAME(date) as month_name from sales;
 alter table sales add column month_name varchar(20);
 update sales
 set month_name=
  MONTHNAME(date) ;
  
  -- ------------------------------------------------------------------------------------------------------------------------------------
  -- ------------------------------------------------------------------------------------------------------------------------------------
  
  -- ----------------------------------------------------------------Generic---------------------------------------------------------------------------------------
 --  --------------------------------------------How many unnique cities does the data have ?
 select distinct city from sales;
 
--  In which city is each branch
 select distinct city,branch from sales;
 
--  ------------------------------------------------------------------Product------------------------------------------------------------------------------------------
-- How many unique product lines does the data have
select distinct count( product_line) from sales;

-- -------------------------------------------------------What is the most common method?---------------------------------------------
select payment,
 count(payment)as cnt from sales 
 group by payment;
 
 -- --------------------------------------------------------- What is the most selling product line --------------------------------------------------------------------------------- 
select product_line,
 count(product_line)as cnt from sales 
 group by product_line
 order by cnt desc;
 
 -- -----------------------------------------------What is the toatal revenue by month?--------------------------- ---------------------------------
 select sum(total) as total_revenue,
month_name as month
 from sales
 group by month_name
 order by total_revenue desc;
 
 -- ------------------------------------What month had the largest cogs?-------------------------------------------------------------------
 select month_name as month ,
 sum(cogs) as cogs from sales
  group by month_name
 order by cogs  desc;
 
 --  -------------------------------------------What product_line had the largest revenue------------------------
 select product_line ,
 sum(total) as total_revenue from sales
 group by product_line
 order by total_revenue desc;
 
 --  ----------------------------------------What is the city with largest revenue? ---------------------------------------------------
 select city ,
 sum(total) as total_revenue from sales
  group by city
 order by total_revenue desc;
 
 -- --------------------------- - what product line had the largest VAT?--------------------------------------------
 select product_line ,
 max(tax) as largest_VAT from sales
  group by product_line
 order by largest_VAT desc;
 
 -- ----fetch each product line and add a column to those product line showing 'Good', 'Bad'. 'Good' if it is greater than the average sales-------------------- 
--   select product_line ,
--  avg(tax) as largest_VAT from sales
--   group by product_line
--  order by largest_VAT desc;
--  
--  alter table sales add column review varchar(10);
--  SET SQL_SAFE_UPDATES = 0;
--  update sales
--  set review=(
--  if avg(tax) 
--  )
--  
 -- --Which branch sold more products than average product sold?-----------------------
 select branch,
 sum(quantity) as qty
 from sales
 group by branch
 having sum(quantity)>(select avg(quantity)from sales);
 
 --  ------------------------------------------ what is the most common product line by gender ------------------------------------------
 select product_line ,gender,
 count(gender)as cnt
 from sales
 group by gender,product_line
 order by cnt desc;
 
 -- -------------------------------------------- what is the average rating of each product line ----------------------------------- 
 select avg(rating) as avg_Rating ,product_line  from sales
 group by product_line
 order by avg_Rating desc;
 
 -- -------------------------------------------SALES----------------------------------------------------------------------------- 
 -- ----------------------   number of sales made in  each time of day per weekday   ----------------------------------------------------
 select time_of_date, count(*) as total_sales
 from sales
 where day_name='Monday'
 group by time_of_date
 order by total_sales desc;
 
 -- ---- ------------------------------ which of the customer types brings the most revenue  -------------------------------------------------- 
 select customer_type , sum(total) as total_revenue
 from sales
 group by customer_type
 order by total_revenue desc;
 
 -- --------------------  Which city has the largest tax percent/VAT? ------------------------------------------------------ 
 select city,max(tax) as VAT
 from sales
 group by city
 order by VAT desc;
 
 -- ---                              Which customr type pays the most ------------------------- 
 select customer_type,avg(total) as VAT from sales
 group by customer_type
 order by VAT desc;
 
 
 
 