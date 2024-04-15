#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Renfrew Ao-Ieong
# Date: 15 April 2023
# Contact: renfrew.aoieong@mail.utoronto.ca
# License: MIT
# Pre-requisites: tidyverse, rstanarm, arrow


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

set.seed(123)

#### Read data ####
cleaned_ces2020_env <- read_parquet("data/analysis_data/cleaned_ces2020_env.parquet")

### Model data ####

# Sample 3000 observations from the cleaned dataset
ces2020_env_reduced <- 
  cleaned_ces2020_env |>
  slice_sample(n=3000)

env_support <-
  stan_glm(
    env_stance ~  household_income + education + living_area,
    data = ces2020_env_reduced,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 123
  )

#### Save model ####
saveRDS(
  env_support,
  file = "models/env_support.rds"
)


