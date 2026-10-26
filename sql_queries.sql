select*
from cleaned_customer_shopping_behavior1;

select gender, avg(purchase_amount)
from cleaned_customer_shopping_behavior1
group by gender;

select customer_id,purchase_amount
from cleaned_customer_shopping_behavior1
where discount_applied ='Yes' and purchase_amount>(
	select avg(purchase_amount)
    from cleaned_customer_shopping_behavior1);
    
    
    select distinct item_purchased,avg(review_rating) as avg_rating
    from cleaned_customer_shopping_behavior1
    group by item_purchased
    order by avg_rating desc
    limit 5
    ;
    
    select shipping_type,avg(purchase_amount)
    from cleaned_customer_shopping_behavior1
    where shipping_type in ('Express','Standard')
	group by shipping_type;
    
    
  select count(customer_id),subscription_status, sum(purchase_amount) as spend ,avg(purchase_amount)
  from cleaned_customer_shopping_behavior1
  group by subscription_status;
  
select subscription_status,
COUNT(customer_id) as total_customers,
ROUND(AVG(purchase_amount),2) as avg_spend,
ROUND(SUM(purchase_amount),2) as total_revenue
from cleaned_customer_shopping_behavior1
group by subscription_status
order by total_revenue, avg_spend desc;


select item_purchased,
round(100*Sum(case when discount_applied="Yes" Then 1 else 0 end)/count(*),2) as discount
from cleaned_customer_shopping_behavior1
group by item_purchased
order by discount desc
limit 5;

with customer_type as(select customer_id, previous_purchases,
case
	when previous_purchases=1 then 'New'
    when previous_purchases between 2 and 10 then 'Returning'
    else 'Loyal'
end as customer_segment
from cleaned_customer_shopping_behavior1
order by previous_purchases Desc)

select customer_segment,count(customer_id) as no_of_customers
from customer_type
group by customer_segment
order by no_of_customers desc
;
with item_counts as(
select category,item_purchased,count(item_purchased) as count_of_purchase
from cleaned_customer_shopping_behavior1
group by category,item_purchased)
select category,item_purchased,max(count_of_purchase)
from item_counts
group by category,item_purchased

order by category,count_of_purchase desc


;

with item_count as (
select category,item_purchased,count(customer_id) as item_sell,
row_number() over (partition by category order by count(customer_id) desc) as item_rank
from cleaned_customer_shopping_behavior1
group by category,item_purchased)

select category,item_purchased,item_sell
from item_count
where item_rank<=3;


select count(customer_id),subscription_status
from cleaned_customer_shopping_behavior1
where previous_purchases>=5
group by subscription_status
;
select age_group,
sum(purchase_amount) as total_revenue
from cleaned_customer_shopping_behavior1
group by age_group
order by total_revenue desc;


