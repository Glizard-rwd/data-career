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



# calculate total order prices
select o.orderNumber, o.customerNumber, sum((od.quantityOrdered * priceEach)) as totalPrice
from orderdetails od
         join orders o where o.orderNumber = od.orderNumber
group by o.orderNumber
order by totalPrice desc;


select o.orderDate, count(distinct o.orderNumber) as orderNumber, sum((od.quantityOrdered * od.priceEach)) as totalPricePerDay from orders o
join orderdetails od on o.orderNumber = od.orderNumber
group by o.orderDate
order by totalPricePerDay desc;



SELECT
    YEAR(o.orderDate) as orderYear,
    MONTH(o.orderDate) AS orderMonth,
    COUNT(DISTINCT o.orderNumber) AS orderNumber,
    SUM(od.quantityOrdered * od.priceEach) AS totalPricePerMonth
FROM
    orders o
        JOIN
    orderdetails od
    ON
        o.orderNumber = od.orderNumber
GROUP BY
    YEAR(o.orderDate),
    MONTH(o.orderDate)
ORDER BY
    totalPricePerMonth DESC;



# find orders has max and min money in each month
select
    year(o.orderDate) as orderYear,
    month(o.orderDate) as orderMonth,
    o.orderNumber,
    sum(od.quantityOrdered * od.priceEach) as orderPrice
from orders o join orderdetails od on o.orderNumber = od.orderNumber
group by
    year(o.orderDate),
    month(o.orderDate),
    o.orderNumber
order by orderYear, orderMonth, orderPrice desc;

select * from orders;

# shipped ratio in each month
with monthlyTotalOrders as
    (select
        year(o1.orderDate) as year,
        month(o1.orderDate) as month,
        count(distinct o1.orderNumber) as count
    from orders o1
    join orderdetails o2 on o1.orderNumber = o2.orderNumber
    group by year(o1.orderDate), month(o1.orderDate))
select
    year(o.orderDate) as orderYear,
    month(o.orderDate) as orderMonth,
    count(o.orderNumber) as shippedOrders,
    o1.count as totalOrder,
    count(o.orderNumber) / o1.count as shippedRatio
from orders o join monthlyTotalOrders o1
    on year(o.orderDate) = o1.year and month(o.orderDate) = o1.month
where o.status = 'Shipped'
group by
    year(o.orderDate), month(o.orderDate), o1.count
order by orderYear, orderMonth;

# calculate monthly profit
select
    year(orderDate),
    month(orderDate),
    sum(od.priceEach * od.quantityOrdered) as totalMonthlyProfit
from orders o join orderdetails od on o.orderNumber = od.orderNumber
group by month(orderDate), year(orderDate)
order by totalMonthlyProfit desc;


select * from orderdetails;

# most favourite product
select
    p.productCode,
    p.productName,
    sum(distinct od.quantityOrdered) as totalQuantityOrdered
from orderdetails od join products p on od.productCode = p.productCode
group by p.productCode, productName;

select
    year(o.orderDate) as year,
    month(o.orderDate) as month,
    p.productCode,
    p.productName,
    sum(od.quantityOrdered) as orderTotal
from orders o join orderdetails od on o.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
group by year, month, p.productCode, p.productName
order by year, month, orderTotal desc;
