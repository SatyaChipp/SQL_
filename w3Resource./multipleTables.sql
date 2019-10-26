"""
Write a SQL statement to display all those orders by the customers not located in the same cities where their 
salesmen live.
"""

1.
select o.ord_no, o.customer_id, o.salesman_id, o.purch_amt, o.ord_date 
from orders o 
join customer c 
on o.customer_id = c.customer_id
join salesman s
on c.salesman_id = s.salesman_id
where c.city<>s.city;


2.
SELECT ord_no, cust_name, orders.customer_id, orders.salesman_id
FROM salesman, customer, orders
WHERE customer.city <> salesman.city
AND orders.customer_id = customer.customer_id
AND orders.salesman_id = salesman.salesman_id;

3.
select * from orders where customer_id in (select c.customer_id from customer
c inner join salesman s on c.salesman_id = s.salesman_id and c.city<>s.city);
