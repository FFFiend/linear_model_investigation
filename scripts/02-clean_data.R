#### Preamble ####
# Purpose: cleaning the data and converting birthyr column to age
# Author: Owais Zahid
# Date: 9th March 2024
# Contact: owais.zahid@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

# here we are converting the birth year column to age
library(dplyr)
library(tidyverse)

raw_data = read.csv("~/linear_model_investigation/data/ces2020.parquet")
raw_data

raw_data$birthyr <- as.numeric(raw_data$birthyr)
current_year <- as.numeric(year(as.Date(Sys.time())))

# Subtract current year from birth year column to get age
raw_data <- raw_data %>% mutate(birthyr = current_year - birthyr)
# rename to age
names(raw_data)[names(raw_data) == "birthyr"] <- "age"
head(raw_data)

# save data back into the csv.
write.csv(raw_data,"~/linear_model_investigation/data/ces2020.parquet")

