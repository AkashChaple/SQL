use orders;
#1
select product_class_code,product_id,product_desc,product_price,
case   when PRODUCT_CLASS_CODE =2050 then 
product_price+2000  when PRODUCT_CLASS_CODE= 2051 then product_price+500 
 when PRODUCT_CLASS_CODE=2052 then product_price+600  else PRODUCT_PRICE end as new_product_price from product order by PRODUCT_CLASS_CODE desc ;
 
 #2
 select product_class_code,product_desc,PRODUCT_PRICE from product natural join order_items natural join order_header where order_status in ('shipped');
 
 #3
 select CUSTOMER_ID,CUSTOMER_FNAME,CUSTOMER_EMAIL,ORDER_ID,PRODUCT_DESC,PRODUCT_QUANTITY_AVAIL,(PRODUCT_PRICE*PRODUCT_QUANTITY_AVAIL) as sabtotal from online_customer natural join order_header natural join order_items natural join product ;
 
 #4
select  customer_id,CUSTOMER_FNAME,CUSTOMER_LNAME,PINCODE,ORDER_ID,PRODUCT_DESC,ORDER_DATE,PRODUCT_CLASS_DESC,(PRODUCT_PRICE*PRODUCT_QUANTITY_AVAIL) as sabtotal from address natural join online_customer natural join order_header natural join order_items natural join product natural join product_class
where pincode not like '%0%'  and ORDER_STATUS in ('shipped')  order by CUSTOMER_FNAME,order_date,sabtotal;
#5
select distinct customer_id,CUSTOMER_FNAME,CUSTOMER_LNAME,city from address natural join online_customer  natural join order_header natural join order_items natural join product natural join product_class where state not in ('karnataka') and PRODUCT_CLASS_DESC not in ('toys','books');
#6
select distinct CUSTOMER_FNAME,CUSTOMER_LNAME,order_id,product_quantity from online_customer natural join order_header natural join order_items group by ORDER_ID having sum(PRODUCT_QUANTITY)>=10 ;
#7
select  CUSTOMER_LNAME,sum(product_quantity*product_price) as total_value from online_customer natural join order_header natural join order_items natural join product
group by CUSTOMER_LNAME having sum(PRODUCT_QUANTITY*PRODUCT_PRICE)>100000; 
#8
select customer_id,CUSTOMER_FNAME,CUSTOMER_LNAME, (product_quantity) from online_customer natural join order_header natural join order_items where order_id>10060 group by customer_id;
#9
select product_id,product_class_desc,product_desc,PRODUCT_QUANTITY_AVAIL from product natural join product_class;
select product_id,product_class_desc,product_desc,PRODUCT_QUANTITY_AVAIL, (case when product_class_desc  in ('Electronics','computer') and PRODUCT_QUANTITY_AVAIL<30 then 'low stock' when product_class_desc  in ('Electronics','computer') and PRODUCT_QUANTITY_AVAIL between 11 and 30 then 'In stock' when product_class_desc  in ('Electronics','computer') and PRODUCT_QUANTITY_AVAIL>31 then 'enough stock'
when product_class_desc  in ('Clothes','Stationery') and PRODUCT_QUANTITY_AVAIL<30 then 'low stock' when product_class_desc  in ('Clothes','Stationery') and PRODUCT_QUANTITY_AVAIL between 21 and 81 then 'In stock' when product_class_desc  in ('Clothes','Stationery') and PRODUCT_QUANTITY_AVAIL>81 then 'enough stock'
when product_class_desc not  in ('Clothes','Stationery','Electronics','computer') and PRODUCT_QUANTITY_AVAIL<15 then 'low stock' when product_class_desc not  in ('Clothes','Stationery','Electronics','computer') and PRODUCT_QUANTITY_AVAIL between 15 and 50 then 'In stock' when product_class_desc not  in ('Clothes','Stationery','Electronics','computer') and PRODUCT_QUANTITY_AVAIL>51 then 'enough stock' when PRODUCT_QUANTITY_AVAIL=0 then 'out of stock'
end) as new_one from product natural join product_class;