#### Preamble ####
# Purpose: Simulates a dataset of 1000 responses from people where their stance on environmental action depends
# on their eductation level, household income, political preference, and the population density of where they are living
# Author: Renfrew Ao-Ieong
# Date: 11 April 2024
# Contact: renfrew.aoieong@mail.utoronto.ca
# License: MIT
# Pre-requisites: tidyverse


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(123)

num_obs <- 1000

us_environmental_stance <- tibble(
  education = sample(0:4, size = num_obs, replace = TRUE), # Lower number less education
  household_income = sample(0:2, size = num_obs, replace = TRUE),
  living_area = sample(0:3, size = num_obs, replace = TRUE), # Lower number, urban, higher number rural
  political_pref = sample(0:4, size = num_obs, replace = TRUE), # Lower number more liberal
  support_prob = ((education + household_income + (3-living_area) + (4-political_pref)))/13
) |>
  mutate(
    support_env = if_else(runif(n = num_obs) < support_prob, "yes", "no"),
    education = case_when(
      education == 0 ~ "< High school",
      education == 1 ~ "High school",
      education == 2 ~ "Some college",
      education == 3 ~ "College",
      education == 4 ~ "Post-grad"
    ),
    household_income = case_when(
      household_income == 0 ~ "Low",
      household_income == 1 ~ "Medium",
      household_income == 2 ~ "High",
    ),
    living_area = case_when(
      living_area == 0 ~ "City",
      living_area == 1 ~ "Suburb",
      living_area == 2 ~ "Town",
      living_area == 3 ~ "Rural Area",
    ),
    political_pref = case_when(
      political_pref == 0 ~ "Very Liberal",
      political_pref == 1 ~ "Liberal",
      political_pref == 2 ~ "Moderate",
      political_pref == 3 ~ "Conservative",
      political_pref == 4 ~ "Very Conservative",
    ),
  ) |>
  select(-support_prob, support_env, education, household_income, living_area, political_pref)

#### Test simulated data ####
# Check number of observations
nrow(us_environmental_stance) == 1000

# Check correct type education
all(sapply(us_environmental_stance$education, is.character))

# Check Only 5 values in us_environmental_stance$education
length(unique(us_environmental_stance$education)) == 5

# Check correct type household_income
all(sapply(us_environmental_stance$household_income, is.character))

# Check Only 3 values in us_environmental_stance$household_income
length(unique(us_environmental_stance$household_income)) == 3

# Check correct type living_area
all(sapply(us_environmental_stance$living_area, is.character))

# Check Only 4 values in us_environmental_stance$living_area
length(unique(us_environmental_stance$living_area)) == 4

# Check correct type political_pref
all(sapply(us_environmental_stance$political_pref, is.character))

# Check Only 2 values in us_environmental_stance$political_pref
length(unique(us_environmental_stance$political_pref)) == 5

