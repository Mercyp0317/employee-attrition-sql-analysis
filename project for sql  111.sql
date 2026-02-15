create table Employees(
Employee_id serial primary key not null,
Age int,
Gender varchar(50),
Job_Role varchar(250),
Hire_date date 
)

create table Salary(
Employee_ID int,
Monthly_Salary varchar(100),
foreign key(employee_ID) references employees(Employee_ID) 
)

create table Attendance(
Employee_ID int,
Working_Hours int,
foreign key(Employee_ID) references Employees
(Employee_ID))

create table Attrition (
Employee_ID int,
Attrition_Status varchar(50),
Exit_date varchar(50),
foreign key(EMployee_ID) references Employees(Employee_ID))

insert into employees(age,gender,job_role,Hire_Date)
values
(25,'Male','Data Analyst','2022-01-10'),
(30,'Female','HR Executive','2021-03-15'),
(28,'Male','Software Engineer','2020-07-01'),
(35,'Female','Manager','2019-02-20')

insert into salary values(1,40000),
(2,35000),
(3,60000),
(4,80000)

insert into attendance values(1,9),(2,8),(3,10),(4,7)


select * from Attrition

insert into attrition values
(1,'Yes','2023-08-01'),
(2,'No',Null),
(3,'Yes','2022-12-15'),
(4,'No',Null)

select * from employees


select * from attrition
where Attrition_Status = 'Yes' 

select count(*) as total_employees,
sum (case when Attrition_Status = 'Yes' then 1 else 0 end) as resigned_employees,
round(
sum (case when attrition_status = 'Yes' then 1 else 0 end ) *100.0
/count(*) ,2)
as attirtion_rate 
from attrition

select  e.job_role,
count(*) as attrition_count
from employees e
join attrition a
on e.employee_ID = a.employee_ID
where attrition_status = 'Yes'
group by job_role
order by attrition_Count Desc

select attrition_status,
round(avg(cast (s.monthly_salary as int)),2) as average_salary
from salary s
join attrition a
on s.employee_ID = a.employee_ID
group by a.attrition_status
order by a.attrition_status

select e.job_role,
round(sum(
case when a.attrition_status = 'Yes' then 1 else 0 end  ) *100.0
/count(*),2)
as attrition_rate
from employees e
join attrition a
on e.employee_ID = a.employee_ID
group by e.job_role
order by attrition_rate desc
limit 1

select 
e.Employee_id, 
e.Age ,
e.Gender ,
e.Job_Role ,
e.Hire_date 
from employees e
join attrition a
on e.employee_ID = a.employee_ID
where a.attrition_status = 'Yes'
and a.Exit_date :: Date <= e.Hire_date + Interval '2 Years'


