use swiggy_db;
select * from swiggy_data;
select count(*) from swiggy_data;

--data cleaning and data validation
--null check
select 
sum(case when State is null then 1 else 0 end) as null_state,
sum(case when city is null then 1 else 0 end)as null_city,
sum(case when order_date is null then 1 else 0 end)as null_order_date,
sum(case when restaurant_name is null then 1 else 0 end) as null_restuarant_name,
sum(case when location is null then 1 else 0 end)as null_location,
sum(case when dish_name is null then 1 else 0 end)as null_dish_name,
sum(case when price_inr is null then 1 else 0 end) as null_price_inr,
sum(case when rating is null then 1 else  0 end)as null_rating,
sum(case when rating_count is null then 1 else 0 end)as null_rating_count
from swiggy_data;

--blank and empty strings
--select * from swiggy_data where state='' or city='' or Restaurant_Name='' or location='' or
--dish_name='' or category='';
--The rest of the columns are not taken because they are numeric valus which cannot be comapred 
--with '' which are strings
   
select * from swiggy_data where state='' or city='' or Restaurant_Name='' or location='' or
dish_name='' or category='';    

--duplicate detection
select State,city,order_date,restaurant_name,location,category,dish_name,price_inr,rating,rating_count,
count(*)
from swiggy_data group by State,city,order_date,restaurant_name,location,category,dish_name,price_inr
,rating,rating_count having
count(*)>1;


----duplicate deletion
with cte as(
select *,ROW_NUMBER() over(partition by state,city,order_date,restaurant_name,location,
category,dish_name,price_inr,rating,
rating_count order by (select null)) as rn from swiggy_data)
delete from cte where rn>1;


--Creating schema
--DIMENSIONS TABLE
--DATE TABLE

create table dim_date(date_id int identity(1,1) primary key,
Full_Date date,Year INT,Month int,Month_Name varchar(20),Quarter int,Day int,Week int)
select * from dim_date;

--dim location
create table dim_location(location_id int identity(1,1)Primary key,state varchar(100),
city varchar(100),location varchar(200));
select * from dim_location;

--dim restaurant 
create table dim_restaurant(Restaurant_id int identity(1,1) primary key,
Restaurant_Name varchar(200));
select * from dim_restaurant;

--dim_category
create table dim_category(category_id int identity(1,1) primary key,Category varchar(200));
select * from dim_category;

--dim_dish
CREATE TABLE dim_dish (
    dish_id INT IDENTITY(1,1) PRIMARY KEY,
    dish_name VARCHAR(200)
);

select * from dim_dish;

--Fact table creation
create table fact_swiggy_orders( order_id int identity(1,1) primary key,
date_id int,price_inr decimal(10,2),rating decimal(4,2),rating_count int,
location_id int,restaurant_id int,category_id int,dish_id int,
foreign key (date_id) references dim_date(date_id),
foreign key (location_id) references dim_location(location_id),
foreign key (restaurant_id) references dim_restaurant(restaurant_id),
foreign key (dish_id) references dim_dish(dish_id),
foreign key (category_id) references dim_category(category_id)
);
select * from fact_swiggy_orders;
drop table fact_swiggy_orders;


--INSERTING THE DATA
--insert into dim_date
INSERT INTO dim_date (Full_Date, Year, Month, Month_Name, Quarter, Day, Week)
SELECT DISTINCT
    s.order_date,
    YEAR(s.order_date),
    MONTH(s.order_date),
    DATENAME(month, s.order_date),
    DATEPART(quarter, s.order_date),
    DAY(s.order_date),
    DATEPART(week, s.order_date)
FROM swiggy_data s
WHERE s.order_date IS NOT NULL
AND NOT EXISTS (
    SELECT 1
    FROM dim_date d
    WHERE d.Full_Date = s.order_date
);


select * from dim_date;

--insert dim_location
insert into dim_location(state,city,location) 
select distinct state,city,location from swiggy_data;
select * from dim_location;

--insert into dim-restaurant
insert into dim_restaurant(restaurant_name) select distinct restaurant_name from swiggy_data;
select * from dim_restaurant;

--insert into dim-category
insert into dim_category(Category) select distinct category from swiggy_data;
select * from dim_category;
 
--insert into dim-dish
insert into dim_dish(dish_name) select distinct dish_name from swiggy_data;
select * from dim_dish;

--INSERT INTO FACT TABLE
insert into fact_swiggy_orders(
date_id,price_inr,rating,rating_count,location_id,restaurant_id,category_id,dish_id
)
select dd.date_id,s.price_inr,s.rating,s.rating_count,dl.location_id,dr.restaurant_id,dc.category_id,
dsh.dish_id from swiggy_data s join dim_date dd on dd.full_date=s.order_date join
dim_location dl on dl.state=s.state and dl.city=s.city and dl.location=s.location join dim_restaurant dr
on dr.restaurant_name=s.restaurant_name join dim_category dc on dc.category=s.category join dim_dish dsh
on dsh.dish_name=s.dish_name;
select * from fact_swiggy_orders;

--how to see the entire table in one go
--to display the cntent in human readable form
select * from fact_swiggy_orders f join dim_date d on f.date_id=d.date_id join
dim_location l on f.location_id=l.location_id join dim_restaurant r on f.restaurant_id=r.restaurant_id
join dim_category c on f.category_id=c.category_id join dim_dish di on f.dish_id=di.dish_id;

---Data cleaning and Data processing ends here


--Requirements
--KPI's

--total items orders
select * from fact_swiggy_orders;
select count(*) as total_items_orders from fact_swiggy_orders; 

--Total revenue in (inr million)
select format(sum(convert(float,price_inr))/100000,'N2')+' INR MILLION' as Total_Revenue from fact_swiggy_orders;

--Average Dish Price
select format(avg(convert(float,price_inr)),'N2')+' INR' as Average_Dish_Price from fact_swiggy_orders;

--Average Rating
select cast(round(avg(rating), 2) as decimal(4,2)) as avg_rating
from fact_swiggy_orders;

--Deep dive Business Analytics
--Monthly Orders Trends
select d.year,d.month,d.month_name,count(*) as total_orders from fact_swiggy_orders f join 
dim_date d on f.date_id=d.date_id group by d.year,d.month,d.month_name order by count(*) desc;

--Monthly Orders Trends
select d.year,d.month,d.month_name,sum(price_inr) as total_revenue from fact_swiggy_orders f
join dim_date d on f.date_id=d.date_id group by d.year,d.month,d.month_name order by sum(price_inr) desc;

----Quarterly Trend
select d.year,d.quarter,count(*) as quarterly_total_orders from fact_swiggy_orders 
f join dim_date d on f.date_id=d.date_id group by d.year,d.quarter order by count(*) desc;

--Yearly Trends
select d.year,count(*) as Yearly_trends from fact_swiggy_orders f join dim_date d
on f.date_id=d.date_id group by d.year order by count(*) desc;q

--order day of the week
select datename(weekday,d.week) as day_name,count(*) as total_orders
from fact_swiggy_orders f join dim_date d on
f.date_id=d.date_id group by datename(weekday,d.week),datepart(weekday,d.week) 
order by datepart(weekday,d.week); 

--Location based Analysis

--Top 10 cities by order volume
select top 10 d.city,sum(f.price_inr) as total_revenue from fact_swiggy_orders f join dim_location d
on f.location_id=d.location_id group by d.city order by sum(f.price_inr) desc;

--Revenue contribution by states
select top 10 d.state,sum(f.price_inr) as total_revenue from fact_swiggy_orders f join dim_location d
on f.location_id=d.location_id group by d.state order by sum(f.price_inr) desc;

--Food Performance

---Top 10 restaurants by orders
select top 10 r.restaurant_name,sum(f.price_inr) as total_revenue
from fact_swiggy_orders f join dim_restaurant r
on f.restaurant_id=r.restaurant_id group by r.Restaurant_Name order by sum(f.price_inr)  desc

---Top categories (Indian, Chinese, etc.)
select c.category,count(*)as total_orders from fact_swiggy_orders f join dim_category c
on f.category_id=c.category_id group by c.Category order by total_orders desc;

--	Most ordered dishes
select d.dish_name,count(*) as order_count from fact_swiggy_orders f join dim_dish d
on f.dish_id=d.dish_id group by d.dish_name order by count(*) desc;

--Cuisine performance ? Orders + Avg Rating
select c.category,count(*)as total_orders , round(avg(convert(float,f.rating)),2) as rating
from fact_swiggy_orders f join dim_category c on f.category_id=c.category_id group by c.category
order by total_orders desc;

--Customer Spending Insights
select 
case when convert(float,price_inr)<100 then 'Under 100' 
when convert(float,price_inr) between 100 and 199 Then '100 - 199'
when convert(float,price_inr) between 200 and 299 then '200 -299'
when convert(float,price_inr) between 300 and 499 then '300-499'
else '500+'
end as price_range,count(*) as total_orders 
from fact_swiggy_orders group by 
case when convert(float,price_inr)<100 then 'Under 100' 
when convert(float,price_inr) between 100 and 199 Then '100 - 199'
when convert(float,price_inr) between 200 and 299 then '200 -299'
when convert(float,price_inr) between 300 and 499 then '300-499'
else '500+'
end 
order by total_orders desc;

--Ratings Analysis
--Distribution of dish ratings from 1–5.
select rating,count(*) as rating_count from fact_swiggy_orders group by rating order by count(*) desc;

--Top 3 Restaurants Per City (Using RANK)
with city_rank as (select r.restaurant_name,sum(f.price_inr)as revenue,DENSE_RANK() over(partition 
by l.city order by sum(f.price_inr) desc)
 as rnk from fact_swiggy_orders f join dim_restaurant r on f.restaurant_id=r.Restaurant_id
join dim_location l on f.location_id=l.location_id group by l.city, r.restaurant_name)
select * from city_rank where rnk<=5

--Price Sensitivity by City
select l.city,avg(f.price_inr) as avg_price,count(*) as total_orders from fact_swiggy_orders f
join dim_location l on f.location_id = l.location_id
group by l.city
order by avg_price desc;

---Revenue Contribution % by Category
with total_revenue as(
select sum(f.price_inr) as total_rev from fact_swiggy_orders f
)
select c.category,sum(f.price_inr) as rev_category,round(sum(f.price_inr)*100/(select total_rev
from total_revenue),2) as contribution_percent from fact_swiggy_orders f join dim_category c on 
f.category_id=c.category_id group by c.Category order by contribution_percent desc;

--Running Total Revenue
select 
    d.full_date,sum(f.price_inr) as daily_revenue,sum(sum(f.price_inr)) over(order by d.full_date) as running_total
from fact_swiggy_orders f join dim_date d on f.date_id = d.date_id group by d.full_date
order by d.full_date;

--High Revenue but Low Rating Restaurants
with restaurant_stats as(
select r.restaurant_name,sum(f.price_inr)as revenue,avg(f.rating) as avg_rating
from fact_swiggy_orders f join
dim_restaurant r on f.restaurant_id=r.restaurant_id group by r.restaurant_name)

select * from  restaurant_stats where revenue>(select avg(revenue) from restaurant_stats)
and avg_rating< 3.5 order by revenue desc;

--Find restaurants that NEVER received a rating below 4.
select r.restaurant_name
from dim_restaurant r
where not exists (
    select 1
    from fact_swiggy_orders f
    where f.restaurant_id = r.restaurant_id
    and f.rating < 4
);


---Find restaurants whose monthly revenue is continuously decreasing for 3 consecutive months.
with montly_rev as(
select sum(f.price_inr)as revenue,dd.month as month,r.restaurant_id from fact_swiggy_orders f join dim_date dd
on f.date_id=dd.date_id join dim_restaurant r on f.restaurant_id=r.restaurant_id  group by dd.month
,r.Restaurant_id),

revenue_lag as(select restaurant_id,revenue,month,lag(revenue, 1) over (partition by restaurant_id order by month) as prev_month,
lag(revenue, 2) over (partition by restaurant_id order by month) as prev_2_month
from montly_rev)
select distinct restaurant_id from revenue_lag where revenue < prev_month 
and prev_month < prev_2_month
