#load observations
observations <- read.csv(
  "data/bootcamp_observations.csv",
  colClasses = "character", na.strings = "", check.names = FALSE
)
str(observations)
print(observations)

# 0 and NA must be treated differently, as 0 can reflect the absence of a species, while NA reflects a missing observation.

read_observations <- function(path) {
  observations <- read.csv(
    path,
    colClasses = "character", na.strings = "", check.names = FALSE
  )
  
  # Check column names
  expected_cols <- c("site", "date", "count")
  if (!identical(colnames(observations)[1:3], expected_cols)) {
    stop("Invalid column names")
  }
  
  # Check for missing values in site and date
  if (any(is.na(observations$site))) {
    stop("Missing site values")
  }
  if (any(is.na(observations$date))) {
    stop("Missing date values")
  }
  
  # Convert count to integer and check for valid counts
  observations$count <- as.integer(observations$count)
  invalid_counts <- !is.na(observations$count) & !grepl("^(0|[1-9][0-9]*)$", observations$count)
  
  if (any(invalid_counts)) {
    stop("Invalid count values found, check that all counts are non-negative integers or NA")
  }
  
  message("File read successfully")
  return(observations)
}

#calling the function on deliberately wrong csv. Uncomment line below to test the error handling
#read_observations("data/bootcamp_observations_invalid.csv")

#calling the function on correct csv
df <- read_observations("data/bootcamp_observations.csv")
df

##Task for the function summarise_observations(data)
# need to:
#      remove exact duplicate rows once
#      for each site, report total_known (sum of non-missing counts)
#      for each site, report missing_count (sum of missing counts)
#      if every count is missing for a site, report total_known as NA
#      results should be: A (2, 1), B (0, 0), C (NA, 2), and D (0, 0), where each pair is (total_known, missing_count)
#      add stopifnot() checks for each output value to ensure the function is working correctly

#PSEUDOCODE
## summarise_observations(data):
## Use dplyr to find duplicates
## group by site
## calculate total_known and missing_count for each site
## if every count is missing for a site, report total_known as NA

if (!require("dplyr")) install.packages("dplyr")
require(dplyr)
summarise_observations <- function(data) {
  data <- distinct(data)

  dplyr::summarise(
    dplyr::group_by(data, site),
    total_known = if (all(is.na(count))) NA_integer_ else sum(count, na.rm = TRUE),
    missing_count = sum(is.na(count)),
    .groups = "drop"
  )
}

# Suggested solution applied to the test CSV
summary_df <- summarise_observations(df)
print(summary_df)

#for boundary df
df_boundary <- read_observations("data/bootcamp_observations_boundary.csv")
summary_df_boundary <- summarise_observations(df_boundary)
print(summary_df_boundary)

# Checks for the test data
stopifnot(
  summary_df$total_known[summary_df$site == "A"] == 2,
  summary_df$missing_count[summary_df$site == "A"] == 1,
  summary_df$total_known[summary_df$site == "B"] == 0,
  summary_df$missing_count[summary_df$site == "B"] == 0,
  is.na(summary_df_boundary$total_known[summary_df_boundary$site == "C"]),
  summary_df_boundary$missing_count[summary_df_boundary$site == "C"] == 2,
  summary_df_boundary$total_known[summary_df_boundary$site == "D"] == 0,
  summary_df_boundary$missing_count[summary_df_boundary$site == "D"] == 0
)


