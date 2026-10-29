# ============================================
# Sales Data Analysis - Beginner Level
# ============================================
# This script analyzes the Superstore sales data
# and creates simple visualizations

# Install required packages (run once)
install.packages("ggplot2")
install.packages("dplyr")
install.packages("lubridate")

# Load libraries
library(ggplot2)
library(dplyr)
library(lubridate)

# ============================================
# Step 1: Load the Data
# ============================================

cat("Loading data...\n")
sales_data <- read.csv("Sample - Superstore.csv")

# Convert date columns
sales_data$Order.Date <- mdy(sales_data$Order.Date)
sales_data$Ship.Date <- mdy(sales_data$Ship.Date)

# Show basic info
cat("Total rows:", nrow(sales_data), "\n")
cat("Total columns:", ncol(sales_data), "\n")
cat("Date range:", min(sales_data$Order.Date), "to", max(sales_data$Order.Date), "\n\n")

# ============================================
# Step 2: Basic Statistics
# ============================================

cat("=== BASIC STATISTICS ===\n")
cat("Total Sales:", sum(sales_data$Sales), "\n")
cat("Total Profit:", sum(sales_data$Profit), "\n")
cat("Average Sales per Order:", mean(sales_data$Sales), "\n")
cat("Number of Customers:", length(unique(sales_data$Customer.ID)), "\n\n")

# ============================================
# Step 3: Sales by Category
# ============================================

cat("=== SALES BY CATEGORY ===\n")

# Calculate sales by category
category_sales <- sales_data %>%
  group_by(Category) %>%
  summarise(Total_Sales = sum(Sales),
            Total_Profit = sum(Profit)) %>%
  arrange(desc(Total_Sales))

print(category_sales)

# Create bar chart for sales by category
p1 <- ggplot(category_sales, aes(x = Category, y = Total_Sales, fill = Category)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Sales by Category",
       x = "Category",
       y = "Total Sales ($)") +
  theme_minimal()

ggsave("sales_by_category.png", p1, width = 8, height = 6)
cat("Saved: sales_by_category.png\n\n")

# ============================================
# Step 4: Sales by Region
# ============================================

cat("=== SALES BY REGION ===\n")

# Calculate sales by region
region_sales <- sales_data %>%
  group_by(Region) %>%
  summarise(Total_Sales = sum(Sales),
            Total_Profit = sum(Profit)) %>%
  arrange(desc(Total_Sales))

print(region_sales)

# Create bar chart for sales by region
p2 <- ggplot(region_sales, aes(x = Region, y = Total_Sales, fill = Region)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Sales by Region",
       x = "Region",
       y = "Total Sales ($)") +
  theme_minimal()

ggsave("sales_by_region.png", p2, width = 8, height = 6)
cat("Saved: sales_by_region.png\n\n")

# ============================================
# Step 5: Sales by Customer Segment
# ============================================

cat("=== SALES BY CUSTOMER SEGMENT ===\n")

# Calculate sales by segment
segment_sales <- sales_data %>%
  group_by(Segment) %>%
  summarise(Total_Sales = sum(Sales),
            Total_Profit = sum(Profit),
            Num_Customers = n_distinct(Customer.ID)) %>%
  arrange(desc(Total_Sales))

print(segment_sales)

# Create bar chart for sales by segment
p3 <- ggplot(segment_sales, aes(x = Segment, y = Total_Sales, fill = Segment)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Sales by Customer Segment",
       x = "Segment",
       y = "Total Sales ($)") +
  theme_minimal()

ggsave("sales_by_segment.png", p3, width = 8, height = 6)
cat("Saved: sales_by_segment.png\n\n")

# ============================================
# Step 6: Monthly Sales Trend
# ============================================

cat("=== MONTHLY SALES TREND ===\n")

# Calculate monthly sales
monthly_sales <- sales_data %>%
  mutate(Year_Month = format(Order.Date, "%Y-%m")) %>%
  group_by(Year_Month) %>%
  summarise(Total_Sales = sum(Sales),
            Total_Profit = sum(Profit)) %>%
  arrange(Year_Month)

print(head(monthly_sales, 10))

# Create line chart for monthly sales
p4 <- ggplot(monthly_sales, aes(x = Year_Month, y = Total_Sales, group = 1)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "blue", size = 2) +
  labs(title = "Monthly Sales Trend",
       x = "Year-Month",
       y = "Total Sales ($)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("monthly_sales_trend.png", p4, width = 12, height = 6)
cat("Saved: monthly_sales_trend.png\n\n")

# ============================================
# Step 7: Top 10 Products
# ============================================

cat("=== TOP 10 PRODUCTS ===\n")

# Find top 10 products by sales
top_products <- sales_data %>%
  group_by(Product.Name) %>%
  summarise(Total_Sales = sum(Sales),
            Total_Quantity = sum(Quantity)) %>%
  arrange(desc(Total_Sales)) %>%
  head(10)

print(top_products)

# Create bar chart for top 10 products
p5 <- ggplot(top_products, aes(x = reorder(Product.Name, -Total_Sales), y = Total_Sales)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Top 10 Products by Sales",
       x = "Product Name",
       y = "Total Sales ($)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

ggsave("top_10_products.png", p5, width = 12, height = 6)
cat("Saved: top_10_products.png\n\n")

# ============================================
# Step 8: Top 10 Customers
# ============================================

cat("=== TOP 10 CUSTOMERS ===\n")

# Find top 10 customers by sales
top_customers <- sales_data %>%
  group_by(Customer.Name) %>%
  summarise(Total_Sales = sum(Sales),
            Total_Orders = n()) %>%
  arrange(desc(Total_Sales)) %>%
  head(10)

print(top_customers)

# Create bar chart for top 10 customers
p6 <- ggplot(top_customers, aes(x = reorder(Customer.Name, -Total_Sales), y = Total_Sales)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  labs(title = "Top 10 Customers by Sales",
       x = "Customer Name",
       y = "Total Sales ($)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

ggsave("top_10_customers.png", p6, width = 12, height = 6)
cat("Saved: top_10_customers.png\n\n")

# ============================================
# Step 9: Profit by Category
# ============================================

cat("=== PROFIT BY CATEGORY ===\n")

# Calculate profit by category
category_profit <- sales_data %>%
  group_by(Category) %>%
  summarise(Total_Profit = sum(Profit),
            Profit_Margin = (Total_Profit / sum(Sales)) * 100) %>%
  arrange(desc(Total_Profit))

print(category_profit)

# Create bar chart for profit by category
p7 <- ggplot(category_profit, aes(x = Category, y = Total_Profit, fill = Category)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Profit by Category",
       x = "Category",
       y = "Total Profit ($)") +
  theme_minimal()

ggsave("profit_by_category.png", p7, width = 8, height = 6)
cat("Saved: profit_by_category.png\n\n")

# ============================================
# Step 10: Simple Revenue Forecast
# ============================================

cat("=== SIMPLE REVENUE FORECAST ===\n")

# Calculate average monthly sales
avg_monthly_sales <- mean(monthly_sales$Total_Sales)
cat("Average Monthly Sales:", avg_monthly_sales, "\n")

# Simple forecast for next 6 months (using average)
forecast_months <- 6
forecasted_sales <- rep(avg_monthly_sales, forecast_months)

# Create forecast data frame
last_date <- max(sales_data$Order.Date)
forecast_dates <- seq(from = last_date + months(1),
                      by = "month",
                      length.out = forecast_months)

forecast_df <- data.frame(
  Date = forecast_dates,
  Forecasted_Sales = forecasted_sales
)

print(forecast_df)

# Combine historical and forecast for visualization
historical_plot <- data.frame(
  Date = as.Date(paste(monthly_sales$Year_Month, "-01", sep = "")),
  Sales = monthly_sales$Total_Sales,
  Type = "Historical"
)

forecast_plot <- data.frame(
  Date = forecast_dates,
  Sales = forecasted_sales,
  Type = "Forecast"
)

combined_data <- rbind(historical_plot, forecast_plot)

# Create forecast chart
p8 <- ggplot(combined_data, aes(x = Date, y = Sales, color = Type)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(title = "Historical Sales and Simple Forecast",
       subtitle = "Forecast based on average monthly sales",
       x = "Date",
       y = "Sales ($)",
       color = "Type") +
  theme_minimal() +
  scale_color_manual(values = c("Historical" = "blue", "Forecast" = "red"))

ggsave("sales_forecast.png", p8, width = 12, height = 6)
cat("Saved: sales_forecast.png\n\n")

# ============================================
# Summary
# ============================================

cat("=== ANALYSIS COMPLETE ===\n")
cat("Generated 8 charts:\n")
cat("1. sales_by_category.png\n")
cat("2. sales_by_region.png\n")
cat("3. sales_by_segment.png\n")
cat("4. monthly_sales_trend.png\n")
cat("5. top_10_products.png\n")
cat("6. top_10_customers.png\n")
cat("7. profit_by_category.png\n")
cat("8. sales_forecast.png\n")
cat("\nAll analysis saved!\n")
