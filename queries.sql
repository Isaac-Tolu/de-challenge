-- a. How many products have been sold with profits?
select count(*) as no_of_products_sold_with_profits
from fact_transactions ft join dim_products dp
    on ft.product_id = dp.id
where ft.transaction_amount > (dp.price * ft.quantity_bought);  -- was it a profit?

-- b. Calculate the total amount of profits?
select sum(ft.transaction_amount - (dp.price * ft.quantity_bought))
    as total_profits
from fact_transactions ft join dim_products dp
    on ft.product_id = dp.id
where ft.transaction_amount > (dp.price * ft.quantity_bought);

-- c. Which brand is performing the best?
select dp.brand, count(*) as brand_count
from fact_transactions ft join dim_products dp
    on ft.product_id = dp.id
group by dp.brand

-- d. Sort the customers from the most important to the least important
select dc.first_name, dc.last_name
from fact_transactions ft join dim_customers dc
    on ft.customer_id = dc.id
group by dc.id, dc.first_name, dc.last_name
order by count(*) desc

-- e. Which product do the men buy the most?
select dp.name, count(*) as times_bought
from fact_transactions ft join dim_products dp
    on ft.product_id = dp.id
    join dim_customers dc 
        on ft.customer_id = dc.id
where dc.gender = 'Male'
group by dp.name
order by times_bought

-- f. Is there a product that both men and women love?
select dp.name, dc.gender, count(*) as times_bought
from fact_transactions ft join dim_products dp
    on ft.product_id = dp.id
    join dim_customers dc 
        on ft.customer_id = dc.id
where dc.gender = 'Male' or dc.gender = 'Female'
group by dp.name, dc.gender
order by dp.name, dc.gender, times_bought