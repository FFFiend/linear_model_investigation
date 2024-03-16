#### Preamble ####
# Purpose: downloading the data
# Author: Owais Zahid
# Date: 9th March 2024
# Contact: owais.zahid@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


# loading dataverse and tidyverse libraries for loading in the dataset
# and filtering for the chosen explanatory variables and the response variable.
library(dataverse)
library(tidyverse)

ces2020 <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  ) |>
  select(votereg, CC20_410, gender, educ, race, birthyr)

write_csv(ces2020, "data/ces2020_raw.parquet")

