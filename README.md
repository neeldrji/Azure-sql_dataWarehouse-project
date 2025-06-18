# Azure Data Warehouse and Analytics Project

Welcome to the **Azure Data Warehouse and Analytics Project** repository! 🚀  
This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best practices in data engineering and analytics.

## 🏗️ Data Architecture

Data from CRM and ERP systems is stored as CSV files in Azure Blob Storage containers.
It is then ingested into Azure SQL DB, where it flows through Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:

![Data Architecutre](https://github.com/user-attachments/assets/b1fb5e91-d03f-4e78-ae32-58e18556d8da)

1. **Bronze Layer**: Stores raw data without transformation.
2. **Silver Layer**: Performs standardization, cleansing, and enrichment.
3. **Gold Layer**: Applies business logic and aggregates data into analytical views.

---
## 📖 Project Overview

This project involves:

1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
2. **ETL Pipelines**: Extracting, loading and transforming data from source systems into the warehouse.
3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
4. **Analytics & Reporting**: Creating SQL-based reports and dashboards for actionable insights.

---

### :chart: BI: Analytics & Reporting (Data Analysis)

#### Objective
Develop SQL-based analytics to deliver detailed insights into:
- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

![PowerBI Report](https://github.com/user-attachments/assets/21aa5831-221f-4957-a03c-0a29dc39fa9b)

These insights empower stakeholders with key business metrics, enabling strategic decision-making.
