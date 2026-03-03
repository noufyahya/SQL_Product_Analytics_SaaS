-- ============================================================
-- PROJECT: Revenue & Profitability Analysis
-- Objective:
-- Analyze revenue performance, profitability, and margin distribution
-- across products, customers, regions, and time.
-- The goal is to identify key revenue drivers and profit optimization opportunities.
-- ============================================================




-- ------------------------------------------------------------
-- 1️⃣ Revenue & Profit by Product
-- Business Question:
-- Which products generate the most revenue?
-- Are high-revenue products also high-margin?
-- This helps identify strategic products to scale or optimize.
-- ------------------------------------------------------------


SELECT 
    Product,
    SUM(Sales) AS total_revenue,
    SUM(Profit) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS margin_percent
FROM sales_data
GROUP BY Product
ORDER BY total_revenue DESC;



-- ------------------------------------------------------------
-- 2️⃣ Revenue by Customer Segment
-- Business Question:
-- Which customer segments contribute most to revenue?
-- This supports segmentation strategy and customer prioritization.
-- ------------------------------------------------------------
select Segment ,
sum(Sales) as total_sales
from sales_data
group by Segment 
order by total_sales desc

-- ------------------------------------------------------------
-- 3️⃣ Revenue by Region
-- Business Question:
-- Which geographic regions drive the highest revenue?
-- Useful for regional expansion and operational allocation decisions.
-- ------------------------------------------------------------

select Region  ,
sum(Sales) as total_sales
from sales_data
group by Region  
order by total_sales desc


-- ------------------------------------------------------------
-- 4️⃣ Revenue by Industry
-- Business Question:
-- Which industries generate the strongest revenue streams?
-- Helps evaluate concentration risk and diversification opportunities.
-- ------------------------------------------------------------
select Industry ,
sum(Sales) as total_sales
from sales_data
group by Industry  
order by total_sales desc


-- ------------------------------------------------------------
-- 5️⃣ Monthly Revenue Trend by Product
-- Business Question:
-- How does revenue evolve over time?
-- Date formatting logic converts raw text into YYYY-MM format.
-- ------------------------------------------------------------
SELECT 
    strftime('%Y-%m',
        date(
            substr(order_date, -4) || '-' || 
            printf('%02d', substr(order_date, 1, instr(order_date, '/') - 1)) || '-' ||
            printf('%02d',
                substr(
                    order_date,
                    instr(order_date, '/') + 1,
                    instr(substr(order_date, instr(order_date, '/') + 1), '/') - 1
                )
            )
        )
    ) AS month,
    Product ,
    SUM(sales) AS revenue
FROM sales_data
GROUP BY month
ORDER BY month;

-- ------------------------------------------------------------
-- 6️⃣ Margin Distribution by Product
-- Business Question:
-- Which products are most profitable on average?
-- Highlights products that create value vs. those that erode margin.
-- Important for pricing and cost optimization decisions.
-- ------------------------------------------------------------
SELECT Product,
avg(Profit /Sales)*100 as avg_margin 
from sales_data 
group BY Product 
order by avg_margin desc



