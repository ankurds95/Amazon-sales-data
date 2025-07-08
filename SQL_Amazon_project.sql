use amazon_project;
select * from amazon;
SELECT `Date`, `Time` FROM amazon LIMIT 5;
Alter table amazon
ADD Time_of_day varchar(20),
ADD Day_name VARCHAR(20),
ADD Month_name VARCHAR(20);

SET SQL_SAFE_UPDATES = 0;

UPDATE amazon
SET Time_of_day = 
    CASE 
        WHEN HOUR(STR_TO_DATE(`Time`, '%H:%i:%s')) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN HOUR(STR_TO_DATE(`Time`, '%H:%i:%s')) BETWEEN 12 AND 16 THEN 'Afternoon'
        ELSE 'Evening'
    END
WHERE `Invoice ID` IS NOT NULL;
UPDATE amazon
SET Day_name = DAYNAME(STR_TO_DATE(`Date`, '%Y-%m-%d'));
UPDATE amazon
SET Month_name = MONTHNAME(STR_TO_DATE(`Date`, '%Y-%m-%d'));

select * from amazon;

-- Q-1 What is the count of distinct cities in the dataset?
Solution: 
select distinct city from amazon;
Insights: 
There are three distinct cities where order took place these are Yangon, Naypytiaw, Mandalay.

-- Q-2 For each branch, what is the corresponding city?
Solution: 
select branch, city, count(branch) as count_branch from amazon group by branch, city;
Insights: 
There 340 branch of A in Yangon which is the highest.
-- Q-3 What is the count of distinct product lines in the dataset?
Solution: 
select `product line`, count(`product line`) as count_of_product_lines from amazon group by `product line`;
Insights: 
By using this query we find that there are 152 product lines of Health and beauty, 
170 product lines of Electronics accessories and so on.

-- Q-4 Which payment method occurs most frequently?
Solution: 
select max(payment) as most_payment_method, count(payment) as count_payment_method from amazon group by payment;
Insights: 
I found that Ewallet payment method is most frequently occurs. 

-- Q-5 Which product line has the highest sales?
Solution: 
select `product line`, max(total) as highest_sales from amazon group by `product line` order by `product line`;
Insights: 
Fashion accessories product has the highest sale of 1042.65

Q-6 How much revenue is generated each month?
Solution: 
select month(date) as month, sum(total) as revenue from amazon group by month(date) order by month(date); 
Insights: Revenue by month: January: 116291.87, February: 97219.37, March: 108721.25
January generated the highest revenue.

Q-7 In which month did the cost of goods sold reach its peak?
Solution: 
select month(date) as month, sum(cogs) as total_cogs from amazon group by month(date) order by sum(cogs) desc;
Insights: The month of January had the highest COGS of 110754.16.

Q-8 Which product line generated the highest revenue?
Solution: 
select `product line`, sum(total) as highest_revenue from amazon group by `product line` order by sum(total) desc;
Insights: 
I found that food and beverages has the highest revenue of 56144.84 . 
while Sports and travel sector comes in the second position in revenue. 

Q-9 In which city was the highest revenue recorded?
Solution: 
select city, sum(total) as highest_revenue from amazon group by city order by sum(total) desc
Insights: 
If we calculate the highest revenue as per the city then Naypyitaw comes on first position with the amount of 110568.70 rupees. 
While Yangon is on second top position.

Q-10 Which product line incurred the highest Value Added Tax?
Solution: 
select `product line`, sum(`tax 5%`) as highest_value_added_tax from amazon group by `product line` order by sum(`tax 5%`) desc;
Insights: 
Sports and travel sector is one of the sector which payed highest value added tax with the amount of 2624.89 rupees 
And Health and beauty is the top lowest sector in the country which payes low value added tax.

Q-11 For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
Solution: 
select `product line`,  sum(total) as total_sales,
       case 
         when sum(total) > (select avg(total) from amazon) then 'good'
         else 'bad'
       end as sales_status
from amazon
group by `product line`;
Insights: Product lines like Food and beverages and Fashion accessories are marked "Good" for exceeding average sales.

Q-12 Identify the branch that exceeded the average number of products sold.
Solution: 
select branch, sum(quantity) as total_products_sold from amazon group by branch having sum(quantity)>(select avg(quantity)*3 from amazon);
Insights: Branch A exceeded the average product sales threshold across all branches.

Q-13 Which product line is most frequently associated with each gender?
Solution: 
select gender, `product line`, count(*) as freq
from amazon
group by gender, `product line`
qualify row_number() over (partition by gender order by count(*) desc) = 1;
Insights: 
Males most frequently purchase Food and beverages.
Females prefer Fashion accessories.

Q-14 Calculate the average rating for each product line.
Solution: 
select `product line`, round(avg(rating),2) as avg_rating from amazon group by `product line` order by avg(rating) desc;
Insights: 
By using this query I found that food and beverages has the highest average rating 7.11 
and Fasion accesssories comes under second position. 

Q-15 Count the sales occurrences for each time of day on every weekday.
Solution: 
Insights: 

Q-16 Identify the customer type contributing the highest revenue.
Solution: 
select `customer type`, round(sum(total),2) as highest_revenue from amazon group by `customer type` order by sum(total) desc;
Insights: 
People who are member of amazon gave highest revenue that amound is 164223.44 rupees.

Q-17 Determine the city with the highest VAT percentage.
Solution: 
select city, round(sum(`tax 5%`),2) as highest_VAT from amazon group by city order by sum(`tax 5%`) desc;
Insights: 
The city Naypyitaw earned highest vat 5265.18 rupees from the user of amazon.

Q-18 Identify the customer type with the highest VAT payments.
Solution: 
select `customer type`, round(sum(`tax 5%`),2) as highest_VAT from amazon group by `customer type` order by sum(`tax 5%`) desc;
Insights: 
I found that the member of the amazon are giving highest vat with the amount of 7820.16 rupee.

Q-19 What is the cosunt of distinct customer types in the dataset?
Solution: 
select distinct `customer type`, count(`customer type`) as number_of_distinct_customer_type from amazon
 group by `customer type` order by count(`customer type`) desc;
Insights: 
members are higher then normal user of amazon the data is---
Member	501
Normal	499

Q-20 What is the count of distinct payment methods in the dataset?
Solution: 
select distinct payment, count(payment) as count_payment_methods from amazon group by payment order by count(payment) desc;
Insights: 
user of ewallet are higher than cash and credit card. data is given blow
Ewallet	345
Cash	344
Credit card	311

Q-21 Which customer type occurs most frequently?
Solution: 
select distinct `customer type`, count(`customer type`) as most_customer_type from amazon 
group by `customer type` order by count(`customer type`) desc;
Insights: 
In the data I found data member are most frequently user of amazon.

Q-22 Identify the customer type with the highest purchase frequency.
Solution: 
select `customer type`, round(sum(total),2) as highest_purchase from amazon group by `customer type` order by sum(total) desc;
Insights: 
Particular Member of amazon are the customer type whose purchase frequency is highest. 
In 2019 the Members ordered with the amount of 164223.44 rupees.

Q-23 Determine the predominant gender among customers.
Solution: 
select distinct gender, count(gender) as predominant_gender from amazon group by gender order by count(gender) desc ;
Insights: 
Amazon data surprised that predominantly gender is female, who shopped more than male thogh the difference is not much higher.
Female	501
Male	499

Q-24 Examine the distribution of genders within each branch.
Solution: 
select  branch, gender, count(gender) as count_of_gneder from amazon group by branch, gender order by branch, count(gender) desc;
Insights: 
Male of branch A are higher while femalie of branch C are higher than among. The data is given below.
A	Female	161
B	Male	170
B	Female	162
C	Female	178
C	Male	150

Q-25 Identify the time of day when customers provide the most ratings.
Solution: 
select time_of_day, count(rating) as count_rating from amazon group by time_of_day order by count_rating desc;
Insights: Customers rated most frequently in the Evening.

Q-26 Determine the time of day with the highest customer ratings for each branch.
Solution: 
select branch, time_of_day, round(avg(rating), 2) as avg_rating from amazon group by branch, time_of_day order by branch, avg_rating desc;
Insights: 
Branch A: Highest ratings during Evening.
Branch B: Highest during Morning.
Branch C: Highest in the Afternoon.

Q-27 Identify the day of the week with the highest average ratings.
Solution: 
select day_name, round(avg(rating), 2) as avg_rating from amazon
group by day_name
order by avg_rating desc;

Insights: Friday received the highest average rating (~7.1).

Q-28 Determine the day of the week with the highest average ratings for each branch.
Solution: 
select branch, day_name, round(avg(rating), 2) as avg_rating from amazon
group by branch, day_name
order by branch, avg_rating desc;
Insights: 
Branch A: Highest ratings on Friday
Branch B: Highest on Monday
Branch C: Highest on Wednesday

