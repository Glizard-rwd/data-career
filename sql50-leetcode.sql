use query;
Create table If Not Exists Teacher (teacher_id int, subject_id int, dept_id int);
Truncate table Teacher;
insert into Teacher (teacher_id, subject_id, dept_id) values ('1', '2', '3');
insert into Teacher (teacher_id, subject_id, dept_id) values ('1', '2', '4');
insert into Teacher (teacher_id, subject_id, dept_id) values ('1', '3', '3');
insert into Teacher (teacher_id, subject_id, dept_id) values ('2', '1', '1');
insert into Teacher (teacher_id, subject_id, dept_id) values ('2', '2', '1');
insert into Teacher (teacher_id, subject_id, dept_id) values ('2', '3', '1');
insert into Teacher (teacher_id, subject_id, dept_id) values ('2', '4', '1');

select * from teacher;

select Teacher.teacher_id, count(distinct Teacher.subject_id) as cnt from Teacher
group by Teacher.teacher_id;

# USER activity for the past 30 days
Create table If Not Exists Activity (user_id int, session_id int, activity_date date, activity_type ENUM('open_session', 'end_session', 'scroll_down', 'send_message'));
Truncate table Activity;
insert into Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'scroll_down');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'end_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-20', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-21', 'send_message');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-21', 'end_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'send_message');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'end_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('4', '3', '2019-06-25', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('4', '3', '2019-06-25', 'end_session');


select * from Activity;

select activity_date, count(distinct user_id) from Activity
where activity_date between date_sub('2019-07-27', interval 29 day) and '2019-07-27'
group by activity_date;



select activity_date, count(distinct user_id) from Activity
where activity_date between date_sub('2019-07-27', interval 29 day) and '2019-07-27'
group by activity_date; # more faster query


Create table If Not Exists Sales (sale_id int, product_id int, year int, quantity int, price int);
Create table If Not Exists Product (product_id int, product_name varchar(10));
Truncate table Sales;
insert into Sales (sale_id, product_id, year, quantity, price) values ('1', '100', '2008', '10', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('2', '100', '2009', '12', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('7', '200', '2011', '15', '9000');
    Truncate table Product;
insert into Product (product_id, product_name) values ('100', 'Nokia');
insert into Product (product_id, product_name) values ('200', 'Apple');
insert into Product (product_id, product_name) values ('300', 'Samsung');

select * from sales;

select * from product;

/*
 first find the min year corresponding to the product
 then find the record matching the min year
 */

 with cte as (
     select product_id, min(s2.year) as min_year from sales s2 group by product_id
 )
 select s.product_id, s.year as first_year, s.quantity, s.price
 from sales s join cte on s.product_id = cte.product_id and s.year = cte.min_year;




Create table If Not Exists Courses (student varchar(255), class varchar(255));
Truncate table Courses;
insert into Courses (student, class) values ('A', 'Math');
insert into Courses (student, class) values ('B', 'English');
insert into Courses (student, class) values ('C', 'Math');
insert into Courses (student, class) values ('D', 'Biology');
insert into Courses (student, class) values ('E', 'Math');
insert into Courses (student, class) values ('F', 'Computer');
insert into Courses (student, class) values ('G', 'Math');
insert into Courses (student, class) values ('H', 'Math');
insert into Courses (student, class) values ('I', 'Math');

select * from courses;

select class from courses group by class having count(student) >= 5;


Create table If Not Exists Followers(user_id int, follower_id int);
Truncate table Followers;
insert into Followers (user_id, follower_id) values ('0', '1');
insert into Followers (user_id, follower_id) values ('1', '0');
insert into Followers (user_id, follower_id) values ('2', '0');
insert into Followers (user_id, follower_id) values ('2', '1');

select * from followers;
select user_id, count(Followers.follower_id) as followers_count
from Followers
group by user_id
order by user_id;

Create table If Not Exists MyNumbers (num int);
Truncate table MyNumbers;
insert into MyNumbers (num) values ('8');
insert into MyNumbers (num) values ('8');
insert into MyNumbers (num) values ('3');
insert into MyNumbers (num) values ('3');
insert into MyNumbers (num) values ('1');
insert into MyNumbers (num) values ('4');
insert into MyNumbers (num) values ('5');
insert into MyNumbers (num) values ('6');

select * from MyNumbers;
with cte as (select num
             from MyNumbers
             group by num
             having count(num) < 2)
select max(num) as num from cte;


Create table If Not Exists Customer (customer_id int, product_key int);
Create table Product (product_key int);
Truncate table Customer;
insert into Customer (customer_id, product_key) values ('1', '5');
insert into Customer (customer_id, product_key) values ('2', '6');
insert into Customer (customer_id, product_key) values ('3', '5');
insert into Customer (customer_id, product_key) values ('3', '6');
insert into Customer (customer_id, product_key) values ('1', '6');
    Truncate table Product;
drop table Product;
insert into Product (product_key) values ('5');
insert into Product (product_key) values ('6');


select * from Product;
/*
 count total number of product
 count distinct number of product of each user
 find the user who buy fit to the total product
 */
select * from Product;

select Customer.customer_id
from Customer
group by Customer.customer_id
having count(distinct product_key) = (select count(*) from Product); # too slow


Create table If Not Exists Employees(employee_id int, name varchar(20), reports_to int, age int);
Truncate table Employees;

insert into Employees (employee_id, name, reports_to, age) values ('9', 'Hercy', NULL, '43');
insert into Employees (employee_id, name, reports_to, age) values ('6', 'Alice', '9', '41');
insert into Employees (employee_id, name, reports_to, age) values ('4', 'Bob', '9', '36');
insert into Employees (employee_id, name, reports_to, age) values ('2', 'Winston', NULL, '37');
select e2.employee_id, e2.name, count(e1.employee_id) as report_counts, round(avg(e1.age)) as average_age from employees e1
join employees e2 on e1.reports_to = e2.employee_id
group by e2.employee_id, e2.name
order by e2.employee_id;


Create table If Not Exists Employee (employee_id int, department_id int, primary_flag ENUM('Y','N'));
Truncate table Employee;
insert into Employee (employee_id, department_id, primary_flag) values ('1', '1', 'N');
insert into Employee (employee_id, department_id, primary_flag) values ('2', '1', 'Y');
insert into Employee (employee_id, department_id, primary_flag) values ('2', '2', 'N');
insert into Employee (employee_id, department_id, primary_flag) values ('3', '3', 'N');
insert into Employee (employee_id, department_id, primary_flag) values ('4', '2', 'N');
insert into Employee (employee_id, department_id, primary_flag) values ('4', '3', 'Y');
insert into Employee (employee_id, department_id, primary_flag) values ('4', '4', 'N');



select Employee.employee_id, Employee.department_id from Employee
where primary_flag = 'Y' or employee_id in (
    select employee_id from Employee group by employee_id having count(department_id) = 1
    );


Create table If Not Exists Triangle (x int, y int, z int);
Truncate table Triangle;
insert into Triangle (x, y, z) values ('13', '15', '30');
insert into Triangle (x, y, z) values ('10', '20', '15');

select x, y, z,
       if(x + y > z and y + z > x and z + x > y, 'Yes', 'No') as triangle
from triangle;


Create table If Not Exists Logs (id int, num int);
Truncate table Logs;
insert into Logs (id, num) values ('1', '1');
insert into Logs (id, num) values ('2', '1');
insert into Logs (id, num) values ('3', '1');
insert into Logs (id, num) values ('4', '2');
insert into Logs (id, num) values ('5', '1');
insert into Logs (id, num) values ('6', '2');
insert into Logs (id, num) values ('7', '2');


select num from Logs group by num having count(id) > 3;

with cte as (
    select num,
           lag(num) over (order by id) as previous_num,
           lead(num) over (order by id) as next_num
    from logs
)
select distinct num as ConsecutiveNums from cte
where num = cte.previous_num and num = cte.next_num;


Create table If Not Exists Products (product_id int, new_price int, change_date date);
Truncate table Products;
insert into Products (product_id, new_price, change_date) values ('1', '20', '2019-08-14');
insert into Products (product_id, new_price, change_date) values ('2', '50', '2019-08-14');
insert into Products (product_id, new_price, change_date) values ('1', '30', '2019-08-15');
insert into Products (product_id, new_price, change_date) values ('1', '35', '2019-08-16');
insert into Products (product_id, new_price, change_date) values ('2', '65', '2019-08-17');
insert into Products (product_id, new_price, change_date) values ('3', '20', '2019-08-18');

select * from Products;




select
    product_id,
    10 as price
from
    Products
group by product_id
having min(change_date) > '2019-08-16'
union all
select Products.product_id,
       Products.new_price as price
from Products
where (product_id, change_date) in (
        select product_id, max(change_date)
        from Products
        where change_date <= '2019-08-16'
        group by product_id
        );


Create table If Not Exists MyNumbers (num int);
Truncate table MyNumbers;
insert into MyNumbers (num) values ('8');
insert into MyNumbers (num) values ('8');
insert into MyNumbers (num) values ('3');
insert into MyNumbers (num) values ('3');
insert into MyNumbers (num) values ('1');
insert into MyNumbers (num) values ('4');
insert into MyNumbers (num) values ('5');
insert into MyNumbers (num) values ('6');


select * from MyNumbers;



# Write your MySQL query statement below
with cte as (
    select num from MyNumbers group by num having count(num) = 1
)
select max(num) as num from cte;



Create table If Not Exists Queue (person_id int, person_name varchar(30), weight int, turn int);
Truncate table Queue;
insert into Queue (person_id, person_name, weight, turn) values ('5', 'Alice', '250', '1');
insert into Queue (person_id, person_name, weight, turn) values ('4', 'Bob', '175', '5');
insert into Queue (person_id, person_name, weight, turn) values ('3', 'Alex', '350', '2');
insert into Queue (person_id, person_name, weight, turn) values ('6', 'John Cena', '400', '3');
insert into Queue (person_id, person_name, weight, turn) values ('1', 'Winston', '500', '6');
insert into Queue (person_id, person_name, weight, turn) values ('2', 'Marie', '200', '4');

with cte as (select *,
                    sum(Queue.weight) over (order by Queue.turn) as cSum
             from Queue)
select person_name from cte where cte.cSum <= 1000 order by turn desc limit 1;



Create table If Not Exists Accounts (account_id int, income int);
Truncate table Accounts;
insert into Accounts (account_id, income) values ('3', '108939');
insert into Accounts (account_id, income) values ('2', '12747');
insert into Accounts (account_id, income) values ('8', '87709');
insert into Accounts (account_id, income) values ('6', '91796');

select 'Low Salary' as category,
       sum(income < 20000) as accounts_count
from Accounts
UNION ALL
select 'Average Salary' as category,
       sum(income >= 20000 and income <= 50000) as accounts_count
from Accounts
UNION ALL
select 'High Salary' as category,
       sum(income > 50000) as accounts_count
from Accounts;


Drop table if exists Employees;
Create table If Not Exists Employees (employee_id int, name varchar(20), manager_id int, salary int);
Truncate table Employees;
insert into Employees (employee_id, name, manager_id, salary) values ('3', 'Mila', '9', '60301');
insert into Employees (employee_id, name, manager_id, salary) values ('12', 'Antonella', NULL, '31000');
insert into Employees (employee_id, name, manager_id, salary) values ('13', 'Emery', NULL, '67084');
insert into Employees (employee_id, name, manager_id, salary) values ('1', 'Kalel', '11', '21241');
insert into Employees (employee_id, name, manager_id, salary) values ('9', 'Mikaela', NULL, '50937');
insert into Employees (employee_id, name, manager_id, salary) values ('11', 'Joziah', '6', '28485');

select * from employees;

use query;
select * from Employees where salary < 30000;

select employee_id from Employees where salary < 30000
    and manager_id is not null
    and manager_id not in (select employee_id from Employees);


Create table If Not Exists Seat (id int, student varchar(255));
Truncate table Seat;
insert into Seat (id, student) values ('1', 'Abbot');
insert into Seat (id, student) values ('2', 'Doris');
insert into Seat (id, student) values ('3', 'Emerson');
insert into Seat (id, student) values ('4', 'Green');
insert into Seat (id, student) values ('5', 'Jeames');

select * from Seat;

with cte as (
    select max(id) as max_id from Seat
)
select
    s.id,
    case
        when s.id = cte.max_id and (cte.max_id % 2 = 1) then s.student
        when (s.id % 2 = 0) then lag(s.student, 1) over (order by s.id)
        when (s.id % 2 = 1) then lead(s.student, 1) over (order by s.id)
        end as student
from Seat s
         cross join cte;


SELECT IF (id < (SELECT MAX(id) FROM Seat), -- keep the last record
           IF(id % 2 = 0, id - 1, id + 1),
           IF(id % 2 = 0, id - 1, id)
       ) AS id, student
FROM Seat
ORDER BY id;

