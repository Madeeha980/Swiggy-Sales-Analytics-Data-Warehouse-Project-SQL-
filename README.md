**Swiggy Sales Analytics & Data Warehouse Project (SQL)**
**Overview**

This project builds a complete SQL-based Data Warehouse solution using a Swiggy-style food delivery dataset.

The workflow includes:

Raw data validation and cleaning

Duplicate detection and removal

Star schema design

Dimension & fact table creation

ETL process implementation

KPI generation and advanced business analytics

The project simulates a real-world data analyst + data warehousing scenario using SQL Server.

**Database & Raw Data**

Database used: swiggy_db
Raw table: swiggy_data

Initial steps performed:

Row count validation

Null value checks (state, city, order_date, restaurant, price, rating, etc.)

Blank string detection

Duplicate detection using GROUP BY + HAVING

Duplicate removal using ROW_NUMBER() window function

This ensures clean and reliable data before warehouse modeling.

**Data Warehouse Design (Star Schema)**
Fact Table

fact_swiggy_orders

price_inr

rating

rating_count

Foreign keys to all dimensions

Dimension Tables

dim_date (year, month, quarter, week)

dim_location (state, city, area)

dim_restaurant

dim_category

dim_dish

The star schema improves query performance and supports scalable analytical reporting.

**ETL Process**

Loaded distinct values into dimension tables

Generated surrogate keys using IDENTITY

Inserted data into fact table using joins between raw data and dimensions

Verified warehouse using full join query across all dimensions
**
Key KPIs**

Total Orders

Total Revenue (INR Million)

Average Dish Price

Average Rating
**
Business Analytics Performed**
Time-Based Analysis

**Monthly Orders & Revenue Trends
**
Quarterly & Yearly Trends

Day-of-Week Order Analysis

Running Total Revenue (Window Function)

**Location Analysis**

Top Cities by Revenue

Revenue Contribution by State

Price Sensitivity by City

**Restaurant & Food Performance
**
Top Restaurants by Revenue

Top Categories & Most Ordered Dishes

Category-wise Orders + Average Rating

Revenue Contribution % by Category

**Customer Spending Analysis**

Price range segmentation (Under 100, 100–199, etc.)

**Advanced SQL Analytics**

Top Restaurants per City using DENSE_RANK()

High Revenue but Low Rating Restaurants

Restaurants with No Rating Below 4 (NOT EXISTS)

Restaurants with 3 Consecutive Months Revenue Decline using LAG()

**SQL Concepts Demonstrated**

Data Cleaning & Validation

CTEs (Common Table Expressions)

Window Functions (ROW_NUMBER, DENSE_RANK, LAG)

Subqueries

Aggregations & Grouping

Revenue Contribution % Calculation

Trend Detection Logic

Star Schema & Data Warehousing Principles

**Business Value**

This project demonstrates how raw transactional data can be transformed into a structured warehouse that enables:

Revenue trend monitoring

Performance benchmarking

Risk detection (declining revenue restaurants)

Customer behavior insights

Location-based strategic analysis

## Conclusion

This project showcases hands-on experience in **SQL-based analytics and data warehousing**, closely reflecting real industry use cases. It highlights the ability to think analytically, structure data efficiently, and translate numbers into business insights.

---

*This project is intended for learning and portfolio demonstration purposes.*
