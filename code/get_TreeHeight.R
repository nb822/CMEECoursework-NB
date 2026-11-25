## Takes functions from TreeHeight.R and runs them on a csv file of tree data, writing the results to a new csv file in the results directory.

##-----------------------CODE-------------------------------------
source("code/TreeHeight.R")
path <- commandArgs(trailingOnly = TRUE)


if (length(path) != 1) {
    message("Please supply exactly one argument")
    stop()
}

if (!file.exists(path)) {
    message("File path does not exist")
    stop()
}

message(sprintf("Reading file '%s'", path))
trees <- read.csv(path, check.names = FALSE)

if (!check_cols(trees)) {
    #message already in check_cols so no need for extra
    stop()
}

height_df <- TreeHeight_loop(trees)

#get filename
filename <- basename(path)
#sub instead of gsub to handle files named csv.csv for example
filename <- sub("\\.csv$", "", filename, ignore.case = TRUE)
new_path <- paste("results/", filename, "_treeheights.csv", sep = "")

#create results directory if it doesn't exist, no warnings so that it doesn't complain if it already exists
dir.create("results", showWarnings = FALSE, recursive = TRUE)

write.csv(height_df, new_path, row.names = FALSE)
message("Code complete, results saved")

