# Sales Data Analysis - Beginner Level

## Project Overview

This is a beginner-friendly R project that analyzes the Superstore sales dataset to understand sales patterns, customer behavior, and provides simple revenue forecasting.

## Dataset

The project uses the **Sample - Superstore.csv** dataset containing:
- Order information (Order ID, Order Date, Ship Date, Ship Mode)
- Customer details (Customer ID, Customer Name, Segment)
- Geographic data (Country, City, State, Region, Postal Code)
- Product information (Product ID, Category, Sub-Category, Product Name)
- Sales metrics (Sales, Quantity, Discount, Profit)

## Project Structure

```
r project/
├── README.md                          # Project overview and setup
├── sales_analysis.R                  # Main analysis script
└── Sample - Superstore.csv           # Dataset
```

## Required R Packages

Install the following packages in R (run once):

```r
install.packages("ggplot2")
install.packages("dplyr")
install.packages("lubridate")
```

## How to Run

Simply run the analysis script in R or RStudio:

```r
source("sales_analysis.R")
```

Or open the file in RStudio and run all the code.

## Analysis Included

The script performs the following analyses:

1. **Basic Statistics** - Total sales, profit, average order value
2. **Sales by Category** - Bar chart showing sales across product categories
3. **Sales by Region** - Bar chart showing sales across regions
4. **Sales by Customer Segment** - Bar chart showing sales by segment type
5. **Monthly Sales Trend** - Line chart showing sales over time
6. **Top 10 Products** - Bar chart of best-selling products
7. **Top 10 Customers** - Bar chart of highest-value customers
8. **Profit by Category** - Bar chart showing profit across categories
9. **Simple Revenue Forecast** - Basic 6-month forecast using average sales

## Output

After running the script, you will get:
- Console output with all analysis results
- 8 PNG chart files saved in the project folder
- Simple revenue forecast for the next 6 months

## Key Insights

The analysis provides insights on:
- Best-selling product categories
- Regional performance
- Customer segment preferences
- Monthly sales trends
- Top products and customers
- Profitability by category
- Simple revenue forecast

## Author

Generated for Sales Data Analysis and Revenue Forecasting project.
