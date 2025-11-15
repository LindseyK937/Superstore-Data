
#load the necessary libraries
library(rio)
library(tidyverse)
library(dplyr)
library(psych)

# load the dataset
superstore_data <- read.csv("C:/Users/LINDSEY KHALUMBA/OneDrive/Desktop/superstore_data.csv", comment.char="#")
View(superstore_data)

# Checking for missing values
is.na(superstore_data)
sum(is.na(superstore_data$Profit))

#Checking the structure of the dataset
str(superstore_data)

# Convert date columns to proper format
superstore_dates<- superstore_data %>%
  mutate(
    order_date = as.Date(order_date, format = "%d/%m/%Y"),
    ship_date = as.Date(ship_date, format = "%d/%m/%Y"),
    order_year = year(order_date),
    order_month = month(order_date)
  )
# How much profit is gained from each product
product_profit <- superstore_dates %>%
  group_by(product_name, category, sub_category) %>%
  summarise(
    total_profit = sum(profit),
    total_sales = sum(sales),
    total_quantity = sum(quantity),
    avg_profit_margin = mean(profit/sales * 100, na.rm = TRUE),
    .groups = 'drop'
  ) %>%
  arrange(desc(total_profit))

top_10_profitable_products <- product_profit %>% head(10)
bottom_10_profitable_products <- product_profit %>% arrange(total_profit) %>% head(10)
# Viewing profits
top_10_profitable_products
bottom_10_profitable_products

#People from which city?State Shop the most
#State
state_shoppers <- superstore_data %>%
  group_by(state) %>%
  summarise(
    total_sales = sum(sales),
    total_orders = n_distinct(order_id),
    total_customers = n_distinct(customer_id),
    avg_order_value = mean(sales)
  ) %>%
  arrange(desc(total_sales))
state_shoppers
#City
city_analysis <- superstore_data %>%
  group_by(city, state) %>%
  summarise(
    total_sales = sum(sales),
    total_orders = n_distinct(order_id),
    total_customers = n_distinct(customer_id)
  ) %>%
  arrange(desc(total_sales))
city_analysis

#Which customer is regular/loyal over the years?
customer_loyalty <- superstore_dates %>%
  group_by(customer_id, customer_name) %>%
  summarise(
    first_order_year = min(year(order_date)),
    last_order_year = max(year(order_date)),
    total_years_active = n_distinct(year(order_date)),
    total_orders = n_distinct(order_id),
    total_spent = sum(sales),
    avg_order_value = mean(sales),
    days_since_last_order = as.numeric(Sys.Date() - max(order_date)),
    .groups = 'drop'
  ) %>%
  mutate(
    order_frequency = ifelse(total_years_active > 0, total_orders / total_years_active, 0)
  ) %>%
  arrange(desc(total_orders))
# Check for issues
sum(is.na(customer_loyalty))
head(customer_loyalty, 15)
#Products having high discount rate?
discount_analysis <-superstore_data %>% 
  group_by(product_name, category, sub_category) %>%
  summarise(
    avg_discount = mean(discount * 100),
    max_discount = max(discount * 100),
    total_units_sold = sum(quantity),
    discount_frequency = sum(discount > 0) / n(),
    .groups = 'drop'
  ) %>%
  arrange(desc(avg_discount))

high_discount_products <- discount_analysis %>% 
  filter(avg_discount > 0) %>%
  arrange(desc(avg_discount)) %>%
  head(15)
high_discount_products
