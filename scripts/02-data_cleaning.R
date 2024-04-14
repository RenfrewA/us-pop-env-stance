#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Renfrew Ao-Ieong
# Date: 11 April 2024
# Contact: renfrew.aoieong@mail.utoronto.ca
# License: MIT
# Pre-requisites: tidyverse, arrow

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Clean data ####
# CC20_333b: - Require that each state use a minimum amount of renewable fuels (wind, solar, and hydroelectric) in the generation of electricity even if electricity prices increase a little
# 1 - Support, 2 - Oppose

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
  filter(ideo5 != 6, faminc_new != 17, urbancity != 5) # Filter out ideo5 6: Not sure, faminc_new: 17 prefer not to say, urbancity: 5 other

#### Save data ####
write_csv(cleaned_ces2020_env, "data/analysis_data/cleaned_ces2020_env.parquet")
