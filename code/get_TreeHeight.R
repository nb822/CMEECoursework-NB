
## ------------------FUNCTIONS-----------------------------
# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height  <- distance * tan(radians)
    return(height)
}

## This function uses the TreeHeight function and calculates it for each row in a df
## ARGUMENTS:
## dataframe: dataframe with 2nd column Distance and 3rd column Angle.degrees
## 
## OUTPUT:
## dataframe with height column 
TreeHeight_loop <- function(dataframe) {
    dataframe$height_m <- TreeHeight(dataframe$Angle.degrees, dataframe$Distance.m) 
    return(dataframe)
}


# Checks if all column names correct and if distance and angle columns have accepted numbers
check_cols <- function(dataframe) {

    expected <- c("Species", "Distance.m", "Angle.degrees")
    if (!identical(colnames(dataframe)[1:3], expected)) {
        message("Invalid column names")
        return(FALSE)
    }

    for (i in 1:nrow(dataframe)){
        if (is.finite(dataframe$Distance.m[i]) != TRUE |  
        dataframe$Distance.m[i] < 0 | dataframe$Distance.m[i] > 100){
            message(sprintf("Invalid distance number at row %d", i))
            return(FALSE)
        }
        if (is.finite(dataframe$Angle.degrees[i]) != TRUE |
        dataframe$Angle.degrees[i] < 0 | dataframe$Angle.degrees[i] > 90){
            message(sprintf("Invalid angle at row %d", i))
            return(FALSE)
        }
    }
    message("All columns read and valid")
    return(TRUE)
}


##-----------------------CODE-------------------------------------

path <- commandArgs(trailingOnly = TRUE)



if (length(path) != 1) {
    message("Please supply exactly one argument")
    quit(status = 1)
}

if (!file.exists(path)) {
    message("File path does not exist")
    quit(status = 1)
}


message(sprintf("Reading file '%s'", path))
trees <- read.csv(path)

if (!check_cols(trees)) {
    #message already in check_cols so no need for extra
    quit(status = 1)
}

height_df <- TreeHeight_loop(trees)

#get filename
filename <- basename(path)
filename <- gsub(".csv", "", filename)
new_path <- paste("results/", filename, "_treeheights.csv", sep = "")


write.csv(height_df, new_path, row.names = FALSE)
message("Code complete, results saved")

