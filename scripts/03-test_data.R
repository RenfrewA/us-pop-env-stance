#### Preamble ####
# Purpose: Test values in the cleaned_ces2020_env.parquet file
# Author: Renfrew Ao-Ieong
# Date: 15 April 2024
# Contact: renfrew.aoieong@mail.utoronto.ca
# License: MIT
# Pre-requisites: Obtain cleaned_ces2020_env.parquet by running 02-data_cleaning.R

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Test data ####
cleaned_ces2020_env <- read_parquet("data/analysis_data/cleaned_ces2020_env.parquet")

# Verify that the file contains 50,788 rows
nrow(cleaned_ces2020_env) == 50788

# Check column names
c_names = colnames(cleaned_ces2020_env)
"env_stance" %in% c_names
"political_pref" %in% c_names
"household_income" %in% c_names
"education" %in% c_names
"living_area" %in% c_names
length(c_names) == 5

# Check columns have all the required values and only those values

# Check env_stance is a factor and includes For and Against only
all(sapply(cleaned_ces2020_env$env_stance, is.factor))
length(levels(cleaned_ces2020_env$env_stance)) == 2
"Support" %in% levels(cleaned_ces2020_env$env_stance) && "Oppose" %in% levels(cleaned_ces2020_env$env_stance)

# Check political_pref is a factor and includes the 4 required values
all(sapply(cleaned_ces2020_env$political_pref, is.factor))
length(levels(cleaned_ces2020_env$political_pref)) == 5
all(c(
  "Very Liberal",
  "Liberal",
  "Moderate",
  "Conservative",
  "Very Conservative"
) %in% levels(cleaned_ces2020_env$political_pref))

# Check household_income is a factor and includes the required values
all(sapply(cleaned_ces2020_env$household_income, is.factor))
length(levels(cleaned_ces2020_env$household_income)) == 16
all(c(
  "Less than $10,000",
  "$10,000 - $19,999",
  "$20,000 - $29,999",
  "$30,000 - $39,999",
  "$40,000 - $49,999",
  "$50,000 - $59,999",
  "$60,000 - $69,999",
  "$70,000 - $79,999",
  "$80,000 - $99,999",
  "$100,000 - $119,999",
  "$120,000 - $149,999",
  "$150,000 - $199,999",
  "$200,000 - $249,999",
  "$250,000 - $349,999",
  "$350,000 - $499,999",
  "$500,000 or more"
) %in% levels(cleaned_ces2020_env$household_income))

# Check education is a factor and includes the required values
all(sapply(cleaned_ces2020_env$education, is.factor))
length(levels(cleaned_ces2020_env$education)) == 6
all(c(
  "No HS",
  "High school graduate",
  "Some college",
  "2-year",
  "4-year",
  "Post-grad"
) %in% levels(cleaned_ces2020_env$education))

# Check living_area is a factor and includes the required values
all(sapply(cleaned_ces2020_env$living_area, is.factor))
length(levels(cleaned_ces2020_env$living_area)) == 4
all(c(
  "City",
  "Suburb",
  "Town",
  "Rural"
) %in% levels(cleaned_ces2020_env$living_area))



