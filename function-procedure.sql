show tables;
use classicmodels;
select * from customers limit 1;
# select column_name, data_type
# from information_schema.columns
# where table_name = 'customers';
# select * from information_schema.columns
# where table_name = 'orders';

select * from orders;

create function date_before(
    p_date date,
    p_difference int
)
    returns date
    reads sql data
begin
    declare p_res_date date;
    set p_res_date = date_sub(p_date, interval p_difference day);
    return p_res_date;
end;

select date_before(curdate(), 2);
select date_before(curdate(), 3);


# return all orders has order date in a range
delimiter $$
create procedure orders_in_date_range(
    in p_start_date date,
    in p_end_date date
)
begin
    select * from orders where orderDate between p_start_date and p_end_date;
end $$;


select * from orders where orderDate between '2003-04-01' and'2003-04-30';

call orders_in_date_range('2003-04-01', '2003-04-30');

# return orders in a day
select orderDate, count(orderNumber) as order_per_day from orders group by orderDate;
select orderDate, count(orderNumber) as order_per_day from orders group by orderDate order by order_per_day desc limit 1;
select date_format(orders.orderDate, '%d-%m-%Y') as orderDateFormat, count(orderNumber) as ordersPerDay
from orders
group by orderDate
order by ordersPerDay desc;
select dayofweek(now()) as weekday_index;
select dayname(now()) as weekday_name;
# return orders number per customes
select * from customers;
select * from orders;

select c.customerNumber, c.customerName, count(o.orderNumber) as totalOrder from orders o
                                                                                     join customers c
where o.customerNumber = c.customerNumber
group by c.customerNumber, c.customerName;

select * from customers c join orders o