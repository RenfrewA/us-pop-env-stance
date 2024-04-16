#### Preamble ####
# Purpose: Cleans the raw CES2020 survey data and removing non-responses
# Author: Renfrew Ao-Ieong
# Date: 11 April 2024
# Contact: renfrew.aoieong@mail.utoronto.ca
# License: MIT
# Pre-requisites: tidyverse, arrow, raw_ces2020_env.parquet

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Clean data ####
# CC20_333b: - Require that each state use a minimum amount of renewable fuels (wind, solar, and hydroelectric) in the generation of electricity even if electricity prices increase a little
# 1 - Support, 2 - Oppose

# EXCLUDED
# ideo5: In general, how would you describe your own political viewpoint?
# 1 - Very Liberal, 2 - Liberal, 3 - Moderate, 4 - Conservative, 5 - Very Conservative, 6 - Not sure

# faminc_new: Thinking back over the last year, what was your family's annual income?
# 17 categories

# educ: What is the highest level of education you have completed?
# 1 - No HS, 2 - High School Graduate, 3 - Some college, 4 - 2-year, 5 - 4-year, 6 - Post-grad

# urbancity: How would you describe the place where you live?
# 1 - City, 2 - Suburb, 3 - Town, 4 - Rural area, 5 - Other

cleaned_ces2020_env <-
  read_parquet(
    "data/raw_data/raw_ces2020_env.parquet",
    col_types =
      cols(
        "CC20_333b" = col_integer(),
        "ideo5" = col_integer(),
        "faminc_new" = col_integer(),
        "educ" = col_integer(),
        "urbancity" = col_integer(),
      )
  )


cleaned_ces2020_env <-
  cleaned_ces2020_env |>
  filter(!is.na(CC20_333b), ideo5 != 6, faminc_new != 97, urbancity !=5, !is.na(urbancity)) |> # Filter out people who didn't answer the env question, ideo5 6: Not sure, faminc_new: 97 prefer not to say, urbancity: 5 other
  mutate(
    env_stance = if_else(CC20_333b == 1, "Support", "Oppose"),
    env_stance = as_factor(env_stance),
    political_pref = case_when(
      ideo5 == 1 ~ "Very Liberal",
      ideo5 == 2 ~ "Liberal",
      ideo5 == 3 ~ "Moderate",
      ideo5 == 4 ~ "Conservative",
      ideo5 == 5 ~ "Very Conservative",
    ),
    political_pref = as_factor(political_pref),
    household_income = factor(faminc_new,
                              levels = c(
                                "Very Liberal",
                                "Liberal",
                                "Moderate",
                                "Conservative",
                                "Very Conservative"
                              )),
    household_income = case_when(
      faminc_new == 1 ~ "Less than $10,000",
      faminc_new == 2 ~ "$10,000 - $19,999",
      faminc_new == 3 ~ "$20,000 - $29,999",
      faminc_new == 4 ~ "$30,000 - $39,999",
      faminc_new == 5 ~ "$40,000 - $49,999",
      faminc_new == 6 ~ "$50,000 - $59,999",
      faminc_new == 7 ~ "$60,000 - $69,999",
      faminc_new == 8 ~ "$70,000 - $79,999",
      faminc_new == 9 ~ "$80,000 - $99,999",
      faminc_new == 10 ~ "$100,000 - $119,999",
      faminc_new == 11 ~ "$120,000 - $149,999",
      faminc_new == 12 ~ "$150,000 - $199,999",
      faminc_new == 13 ~ "$200,000 - $249,999",
      faminc_new == 14 ~ "$250,000 - $349,999",
      faminc_new == 15 ~ "$350,000 - $499,999",
      faminc_new == 16 ~ "$500,000 or more"
    ),
    household_income = factor(household_income,
                              levels = c(
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
                              )),
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
    living_area = case_when(
      urbancity == 1 ~ "City",
      urbancity == 2 ~ "Suburb",
      urbancity == 3 ~ "Town",
      urbancity == 4 ~ "Rural"
    ),
    living_area = factor(
      living_area,
      levels = c(
        "City",
        "Suburb",
        "Town",
        "Rural"
      )
    )
  ) |>
  # Decided to exclude political stance
  select(env_stance, household_income, education, living_area)

cleaned_ces2020_env
#### Save data ####
write_parquet(cleaned_ces2020_env, "data/analysis_data/cleaned_ces2020_env.parquet")
