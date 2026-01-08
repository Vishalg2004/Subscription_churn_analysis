create database Subscription_data;
use Subscription_data;

create table subscription_data(
	Customer_ID int primary key,
    Name varchar(100),
    Email varchar(100),
    Country varchar(100),
    Subscription_plan varchar(50),
    Sign_up_date date,
    Monthly_rate decimal(10,2),
    Is_Active boolean,
    Last_login date,
    Support_tickets int
);
select * from subscription_data;
select count(*) from subscription_data;

# Calculate Churn rate:
select count(*) as Total_customers, 
sum(case when Is_Active = 0 then 1 else 0 end) as churned_count,
round((sum(case when Is_Active = 0 then 1 else 0 end) * 100.0/ count(*)), 2) as churn_pct
from subscription_data;

# Calculate revenue leakage:
select Subscription_plan,
sum(Monthly_rate) as lost_revenue
from subscription_data
where Is_Active = 0
group by Subscription_plan;

# Identify at risk:
select Customer_ID, Email, Support_tickets
from subscription_data
where Is_Active = 1
	and Last_login > 30
    and Support_tickets > 5;
    