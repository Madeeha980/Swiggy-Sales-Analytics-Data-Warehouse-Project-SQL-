Swiggy Sales Analytics & Data Warehouse Project (SQL)
Overview

This project builds a complete SQL-based Data Warehouse solution using a Swiggy-style food delivery dataset. It simulates a real-world Data Analyst and Data Warehousing workflow, covering data cleaning, dimensional modeling, ETL implementation, KPI generation, and advanced business analytics.

Database and Raw Data

Database: swiggy_db

Raw Table: swiggy_data

Data Validation and Cleaning

Row count verification

Null value checks (state, city, order_date, restaurant_name, price, rating)

Blank string detection

Duplicate detection using GROUP BY and HAVING

Duplicate removal using ROW_NUMBER() window function

These steps ensured clean and reliable data before warehouse modeling.

Data Warehouse Design (Star Schema)
Fact Table

fact_swiggy_orders

Includes:

price_inr

rating

rating_count

Foreign keys to all dimension tables

Dimension Tables

dim_date (year, month, quarter, week)

dim_location (state, city, area)

dim_restaurant

dim_category

dim_dish

The Star Schema structure improves query performance and supports scalable analytics.

ETL Process

Loaded distinct values into dimension tables

Generated surrogate keys using IDENTITY

Inserted data into fact table using joins

Verified warehouse with multi-table join validation

Key Performance Indicators (KPIs)

Total Orders

Total Revenue (INR Million)

Average Dish Price

Average Rating

Business Analytics Performed
Time-Based Analysis

Monthly orders and revenue trends

Quarterly and yearly trends

Day-of-week analysis

Running total revenue using window functions

Location-Based Analysis

Top cities by revenue

Revenue contribution by state

Price sensitivity analysis by city

Restaurant and Food Performance

Top restaurants by revenue

Top categories and most ordered dishes

Category-wise orders and average rating

Revenue contribution percentage by category

Customer Spending Analysis

Price range segmentation (Under 100, 100–199, 200–299, etc.)

Advanced SQL Analytics

Top restaurants per city using DENSE_RANK()

High revenue but low rating restaurants

Restaurants with no rating below 4 using NOT EXISTS

Restaurants with three consecutive months of revenue decline using LAG()

SQL Concepts Demonstrated

Data cleaning and validation

Common Table Expressions (CTEs)

Window functions (ROW_NUMBER, DENSE_RANK, LAG)

Subqueries

Aggregations and grouping

Trend detection logic

Star schema design principles

Business Value

This project demonstrates how raw transactional data can be transformed into a structured warehouse that enables:

Revenue trend monitoring

Performance benchmarking

Risk detection

Customer behavior insights

Location-based strategic analysis
