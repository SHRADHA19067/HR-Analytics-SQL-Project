/*HR analytics SQL Project using SQL
tools mysql*/
-- step1:create database
create database hr_db2;
use hr_db2;
-- step2:create table
create table department(dept_id int primary key,dept_name varchar(30) not null);
create table employee(emp_id int primary key ,emp_name varchar(30) not null, gender char(1),age int,salary decimal (10,2),dept_id int,join_date date,foreign key(dept_id) references department(dept_id));
select*from department;
select * from  employee;
-- insert into sample data
insert into department values(1,"HR"),(2,"Finance"),(3,"IT"),(4,"Sales"),(5,"Marketing");
insert into employee values
(101, 'Amit', 'M', 28, 45000.00, 3, '2020-06-15'),
(102, 'Shradha', 'F', 26, 40000.00, 1, '2021-01-10'),
(103, 'Ravi', 'M', 30, 55000.00, 3, '2019-08-20'),
(104, 'Neha', 'F', 29, 60000.00, 2, '2018-03-12'),
(105, 'Divya', 'F', 25, 35000.00, 4, '2022-02-18'),
(106, 'Karan', 'M', 35, 75000.00, 2, '2017-11-05'),
(107, 'Arjun', 'M', 27, 38000.00, 1, '2020-09-09'),
(108, 'Sneha', 'F', 31, 70000.00, 3, '2016-04-25'),
(109, 'Rohit', 'M', 33, 65000.00, 4, '2019-07-10'),
(110, 'Pooja', 'F', 24, 30000.00, 5, '2023-01-15');
-- step4: add constraints
alter table department 
add constraint unique_dept_name unique(dept_name);
alter table employee
add constraint foreignkey_dept_id foreign key(dept_id) references department(dept_id);
alter table employee
add constraint check_salary check(salary>0);
alter table employee
add constraint check_age check(age>=18);
alter table employee
-- step5: alter table operations
add column bonus decimal(10,2);
alter table employee
add column position varchar(30);
alter table employee
modify position varchar(50);
alter table employee
rename column position to position_job_role;
alter table employee
drop column bonus;
-- step6: update and delete operations
update employee set salary=48000 where emp_id=101;


SELECT emp_id, emp_name, salary, postion_job_role FROM employee;
alter table employee 
drop column postion_job_role;

Update employee
SET position_job_role = 'Software Developer'
WHERE emp_id = 101;

Update employee
SET position_job_role = 'HR Associate'
WHERE emp_id = 102;

Update employee
SET position_job_role = 'IT Manager'
WHERE emp_id = 103;

Update employee
SET position_job_role = 'Finance Analyst'
WHERE emp_id = 104;
Alter table employee
Add bonus decimal(10,2);
update employee set bonus=5000
where emp_id in(101,102,103);
update employee set dept_id=3 where emp_id=107;
delete from employee where emp_id=110;

-- step7: basic select
select * from  employee;

-- step 8:filtering queries

select emp_name,salary from employee where salary>50000;
select emp_name,gender,dept_id from employee where gender="F"and dept_id=1;
select emp_name,dept_id from employee where dept_id =2 or dept_id=3;
select *from employee where emp_name like"s%";
select*from employee where dept_id in(1,4);
select*from employee where age between 25 and 30;
select * from employee where salary between 40000 and 60000;
select * from employee where gender="m";
select*from employee where emp_name like"%a";
select * from employee where dept_id in (2,3,4);
select avg(salary) from employee;

-- step 9:group by with aggregate functions
select dept_id,avg(salary) from employee group by dept_id;
select dept_id,count(*) from employee group by dept_id;
select dept_id,max(salary) from employee group by dept_id;

-- step 10 :group by with having
select dept_id,count(*) from employee group by dept_id having count(*)>2;
select dept_id,avg(salary) from employee group by dept_id having avg(salary)>50000;
select dept_id,sum(salary) from employee group by dept_id having sum(salary)>100000;
select dept_id,max(salary) from employee group by dept_id having max(salary)>60000;

-- step 11:joins
select e.emp_name,e.salary,d.dept_name from employee e inner join department d on e.dept_id=d.dept_id; 
select e.emp_name,d.dept_name from employee e join department d on e.dept_id=d.dept_id where dept_name="IT";
select e.emp_name,e.emp_id,e.gender,e.salary,d.dept_name from employee e join department d on e.dept_id=d.dept_id;
select e.emp_name,d.dept_name from employee e left join department d on e.dept_id=d.dept_id;

-- step 12: subqueries
select*from employee where salary>(select avg(salary) from employee);
select * from employee where dept_id=(select dept_id from department where dept_name="IT");
select*from employee where salary>(select max(salary) from employee);

-- step 13: HR Analytics queries
select e.emp_name, e.salary, d.dept_name
from employee e
join department d on e.dept_id = d.dept_id
where e.salary = (
    select MAX(salary)
    from employee
    where dept_id = e.dept_id
);
select gender, COUNT(*) 
from employee
group by gender;
select d.dept_name, SUM(e.salary) as total_salary
from employee e
join department d on e.dept_id = d.dept_id
group by d.dept_name
order by total_salary desc
limit 1;
select d.dept_name, avg(e.age) 
from employee e
join department d on e.dept_id = d.dept_id
group by d.dept_name;

-- step 14: data cleaning
select * from employee where dept_id is null;
select * from employee where salary is null;
select* from employee where salary<=0;
select*from employee where age<18;
select*from employee where dept_id not in(1,2,3,4,5);

-- step 15:Final cleaned dataset
desc employee;
desc department;
select*from employee order by emp_id;