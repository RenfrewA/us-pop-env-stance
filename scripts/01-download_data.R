#### Preamble ####
# Purpose: Downloads and saves data from CES 2020 (Cooperative Election Study Common Content, 2020)
# Author: Renfrew Ao-Ieong
# Date: 11 April 2024
# Contact: renfrew.aoieong@mail.utoronto.ca
# License: MIT
# Pre-requisites: tidyverse, dataverse, arrow


#### Workspace setup ####
library(arrow)
library(dataverse)
library(tidyverse)

#### Download data ####
ces2020_env <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  ) |>
  select(CC20_333b, ideo5, faminc_new, educ, urbancity)


#### Save data ####
write_parquet(ces2020_env, "data/raw_data/raw_ces2020_env.parquet")
