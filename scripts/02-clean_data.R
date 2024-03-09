# here we are converting the birth year column to age
library(dplyr)
library(tidyverse)

raw_data = read.csv("~/linear_model_investigation/data/ces2020.csv")
raw_data

raw_data$birthyr <- as.numeric(df$birthyr)
current_year <- as.numeric(year(as.Date(Sys.time())))

# Define the subtract_years function

# Subtract current year from birth year column to get age
raw_data <- raw_data %>% mutate(birthyr = current_year - birthyr)
head(raw_data)

