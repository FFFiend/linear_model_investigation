#### Preamble ####
# Purpose: Generating the model for the data, and saving into an RDS file.
# Author: Owais Zahid
# Date: 9th March 2024
# Contact: owais.zahid@mail.utoronto.ca
# License: MIT
# Pre-requisites: please run files numbered 01,02, and 03 prior to this.

# load in libraries.
library(tidyverse)
library(dplyr)
library(rstanarm)
library(modelsummary)

# read and convert values in each column to integer.
ces2020 <-
  read_csv(
    "~/linear_model_investigation/data/ces2020.parquet",
    col_types =
      cols(
        "votereg" = col_integer(),
        "CC20_410" = col_integer(),
        "gender" = col_integer(),
        "educ" = col_integer(),
        "race" = col_integer(),
        "age" = col_integer()
      )
  )

# formatting data, mapping race ids to races.
ces2020 <-
  ces2020 |>
  filter(votereg == 1,
         CC20_410 %in% c(1, 2)) |>
  mutate(
    voted_for = if_else(CC20_410 == 1, "Biden", "Trump"),
    voted_for = as_factor(voted_for),
    gender = if_else(gender == 1, "Male", "Female"),
    education = case_when(
      educ == 1 ~ "No HS",
      educ == 2 ~ "High school graduate",
      educ == 3 ~ "Some college",
      educ == 4 ~ "2-year",
      educ == 5 ~ "4-year",
      educ == 6 ~ "Post-grad"
    ),
    education = factor(
      education,
      levels = c(
        "No HS",
        "High school graduate",
        "Some college",
        "2-year",
        "4-year",
        "Post-grad"
      )
    ),
    race = case_when(
      race == 1 ~ "White",
      race == 2 ~ "Black",
      race == 3 ~ "Hispanic",
      race == 4 ~ "Asian",
      race == 5 ~ "Native American",
      race == 6 ~ "Middle Eastern",
      race == 7 ~ "Two or more races",
      race == 8 ~ "Other"
    ),
    race = factor(
      race,
      levels = c(
        "White",
        "Black",
        "Hispanic",
        "Asian",
        "Native American",
        "Middle Eastern",
        "Two or more races",
        "Other"
      )
    )
  ) |> select(voted_for, gender, education, race, age)

# preview data after mutation.
ces2020

# cheeky prime number
set.seed(71)

# using a sample size of n=8000
ces2020_reduced <- 
  ces2020 |> 
  slice_sample(n = 8000)

# using rstanarm to generate the model using gender
# education, race and age as explanatory variables.
political_preferences <-
  stan_glm(
    voted_for ~ gender + education + race + age,
    data = ces2020_reduced,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = 
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
)

# saving RDS
saveRDS(
  political_preferences,
  file = "~/linear_model_investigation/data/political_preferences.rds"
)

# reading from the RDS
political_preferences <-
  readRDS(file = "~/linear_model_investigation/data/political_preferences.rds")
political_preferences 

# model summary
modelsummary(
  list(
    "Support Biden" = political_preferences
  ),
  statistic = "mad"
)

