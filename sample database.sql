-- create database
create database sample;
use sample;
-- create table customers
create table customer_data(
customer_id int primary key,
customer_name varchar(100),
email varchar(100),
city varchar(50),
join_date date
);
-- inserted values for customers
insert into customer_data values
(1, 'Amit Sharma', 'amit@gmail.com', 'Mumbai', '2023-01-10'),
(2, 'Neha Verma', 'neha@gmail.com', 'Delhi', '2023-02-15'),
(3, 'Ravi Patel', 'ravi@gmail.com', 'Ahmedabad', '2023-03-20'),
(4, 'Pooja Singh', 'pooja@gmail.com', 'Mumbai', '2023-04-05');
-- create table products
create table products(
product_id int primary key,
product_name varchar(100),
category varchar(50),
price decimal(10,2)
);
-- inserted values for products
insert into products values
(101, 'Tomato', 'Vegetable', 30.00), 
(102, 'Potato', 'Vegetable', 25.00), 
(103, 'Apple', 'Fruit', 120.00), 
(104, 'Banana', 'Fruit', 50.00);
-- created table orders
create table orders(
order_id int primary key,
customer_id int,
order_date date,
foreign key (customer_id) references customer_data(customer_id)
);
-- inserted values for orders
insert into orders values
(1001, 1, '2023-06-01'),
(1002, 2, '2023-06-03'),
(1003, 1, '2023-06-10'),
(1004, 3, '2023-06-15');
-- created table order items
create table order_items(
order_item_id int primary key,
order_id int,
product_id int,
quantity int,
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id)
);
-- inserted values for order items
insert into order_items values
(1, 1001, 101, 2),
(2, 1001, 104, 5),
(3, 1002, 103, 1),
(4, 1003, 102, 3),
(5, 1004, 104, 10);
-- show data
select * from customer_data;
select * from products;
select * from orders;
select * from order_items;
-- query for customers from mumbai
select * from customer_data where city = 'Mumbai';
-- products cheaper than 60/-
select * from products where price < 60;
-- orders placed in june
select * from orders where month(order_date) = 6;
-- fruits sorted by price (high to low) 
select * from products where category = 'Fruit' order by price desc;
-- count how many customers are there in each city
select count(customer_id) as customers, city from customer_data group by city;
-- total number of orders per customers
select count(order_id) as total_orders, customer_id from orders group by customer_id;
-- show customer name and order date(join)
select c.customer_name, o.order_date
from customer_data c
join orders o
on c.customer_id = o.customer_id;
-- find total amount spent by each customer
select c.customer_name, sum(oi.quantity*p.price) as total_spent 
from customer_data c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
group by c.customer_id, c.customer_name;
-- show customer name and product name for each order
select c.customer_name, p.product_name from customer_data c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id =  p.product_id;
-- show all customer names and their cities
select customer_name, city from customer_data;
-- show all orders placed in june2023
select * from orders where month(order_date) = 6;
-- show customer name and order date for each order
desc orders;
select * from orders limit 1;
select c.customer_name, o.order_date
from customer_data c 
join orders o 
on c.customer_id = o.customer_id;
-- show customer name and product name where product ordered is apple
select c.customer_name, p.product_name
from customer_data c
join orders o on c.customer_id = o.customer_id
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id
where product_name = 'Apple';
-- find total number of orders placed by each customer
select c.customer_name, count(o.order_id) as total_orders
from customer_data c
join orders o
on c.customer_id = o.customer_id
group by c.customer_name;