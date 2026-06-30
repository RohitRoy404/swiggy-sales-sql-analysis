# 🍽️ Swiggy Sales SQL Analysis

## 📌 Project Overview

This project analyzes a **197K+ Swiggy food delivery dataset** using **MySQL** to extract valuable business insights related to restaurant performance, customer ratings, pricing, and revenue trends.

The project demonstrates real-world SQL data analysis techniques, including data cleaning, aggregation, window functions, Common Table Expressions (CTEs), ranking functions, and business-oriented SQL queries.

---

## 📊 Dataset Information

- **Dataset:** Swiggy Food Delivery Dataset
- **Database:** MySQL
- **Records:** 197,000+
- **Rows:** 197K+
- **Columns:** 9

### Dataset Columns

- State
- City
- Order_Date
- Restaurant_Name
- Location
- Category
- Dish_Name
- Price
- Rating
- Rating_Count

---

# 🛠 SQL Skills Demonstrated

### ✔ Data Cleaning

- Removed Duplicate Records
- Checked NULL Values
- Data Validation
- Data Quality Checks

### ✔ SQL Concepts Used

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- Aggregate Functions
- CASE WHEN
- CTE (Common Table Expression)
- Subqueries
- Window Functions
- ROW_NUMBER()
- DENSE_RANK()

---

# 📈 Business Questions Solved

### Revenue Analysis

- Top 5 Restaurants by Total Revenue
- City-wise Monthly Revenue
- Highest Revenue Restaurant in Each City
- Revenue Contribution of Top Dishes

### Customer Rating Analysis

- Highest Rated Restaurant in Each City
- Best Performing Category in Each City
- Average Rating Analysis

---

# 💡 Sample SQL Query

```sql
WITH revenue_cte AS
(
    SELECT
        City,
        Restaurant_Name,
        SUM(Price) AS Total_Revenue,
        ROW_NUMBER() OVER
        (
            PARTITION BY City
            ORDER BY SUM(Price) DESC
        ) AS rn
    FROM swiggy_database
    GROUP BY City, Restaurant_Name
)

SELECT
    City,
    Restaurant_Name,
    Total_Revenue
FROM revenue_cte
WHERE rn = 1;
```

---

# 📌 Key Business Insights

- Identified the highest revenue-generating restaurants.
- Compared monthly revenue across different cities.
- Determined the highest-rated restaurants in each city.
- Analyzed the best-performing food categories.
- Calculated revenue contribution of popular dishes.
- Explored customer rating trends across restaurants.

---

# 📂 Repository Structure

```
swiggy-sales-sql-analysis/
│
├── Dataset/
│   └── swiggy_dataset.csv
│
├── SQL/
│   ├── 01_database_creation.sql
│   ├── 02_data_cleaning.sql
│   └── 03_business_analysis.sql
│
├── Images/
│   └── SQL_Query_Results.png
│
├── README.md
│
└── PowerBI/
    └── (Coming Soon)
```

---

# 🔄 Project Workflow

```
Dataset
    │
    ▼
Data Cleaning
    │
    ▼
SQL Data Analysis
    │
    ▼
Business Insights
    │
    ▼
Power BI Dashboard (Coming Soon)
```

---

# 💻 Tools & Technologies

- MySQL
- SQL
- Excel
- Git
- GitHub

---

# 📸 Project Screenshots

### SQL Analysis

*(Screenshots will be added here.)*

### Power BI Dashboard

*(Coming Soon)*

---

# 🚀 Future Improvements

- Interactive Power BI Dashboard
- KPI Cards
- DAX Measures
- Dynamic Filters & Slicers
- Business Dashboard
- Advanced Data Visualization

---

# 🎯 Learning Outcomes

Through this project, I strengthened my understanding of:

- SQL Data Cleaning
- Data Validation
- Business-Oriented SQL Queries
- Window Functions
- Ranking Functions
- Aggregate Analysis
- Writing Efficient SQL Queries
- Business Insight Generation

---

# 📈 Project Status

✅ SQL Data Cleaning Completed

✅ SQL Business Analysis Completed

🔄 Power BI Dashboard (In Progress)

---

# 👨‍💻 Author

**Rohit Roy**

B.Tech (Computer Science & Engineering)

Aspiring Data Analyst

### Connect with me

- GitHub: https://github.com/RohitRoy404
- LinkedIn: *(Add your LinkedIn profile link here)*

---

## ⭐ If you found this project useful, consider giving it a Star!
