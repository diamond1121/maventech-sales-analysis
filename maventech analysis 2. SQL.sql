create database maventech_analysis;
show databases;
use maventech_analysis;
create table Accounts ( Account varchar(150), Sector varchar(100), Year_established int, Revenue decimal(15,2), Employees int, Office_location varchar(100), Subsidiary varchar(10));
select * from accounts;
describe accounts;
create table Products (Product varchar(100), Series varchar(50), Sales_price decimal (15,2));
 alter table Products rename column sales_price to Sales_Price;
alter table Products rename column series to Series;
alter table Products rename column product to Product;
create table Sales_Teams (Sales_Agent varchar(100), Manager Varchar(100), Regional_Office varchar(100));
create table sales_pipeline (Opportunity_id varchar(50), Sales_Agent varchar(100), Product varchar(100), Account varchar(150), Deal_Stage varchar(30), Engage_Date date, Close_Date date, Close_Value decimal (15,2));
select * from accounts order by account;
select count(*) from accounts;
show warnings;
select count(*) as total_records, count(account) as Accounts_Not_Blank from accounts;
create table accounts_check like Accounts;
alter table accounts modify column subsidiary varchar(150);
drop table accounts_check;
select * from sales_pipeline;
select database();
show databases;
use maventech_analysis;
SELECT
    COUNT(*) AS Total_Records,
    COUNT(ENGAGE_DATE) AS Engage_Dates,
    COUNT(CLOSE_DATE) AS Close_Dates,
    COUNT(CLOSE_VALUE) AS Close_Values
FROM Sales_Pipeline_check;
select  count(*) sales_agent from sales_pipeline_check;
SELECT
    DEAL_STAGE,
    COUNT(*) AS Total_Opportunities
FROM Sales_Pipeline_check
GROUP BY DEAL_STAGE;
create table sales_pipeline_check like sales_pipeline;
select * from sales_pipeline_check;
truncate table sales_pipeline_check;
alter table sales_pipeline_check modify engage_date varchar(30);
alter table sales_pipeline_check modify close_date varchar(30);
alter table sales_pipeline_check modify close_value varchar(30);
select product, sum(close_value) as total_revenue from sales_pipeline_check where deal_stage = 'won' group by product order by total_revenue desc;
select deal_stage, sum(close_value) as close_value from sales_pipeline_check group by deal_stage;
select sales_agent, sum(close_value) as total_revenue
from sales_pipeline_check group by sales_agent order by 
total_revenue desc;
select sales_agent, count(deal_stage) as deals_completed from
 sales_pipeline_check where deal_stage ='won' group by
 sales_agent order by deals_completed desc;
select sales_agent, count(deal_stage) as deals_completed from
 sales_pipeline_check group by
 sales_agent order by deals_completed desc; 
 select sales_agent, round(avg(close_value),2) as average_deals from sales_pipeline_check
 where deal_stage = 'won' group by sales_agent order by average_deals desc;
 select * from sales_teams;
 SELECT
    sales_teams.regional_office,
    SUM(sales_pipeline_check.close_value) AS highest_revenue
FROM sales_pipeline_check
INNER JOIN sales_teams
ON sales_pipeline_check.sales_agent = sales_teams.sales_agent
WHERE sales_pipeline_check.deal_stage = 'Won'
GROUP BY sales_teams.regional_office
ORDER BY highest_revenue DESC;
SELECT
    sales_teams.regional_office,
    count(sales_pipeline_check.deal_stage) AS closed_deals
FROM sales_pipeline_check
INNER JOIN sales_teams
ON sales_pipeline_check.sales_agent = sales_teams.sales_agent
WHERE sales_pipeline_check.deal_stage = 'Won'
GROUP BY sales_teams.regional_office
ORDER BY closed_deals DESC;
select sales_teams.regional_office, round(avg(sales_pipeline_check.close_value),2) as average_deals from
sales_pipeline_check inner join sales_teams on 
sales_pipeline_check.sales_agent = sales_teams.sales_agent 
where sales_pipeline_check.deal_stage= 'won'
 group by sales_teams.regional_office 
order by average_deals desc;
SELECT
    sales_agent,
    COUNT(*) AS total_opportunities,
    SUM(CASE
        WHEN deal_stage = 'Won' THEN 1
        ELSE 0
    END) AS won_deals,
    ROUND(
        SUM(CASE
            WHEN deal_stage = 'Won' THEN 1
            ELSE 0
        END) / COUNT(*) * 100, 2
    ) AS win_rate
FROM sales_pipeline_check
GROUP BY sales_agent
ORDER BY win_rate DESC;
SELECT sales_agent, COUNT(*) AS lost_deals
FROM sales_pipeline_check
WHERE deal_stage = 'lost'
GROUP BY sales_agent
ORDER BY lost_deals DESC;
select sales_agent, count(*) as total_opportunities, 
SUM(case when deal_stage= 'lost' then 1 else 0 
end) as 
lost_deals,
round(sum(case when deal_stage='lost' then 1 else 0 end)/count(*)*100, 2) as lose_rate
from sales_pipeline_check 
group by sales_agent order by lose_rate desc;
select product, count(*) as won_deals from 
sales_pipeline_check where deal_stage='won' 
group by product order by won_deals desc;
select product, sum(close_value) as total_revenue from 
sales_pipeline_check where deal_stage='won' 
group by product order by total_revenue desc;
select product, round(avg(close_value), 2) as average_won_value from 
sales_pipeline_check where deal_stage='won' 
group by product order by average_won_value desc;
select account, sum(close_value) as total_won_revenue
from sales_pipeline_check 
where deal_stage='won' group by account
order by total_won_revenue desc;
select accounts.sector,
sum(sales_pipeline_check.close_value) as total_won_revenue
 from sales_pipeline_check inner join accounts on sales_pipeline_check.account=accounts.account
 where deal_stage='won'
 group by accounts.sector order by total_won_revenue desc;
 SELECT COUNT(DISTINCT sector)
FROM accounts;
select accounts.sector,
count(sales_pipeline_check.deal_stage) as total_won_deals
 from sales_pipeline_check inner join accounts on sales_pipeline_check.account=accounts.account
 where deal_stage='won'
 group by accounts.sector order by total_won_deals desc;
select sales_pipeline_check.product, accounts.sector,
sum(close_value) as highest_won_revenue from sales_pipeline_check
inner join accounts on sales_pipeline_check.account=accounts.account 
where sector='medical' and sales_pipeline_check.deal_stage='won'
 group by sales_pipeline_check.product, accounts.sector order by 
 highest_won_revenue desc;
select sales_pipeline_check.product, accounts.sector,
sum(close_value) as highest_won_revenue from sales_pipeline_check
inner join accounts on sales_pipeline_check.account=accounts.account 
where sector='retail' and sales_pipeline_check.deal_stage='won'
 group by sales_pipeline_check.product, accounts.sector order by 
 highest_won_revenue desc;
select accounts.sector,
round(avg (sales_pipeline_check.close_value),2) as average_won_deals from sales_pipeline_check
inner join accounts on sales_pipeline_check.account=accounts.account 
where sales_pipeline_check.deal_stage='won'
 group by accounts.sector order by 
 average_won_deals desc;
 select account, round(avg(close_value),2) as average_won_deal
 from sales_pipeline_check where deal_stage='won'
 group by account order by average_won_deal;
 select account, sum(close_value) as total_revenue
 from sales_pipeline_check where deal_stage='won'
 group by account order by total_revenue desc;
SELECT sales_agent,
SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) AS Won,
SUM(CASE WHEN deal_stage = 'Lost' THEN 1 ELSE 0 END) AS Lost,
SUM(CASE WHEN deal_stage = 'Engaging' THEN 1 ELSE 0 END) AS Engaging,
SUM(CASE WHEN deal_stage = 'Prospecting' THEN 1 ELSE 0 END) AS Prospecting,
COUNT(*) AS Total_Deals
FROM sales_pipeline_check
GROUP BY sales_agent
ORDER BY Total_Deals DESC;
SELECT
    COUNT(*) AS total_agents,
    SUM(CASE WHEN prospecting_deals > 0 THEN 1 ELSE 0 END) AS agents_prospecting,
    SUM(CASE WHEN prospecting_deals = 0 THEN 1 ELSE 0 END) AS agents_not_prospecting
FROM (
    SELECT
        sales_agent,
        SUM(CASE WHEN deal_stage = 'Prospecting' THEN 1 ELSE 0 END) AS prospecting_deals
    FROM sales_pipeline_check
    GROUP BY sales_agent
) AS agent_summary;
 
SELECT
    COUNT(*) AS total_deals,
    SUM(CASE
        WHEN deal_stage = 'Won' THEN 1
        ELSE 0
    END) AS won_deals,
    ROUND(
        SUM(CASE
            WHEN deal_stage = 'Won' THEN 1
            ELSE 0
        END) / COUNT(*) * 100, 2
    ) AS overall_win_rate
FROM sales_pipeline_check;

SELECT
    sum(CASE
        WHEN deal_stage = 'Won' THEN 1
        ELSE 0
    END) AS won_deals,sum(CASE
        WHEN deal_stage = 'Lost' THEN 1
        ELSE 0
    END) AS lost_deals,
ROUND(sum(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END)
        /
        SUM(CASE WHEN deal_stage IN ('Won', 'Lost') THEN 1 ELSE 0 END)
        * 100, 2
    ) AS won_lost_conversion_rate
FROM sales_pipeline_check;
select * from sales_pipeline_check;
SELECT
    st.sales_agent
FROM sales_teams stsales_pipeline_checksales_pipeline_check
LEFT JOIN sales_pipeline_check sp
    ON st.sales_agent = sp.sales_agent
WHERE sp.sales_agent IS NULL;



 