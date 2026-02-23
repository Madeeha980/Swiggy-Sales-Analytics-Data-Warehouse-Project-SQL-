# Swiggy Orders Analytics Project

## Project Overview

This project focuses on building a comprehensive **data warehouse and analytics pipeline** for Swiggy orders data. The goal is to extract actionable business insights from raw transactional data, perform data cleaning, construct a dimensional model, and generate meaningful Key Performance Indicators (KPIs) and analytics reports.

The workflow follows a typical **ETL (Extract, Transform, Load)** process, with the creation of fact and dimension tables and advanced analytics queries for business intelligence purposes.

---

## Dataset

The dataset (`swiggy_data`) contains detailed information about Swiggy orders, including:

* State and city of the order
* Restaurant and dish details
* Category of cuisine
* Price, ratings, and rating counts
* Order dates and locations

**Note:** The data was cleaned to handle missing values, blanks, and duplicates before loading into the data warehouse.

---

## Data Warehouse Design

The project implements a **star schema** with the following tables:

### Dimension Tables

1. **dim_date** – Contains details about order dates, including year, month, quarter, day, and week.
2. **dim_location** – Stores state, city, and specific location details.
3. **dim_restaurant** – Stores unique restaurant names.
4. **dim_category** – Stores cuisine categories.
5. **dim_dish** – Stores unique dish names.

### Fact Table

**fact_swiggy_orders** – Contains the transactional data for each order, linking to all dimension tables through foreign keys. Metrics include:

* Price (`price_inr`)
* Rating
* Rating count

---

## ETL Process

1. **Data Cleaning & Validation:**

   * Null and blank value detection
   * Duplicate detection and removal
   * Standardizing column names and formats

2. **Dimension Tables Population:**

   * Inserted distinct values for date, location, restaurant, category, and dishes.
   * Generated surrogate keys using `IDENTITY`.

3. **Fact Table Population:**

   * Joined raw data with dimension tables using natural keys.
   * Loaded transactional data into the fact table.

---

## Key Metrics & Analytics

The project includes the following KPIs and analytics:

* **Total Items Ordered**
* **Total Revenue (INR Million)**
* **Average Dish Price**
* **Average Rating**

**Trends & Insights:**

* Monthly, quarterly, and yearly order trends
* Orders by day of the week
* Top cities, states, and restaurants by revenue
* Most popular dishes and cuisine categories
* Customer spending analysis (price range segmentation)
* Rating distribution analysis

**Advanced Analytics:**

* Restaurants with high revenue but low ratings
* Restaurants that never received a rating below 4
* Restaurants with consistently declining monthly revenue for 3 consecutive months

---

## Tools & Technologies

* **Database:** SQL Server
* **SQL Techniques:** CTEs, ROW_NUMBER, LAG, aggregation, joins, window functions
* **Analytics:** KPIs, revenue contribution, ranking, and trend analysis

---

## How to Run

1. Clone the repository.

2. Import the `swiggy_data` table into your SQL Server database.

3. Run the SQL scripts in the following order:

   1. Data cleaning and validation
   2. Dimension table creation and population
   3. Fact table creation and population
   4. KPI and analytics queries

4. Optionally, join the fact table with dimension tables for a comprehensive view of the dataset.

---

## Project Outcome

This project demonstrates a complete **data warehouse workflow** with a focus on business intelligence analytics for a food delivery platform. It provides insights for decision-making, revenue analysis, customer behavior, and restaurant performance evaluation.

---

## Author

Madeeha Khanum
BCA Student | Data Analytics & Business Intelligence Enthusiast

