create table customers(
	customer_id	int4
	,first_name text
	,last_name text
	,gender varchar(6)
	,DOB date
	,job_title text
	,job_industry_category text
	,wealth_segment text
	,deceased_indicator varchar(3)
	,owns_car varchar(3)
	,address text
	,postcode int4
	,state 	text
	,country text
	,property_valuation int4
)

create table transactions(
	transaction_id	int4
	,product_id	int4
	,customer_id int4
	,transaction_date date
	,online_order	varchar(10)
	,order_status	varchar(10)
	,brand	text
	,product_line	varchar(10)
	,product_class	varchar(10)
	,product_size	varchar(10)
	,list_price	float4
	,standard_cost float8
)

select distinct brand
from transactions t 
where standard_cost> 1500

select transaction_id
from transactions t 
where order_status = 'Approved' and transaction_date between '2017-04-01'::timestamp and '2017-04-09'::timestamp

select job_title
from customers c 
where (job_industry_category = 'IT' or job_industry_category = 'Financial Services') and job_title like 'Senior%'

select brand
from transactions t 
where customer_id in (select customer_id from customers c where job_industry_category = 'Financial Services')

select *
from customers c 
where customer_id in (select customer_id from transactions t where online_order = 'True' and 
	(brand = 'Giant Bicycles' or brand = 'Norco Bicycles' or brand = 'Trek Bicycles'))
limit 10

select *
from customers c 
where customer_id not in (select customer_id from transactions t)


select *
from customers c 
where job_industry_category = 'IT' and customer_id in (select customer_id from transactions t 
	where standard_cost = (select max(standard_cost) from transactions t))
	
select *
from customers c 
where (job_industry_category = 'IT' or job_industry_category = 'Health') and customer_id in (select customer_id
	from transactions t where order_status = 'Approved' and transaction_date between '2017-07-07'::timestamp and '2017-07-17'::timestamp)