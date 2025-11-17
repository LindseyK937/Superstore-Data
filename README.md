# Superstore-Data
Superstore Sales Data (2014-2018):
Analyzes product profitability, regional sales performance, customer loyalty patterns, and discount strategies. Can be used for inventory optimization, targeted marketing, customer retention, and promotional assessment.
## 📊 Project Overview
Comprehensive business intelligence analysis of Superstore retail data to uncover sales patterns, customer behavior, and profitability insights. This analysis transforms raw transaction data into actionable business strategies for inventory management, customer retention, and revenue optimization.

## 🎯 Key Business Questions Answered
- **Profitability Analysis**: Which products generate the most/least profit?
- **Customer Loyalty**: Who are our most valuable repeat customers?
- **Geographic Performance**: Which states and cities drive the highest sales?
- **Pricing Strategy**: How do discounts impact product performance?
- **Customer Segmentation**: Identifying loyal vs at-risk customer groups

## 📈 Analytical Features

### Profitability Analytics
- Product-level profit margin analysis
- Top 10 most/least profitable products
- Sales-to-profit ratio calculations
- Category and sub-category performance breakdown

### Customer Analytics
- Customer lifetime value calculation
- Loyalty scoring based on order frequency and spending
- Customer retention patterns across years
- Order frequency and average order value analysis

### Geographic Analysis
- State-level sales performance rankings
- City-level customer concentration
- Regional sales distribution patterns
- Market penetration analysis

### Pricing & Discount Strategy
- Discount impact analysis on product performance
- High-discount product identification
- Discount frequency and magnitude analysis
- Pricing optimization opportunities

## 🛠️ Technical Implementation

### Data Processing
```r
# Date conversion and feature engineering
order_date = as.Date(order_date, format = "%d/%m/%Y")
ship_date = as.Date(ship_date, format = "%d/%m/%Y")
order_year = year(order_date)
order_month = month(order_date)
