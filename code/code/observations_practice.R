#load observations
observations <- read.csv(
  "data/bootcamp_observations.csv",
  colClasses = "character", na.strings = "", check.names = FALSE
)
str(observations)
print(observations)

# 0 and NA must be treated differently, as 0 can reflect the absence of a species, while NA reflects a missing observation.

#PSEUDOCODE
# read_observations(path) function, should read a csv and return a data frame with the observations.
    #load observations
    # check exact column names
        #if column 1 not site, error
        #if column 2 not date, error
        #if column 3 not count, error
    # if site missing, error
    # if date missing, error
    # if count missing -> NA
    # use grepl("^(0|[1-9][0-9]*)$", value) on each NON-missing count
        # convert count to integer
    # print: "file read successfully"