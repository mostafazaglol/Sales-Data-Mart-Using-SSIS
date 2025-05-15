use AdventureWorks2014 
go


select * from Production.Product
where ProductModelID is null


use EO_AdventureWorksDW2014
go

-- ===================== Dim_Product ==================================
select * from dim_product
select count(*) from dim_product

select product_key, product_key % 10
from dim_product

-- delete ~10% of records in dim_product
delete from dim_product 
where product_key % 10 = 6

-- update product color
update dim_product 
set color = 'Dark-Green'
where product_key % 10 =3

-- update reorder_point by adding 10% to the original value
update dim_product
set reorder_point = ROUND(reorder_point *1.1,0)
where product_key %10 =4




-- ===================== Dim_Customer ==================================
select * from dim_customer
select count(*) from dim_customer

select customer_id, customer_id % 10
from dim_customer

-- delete ~10% of records in dim_customer
delete from dim_customer 
where customer_id % 50 = 2

-- update city for ~10% in dim_customer
update dim_customer 
set city = 'cairo'
where city = 'paris'

-- update phone number 
update dim_customer
set phone = SUBSTRING(phone,10,3)+SUBSTRING(phone,4,5)+SUBSTRING(phone,9,1)+SUBSTRING(phone,1,3)
where 
	LEN(phone) = 12 and LEFT(phone,3) between '101' and '125'


-- update records - type 2
select customer_id , count(*)
from dim_customer
group by customer_id
having count(*) > 1

select * 
from dim_customer
where customer_id = 11036


-- ===================== Dim_Date ==================================

sp_help 'dim_date';


-- ===================== Fact_Sales ==================================
select * from fact_sales 




