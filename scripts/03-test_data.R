#### Preamble ####
# Purpose: Testing cleaned dataset.
# Author: Owais Zahid
# Date: 9th March 2024
# Contact: owais.zahid@mail.utoronto.ca
# License: MIT
# Pre-requisites: please run files numbered 01, 02 prior.


data = read.csv("~/linear_model_investigation/data/ces2020.parquet")
data

# Test 1, checking to make sure only 8 race categories exist as indicated
# in the dataset FAQ
min(data$race) == 1 && max(data$race) == 8

# Test 2, checking to ensure there are no negative ages
min(data$age) > 0

# Test 3, checking to ensure data conforms to gender constraints imposed by 
# the survey
min(data$gender) == 1 && max(data$gender) == 2

# Test 4, check for NA values inside the race column
sum(is.na(data$race)) == 0 

# Test 5, check for NA values inside the age column
sum(is.na(data$age)) == 0

# Test 6, check for NA values inside the educ column
sum(is.na(data$educ)) == 0

# Test 7, check for NA values inside the gender column
sum(is.na(data$gender)) == 0
