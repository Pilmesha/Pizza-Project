select * from pizza_sales_excel_file

---KPI

--total price of pizza orders
select sum(total_price) as total_revenue from pizza_sales_excel_file

-- average order value(not using avg function because of duplicates in the data)
select sum(total_price) / COUNT(distinct order_id) as AverageOrderValue from pizza_sales_excel_file

--total pizzas sold
select sum(quantity) as TotalSold from pizza_sales_excel_file

--total orders made
select COUNT(distinct order_id) as TotalOrders from pizza_sales_excel_file

--average pizzas per order(precisely)
select cast(sum(quantity) as decimal(10,2))/cast(COUNT(distinct order_id) as decimal(10,2))  as AveragePizzasPerOrder from pizza_sales_excel_file

--requirnments for chart

--daily trend for orders
select datename(DW, order_date) as order_day, COUNT(distinct order_id) as total_orders
from pizza_sales_excel_file
group by datename(DW, order_date)

--monthly trend for orders ordered descending
select datename(month, order_date) as order_month, COUNT(distinct order_id) as total_orders
from pizza_sales_excel_file
group by datename(month, order_date)
order by total_orders desc

--sales by pizza category
select pizza_category, sum(total_price)*100 / (select sum(total_price) from pizza_sales_excel_file) as Sales_Percentage
from pizza_sales_excel_file
group by pizza_category

--sales by pizza category month of January
select pizza_category, 
sum(total_price)*100 / (
select sum(total_price) 
from pizza_sales_excel_file 
where datename(month, order_date) like 'January'
) as Sales_Percentage
from pizza_sales_excel_file
where datename(month, order_date) like 'January'
group by pizza_category

--sales by pizza size ordered by sales percentage descending
select pizza_size,
sum(total_price) as Total_Sales,
sum(total_price)*100 / (
select sum(total_price)
from pizza_sales_excel_file) as Sales_Percentage
from pizza_sales_excel_file
group by pizza_size 
order by Sales_Percentage desc

--sales by pizza size ordered by sales percentage descending and in the first quarter
select pizza_size,
sum(total_price) as Total_Sales,
sum(total_price)*100 / (
select sum(total_price)
from pizza_sales_excel_file 
where datepart(quarter, order_id) = 1) as Sales_Percentage
from pizza_sales_excel_file
where datepart(quarter, order_id) = 1
group by pizza_size 
order by Sales_Percentage desc

--top 5 best sellers

select top 5 pizza_name, sum(total_price) as Total_revenue
from pizza_sales_excel_file
group by(pizza_name)
order by Total_revenue desc

--top 5 worst sellers
select top 5 pizza_name, sum(total_price) as Total_revenue
from pizza_sales_excel_file
group by(pizza_name)
order by Total_revenue asc

--top 5 best pizzas by quantity
select top 5 pizza_name, sum(quantity) as Total_quantity
from pizza_sales_excel_file
group by(pizza_name)
order by Total_quantity desc

--top 5 worst pizzas by quantity
select top 5 pizza_name, sum(quantity) as Total_quantity
from pizza_sales_excel_file
group by(pizza_name)
order by Total_quantity asc

--top 5 best pizzas by order
select top 5 pizza_name, count(distinct order_id) as Total_orders
from pizza_sales_excel_file
group by(pizza_name)
order by Total_orders desc

--top 5 worst pizzas by orders
select top 5 pizza_name, count(distinct order_id) as Total_orders
from pizza_sales_excel_file
group by(pizza_name)
order by Total_orders asc