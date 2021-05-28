
-- @BLOCK
-- 1. Count the number of users per country
select 
  country_code as `Country Code`, 
  count(*) as `Total Users`
from Users
group by country_code

-- @BLOCK
-- 2. Count the number of orders per country
select 
  country_code as `Country Code`, 
  count(*) as `Total Orders`
from Users u
join Orders o on o.userID = u.userID
group by country_code

-- @BLOCK
-- 3.  Find the first order date of each user
select 
  u.userID,
  min(STR_TO_DATE(o.order_time,'%m/%d/%Y'))
from Users u
join Orders o on o.userID = u.userID
group by u.userID

-- @BLOCK
-- 4. Find the average GMV per country, sort from the highest
select
  country_code,
  avg(gmv) as `Average GMV`
from Users u
join Orders o on o.userID = u.userID
group by u.country_code 
order by avg(gmv) desc

-- @BLOCK
-- 5. Find the latest register time of each country
select
  country_code,
  max(STR_TO_DATE(o.order_time,'%m/%d/%Y')) as `Latest Register Time`
from Users u
join Orders o on o.userID = u.userID
group by u.country_code 

-- @BLOCK
-- 6. Find the number of users who made their order in each country, each day
select 
  u.country_code, 
  o.order_time, 
  count(distinct u.userID) as `Total Users`
from Users u
join (
  select 
    userID, 
    min(STR_TO_DATE(order_time,'%m/%d/%Y')) as order_time
  from Orders
  group by userID
) o on o.userID = u.userID
group by u.country_code, o.order_time

-- @BLOCK
-- 7. Find how many user are registering each day
select
  STR_TO_DATE(register_time,'%m/%d/%Y') as `Date`,
  count(userID)
from Users
group by STR_TO_DATE(register_time,'%m/%d/%Y')

-- @BLOCK
-- 8. Find the top 10 of user id who got the highest GMV
select
  u.userID,
  sum(o.gmv)
from Users u
join Orders o on o.userID = u.userID
group by u.userID
order by sum(o.gmv) desc
limit 10
