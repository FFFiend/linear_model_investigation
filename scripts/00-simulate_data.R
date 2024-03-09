#### Preamble ####
# Purpose: Simulating what the dataset may look like.
# Author: Owais Zahid
# Date: 9th March 2024
# Contact: owais.zahid@mail.utoronto.ca
# License: MIT
# Pre-requisites: None.


# setting seed, prime number :P
set.seed(71)

# sample size 8000
num_obs <- 8000

# simulating the actual data
# using 8 categories for races as in the dataset, and ages 0-100.
us_political_preferences <- tibble(
  education = sample(0:4, size = num_obs, replace = TRUE),
  gender = sample(0:1, size = num_obs, replace = TRUE),
  race = sample(1:8, size = num_obs, replace = TRUE),
  age = sample(0:100, size = num_obs, replace=TRUE),
  support_prob = ((education + gender + race + age) / 7),
) |>
  mutate(
    supports_biden = if_else(runif(n = num_obs) < support_prob, "yes", "no"),
    education = case_when(
      education == 0 ~ "< High school",
      education == 1 ~ "High school",
      education == 2 ~ "Some college",
      education == 3 ~ "College",
      education == 4 ~ "Post-grad"
    ),
    gender = if_else(gender == 0, "Male", "Female"),
    race = case_when(
      race == 1 ~ "White",
      race == 2 ~ "Black",
      race == 3 ~ "Hispanic",
      race == 4 ~ "Asian",
      race == 5 ~ "Native American",
      race == 6 ~ "Middle Eastern",
      race == 7 ~ "Two or more races",
      race == 8 ~ "Other"
    )
  ) |>
  select(-support_prob, supports_biden, gender, education, race, age)

# preview the simulated data
us_political_preferences
