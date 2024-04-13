#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)

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


#### Save data ####
write_csv(cleaned_ces2020_env, "outputs/data/cleaned_ces2020_env.parquet")
