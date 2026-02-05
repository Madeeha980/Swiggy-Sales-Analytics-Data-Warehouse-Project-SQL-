# Swiggy Sales Analytics & Data Warehouse Project (SQL)

## Overview

This project focuses on analyzing Swiggy-style food delivery data using **SQL** to derive meaningful business insights. The goal is to simulate a real-world analytics workflow where raw transactional data is cleaned, structured, and transformed into a **data warehouse** that supports efficient reporting and decision-making.

The project is designed from a **data analyst perspective**, emphasizing data modeling, query optimization, and KPI-driven analysis rather than just writing basic SQL queries.

---

## Objectives

* Clean and prepare raw order data for analysis
* Design a structured **data warehouse (star schema)**
* Analyze sales, customer behavior, restaurants, and locations
* Generate insights that can help business stakeholders make informed decisions

---

## Dataset Description

The dataset represents food delivery transactions similar to Swiggy and includes information such as:

* Customer details
* Restaurant details
* City and location data
* Order dates and times
* Order value, quantity, and ratings

The raw data is first validated and cleaned to handle missing values, duplicates, and inconsistencies.

---

## Data Modeling

A **star schema** is implemented to support analytical queries:

### Fact Table

* **Fact_Orders**: Stores transactional data such as order amount, quantity, rating, and order date

### Dimension Tables

* **Dim_Customers**: Customer-related attributes
* **Dim_Restaurants**: Restaurant and cuisine details
* **Dim_Location**: City and area information
* **Dim_Date**: Date, month, quarter, and year attributes

This structure improves query performance and makes the analysis scalable.

---

## Key Analysis & KPIs

* Total and monthly sales revenue
* Top-performing cities and restaurants
* Customer spending patterns
* Popular cuisines and order frequency
* Rating distribution and service quality trends

All insights are generated using **SQL queries** with joins, aggregations, subqueries, and window functions.

---

## Skills & Concepts Used

* SQL (SELECT, JOINs, GROUP BY, HAVING)
* Subqueries and Common Table Expressions (CTEs)
* Window functions
* Data cleaning and validation
* Star schema & data warehousing concepts
* Business-oriented data analysis

---

## Business Value

This project demonstrates how raw transactional data can be converted into actionable insights. The analysis helps answer practical business questions such as:

* Which locations generate the highest revenue?
* Which restaurants and cuisines perform best?
* How does customer behavior change over time?

These insights can support marketing strategies, operational improvements, and revenue growth.

---

## Conclusion

This project showcases hands-on experience in **SQL-based analytics and data warehousing**, closely reflecting real industry use cases. It highlights the ability to think analytically, structure data efficiently, and translate numbers into business insights.

---

*This project is intended for learning and portfolio demonstration purposes.*
