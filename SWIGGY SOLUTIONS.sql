use swiggy_schema;

-- 1. HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?
select
	count(distinct restaurant_name) as restaurant_count_greater_ratings
from
	swiggy
where rating > 4.5;

-- 2. WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?
select
	city as top_city,
    count(distinct restaurant_name) as restaurant_count
from
	swiggy
group by
	city
order by restaurant_count desc
limit 1;

-- 3. HOW MANY RESTAURANTS HAVE THE WORD "PIZZA" IN THEIR NAME?
select
	count(distinct restaurant_name) as count_restaurant_having_pizza
from
	swiggy
where restaurant_name like '%Pizza%';

-- 4. WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET?
select
	cuisine,
    count(*) as cuisine_count
from
	swiggy
group by 
	1
order by
	2 desc
limit
	1;

-- 5. WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?
select
	city,
    round(avg(rating),2) as average_rating
from
	swiggy
group by
	1
order by
	2 desc;
-- 6. WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENU CATEGORY FOR EACH RESTAURANT?
select
	distinct restaurant_name,
    menu_category,
    max(price) as highest_price
from
	swiggy
where
	menu_category = 'Recommended'
group by
	1,2;
    
-- 7. FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE. 
select
	distinct restaurant_name,
    cost_per_person 
from
	swiggy
where cuisine != 'Indian'
order by cost_per_person desc
limit 5;


-- 8. FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER.
select
	distinct restaurant_name,
    cost_per_person
from
	swiggy
where
cost_per_person >(select
avg(cost_per_person) from swiggy);

-- 9. RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES.
select
	distinct t1.restaurant_name,
    t1.city,
    t2.city
from
	swiggy
    t1 join swiggy t2 on t1.restaurant_name=t2.restaurant_name and t1.city!=t2.city;
    
-- 10. WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE' CATEGORY?
select
	distinct restaurant_name,
    menu_category,
    count(item) as no_of_items
from swiggy
where
	menu_category='Main Course'
group by 1,2
order by 3 desc
limit 1;

-- 11. LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN IN ALPHABETICAL ORDER OF RESTAURANT NAME.

select
	distinct restaurant_name,
    (count(case when veg_or_nonveg='veg' then 1 end)*100/count(*)) as vegeterian_percentage
from
	swiggy
group by 1
having vegeterian_percentage=100.00
order by 1;


-- 12. WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS.
select
	distinct restaurant_name,
    round( avg(price),2) as avg_lowest_price
from
	swiggy
group by 1
order by 2 asc
limit 1;

-- 13. WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?
select
	restaurant_name,
    count(distinct menu_category) as number_of_categories_offer
from
	swiggy
group by 1
order by 2 desc
limit 5;

-- 14. WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?

select
	distinct restaurant_name,
    (count(case when veg_or_nonveg='Non-veg' then 1 end)*100/count(*)) as highest_non_vegeterian_percentage
from
	swiggy
group by 
	1
order by 
	2 desc
limit
	1;

