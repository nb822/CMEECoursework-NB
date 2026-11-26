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

#calling the function on deliberately wrong csv
read_observations("data/bootcamp_observations_invalid.csv")

#calling the function on correct csv
df <- read_observations("data/bootcamp_observations.csv")
df