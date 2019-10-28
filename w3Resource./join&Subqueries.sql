"""
 Write a query to find the sums of the amounts from the orders table, grouped by date, 
 eliminating all those dates where the 
 sum was not at least 1000.00 above the maximum amount for that date.
"""
select sum(a.purch_amt), a.ord_date
from orders a
group by ord_date
having sum(purch_amt) > (select 1000+max(purch_amt) from orders b where a.ord_date = b.ord_date);

"""
Write a query to extract the data from the customer table if and only if one or more of the 
customers in the customer table are located in London.
"""
select *
from customer c
where exists (select * from customer where city='London')
--or
where (select count(*) from customer where city='London')>1


"""
Write a query to find the salesmen who have multiple customers.
"""

select *
from salesman s
where s.salesman_id in 
(select distinct c.salesman_id from customer c group by c.salesman_id having count(c.customer_id)>1)

"""
Write a query that extract the rows of all salesmen who have customers with more than one orders.
"""

select * 
from salesman s 
where s.salesman_id in 
(select o.salesman_id from orders o group by o.salesman_id having count(o.ord_no)>1)

"""
 Write a query to display the salesmen which name are alphabetically lower than the name of the customers
"""
select *
from salesman s inner join customer c
on c.salesman_id = s.salesman_id
where lower(substring(s.name, 1, 1)) < lower(substring(c.cust_name, 1, 1))

"""
Write a SQL query to display the name of each company, price for their most expensive product along with their Name.
"""
select it.pro_price, cm.com_name, it.pro_name
from item_mast it inner join company_mast cm
on it.pro_com = cm.com_id
where it.pro_price = (select max(fd.pro_price) from item_mast fd where fd.pro_com = cm.com_id)

"""
Write a query to make a report of which salesman produce the largest and smallest orders on each date and
arranged the orders number in smallest to the largest number.
"""
SELECT a.salesman_id, ord_date
FROM salesman a, orders b
WHERE a.salesman_id =b.salesman_id
AND b.purch_amt=
	(SELECT MAX (purch_amt)
	FROM orders c
	WHERE c.ord_date = b.ord_date)
UNION
(SELECT b.salesman_id, b.ord_date
FROM orders b
WHERE b.purch_amt=
	(SELECT MIN (purch_amt)
	FROM orders c
	WHERE c.ord_date = b.ord_date))
