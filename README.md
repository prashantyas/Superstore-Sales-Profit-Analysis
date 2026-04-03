# 📊 Superstore Sales & Profit Analysis Dashboard

## 🚀 Project Overview
This project analyzes retail sales data from the Superstore dataset to identify key drivers of revenue and profitability. The analysis focuses on uncovering loss-making areas, understanding the impact of discounts, and providing actionable business recommendations.

The complete workflow followed in this project:
**Excel → SQL → Power BI**

- Data sourced from Excel dataset  
- Cleaned and analyzed using SQL  
- Visualized using Power BI dashboard  

---

## ❓ Business Problem
The business is generating strong revenue but facing inconsistent profitability across products and regions.  
Certain categories are producing losses despite high sales, indicating issues in pricing, discount strategy, or cost management.

The goal is to:
- Identify loss-making products and categories  
- Analyze the impact of discounts on profit  
- Evaluate regional performance  
- Provide actionable recommendations to improve profitability  

---

## 🎯 Objectives
- Analyze revenue and profit trends over time  
- Identify top-performing and loss-making sub-categories  
- Understand how discounts affect profitability  
- Compare regional contribution to profit  
- Build a business-ready dashboard  

---

## 🧱 Project Workflow

### 1️⃣ Data Source (Excel)
- Dataset: Sample Superstore  
- Format: CSV  
- Contains:
  - Orders, Customers, Products  
  - Sales, Profit, Discount, Quantity  
  - Region, Category, Sub-Category  

---

### 2️⃣ Data Analysis using SQL
Data was imported into MySQL and analyzed using structured queries.

#### 🔍 Key SQL Analysis:
- Total Revenue & Profit  
- Monthly Revenue Trends  
- Category-wise Performance  
- Loss-making Sub-Categories  
- Discount vs Profit Analysis  

📁 SQL file: /sql/analysis.sql

---

### 3️⃣ Data Visualization using Power BI
An interactive dashboard was built to present insights visually.

#### 📊 Dashboard Features:
- KPI Cards (Revenue, Profit, Profit Margin)  
- Revenue & Profit Trend  
- Profit Analysis by Sub-Category  
- Profit by Region  
- Business Insight Highlight  

📁 Dashboard file: /dashboard/dashboard.pbix

---

## 🔍 Key Insights
- 📈 Revenue shows a consistent upward trend from 2014 to 2017  
- ⚠️ High discounts are strongly associated with negative profit  
- ❌ Tables and Bookcases are major loss-making sub-categories  
- 💰 Copiers and Phones generate the highest profit  
- 🌍 West region contributes the highest overall profit  

---

## 📈 Business Recommendations
- Limit discounts beyond 40% to prevent margin loss  
- Re-evaluate pricing strategy for loss-making categories like Tables and Bookcases  
- Focus on high-profit products such as Copiers and Phones  
- Optimize discount strategy instead of aggressive price cuts  
- Invest more in high-performing regions like the West  

---

## 🛠 Tools & Technologies
- Excel → Data source  
- MySQL → Data analysis  
- Power BI → Visualization  

---

## 📁 Project Structure
Superstore-Sales-Profit-Dashboard/
│
├── data/
│   └── superstore.csv
│
├── sql/
│   └── analysis.sql
│
├── dashboard/
│   └── dashboard.pbix
│
├── images/
│   └── dashboard.png
│
└── README.md

---

## 📸 Dashboard Preview
![Dashboard Preview](Superstore%20Sales%20%26%20Profit%20Analysis/Images/dashboard.png)

---

## 🚀 How to Use
1. Clone the repository:
git clone https://github.com/your-username/superstore-sales-profit-dashboard.git

2. Open:
- `.pbix` file in Power BI Desktop  
- `.sql` file in MySQL  

---

## 💡 Business Impact
This analysis helps businesses:
- Reduce losses caused by excessive discounting  
- Improve pricing strategies  
- Focus on profitable products and regions  
- Make data-driven decisions  

---

## 📬 Contact
Feel free to connect for feedback or collaboration.
