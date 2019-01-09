How many campaigns and sources does CoolTShirts use and how are they related? Be sure to explain the difference between utm_campaign and utm_source.

Select Count(Distinct utm_campaign)As 'Campaign'
       From page_visits; 

Select Count(Distinct utm_source)As 'Source'
From page_visits; 
 

What pages are on their website?

Select Distinct page_name
From page_visits;



How many first touches is each campaign responsible for?

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_attr AS (
  SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
    pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp)
Select ft_attr.utm_source AS 'Source',
       ft_attr.utm_campaign AS 'Campaign',
       Count(*) As ' First Touch Count'
From ft_attr
Group by 1, 2
Order by 3 DESC;

How many last touches is each campaign responsible for?

WITH last_touch AS(
Select user_id, Max(timestamp) AS last_touch_at
From page_visits
Group by user_id),
lt_attr AS (
Select lt.user_id,
       lt.last_touch_at,
       pv.utm_source,
      pv.utm_campaign
From last_touch lt
Join page_visits pv
On lt.user_id = pv.user_id
And lt.last_touch_at = pv.timestamp)
Select
	lt_attr.utm_source As 'Source',
  lt_attr.utm_campaign As 'Campaign',
  Count(*) As 'Last Touch Count'
From lt_attr
Group by 1,2
Order by 3 DESC;

How many visitors make a purchase?

Select Count(Distinct user_id)
From page_visits
Where page_name = '4 - purchase';

How many last touches on the purchase page is each campaign responsible for? 

WITH last_touch AS(
Select user_id, Max(timestamp) AS last_touch_at
From page_visits
Where page_name = '4 - purchase'
Group by user_id),
lt_attr AS (
Select lt.user_id,
       lt.last_touch_at,
       pv.utm_source,
      pv.utm_campaign
From last_touch lt
Join page_visits pv
On lt.user_id = pv.user_id
And lt.last_touch_at = pv.timestamp)
Select
  lt_attr.utm_source As 'Source',
  lt_attr.utm_campaign As 'Campaign',
  Count(*) As 'Last Touch Count'
From lt_attr
Group by 1,2
Order by 3 DESC;

Counting distinct user visits by source

Select utm_source AS 'Source', Count(Distinct user_id)As 'Users Visits'
From page_visits
Group by 1
Order by 2 DESC;

Counting number of users from checkout and purchase

Select  page_name, Count(Distinct user_id)
From page_visits
WHere page_name = '3 - checkout'
OR page_name = '4 - purchase'
Group by 1
Order by 2 Asc;

