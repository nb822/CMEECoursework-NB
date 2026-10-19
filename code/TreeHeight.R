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

## This function takes a dataframe, loops through each 
## row and appends it to new column Tree.Height.m
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
    if (colnames(dataframe)[1] != "Species"){
        return(message("Invalid column names"))
    }
    if (colnames(dataframe)[2] != "Distance.m"){
        return(message("Invalid column names"))
    }
    if (colnames(dataframe)[3] != "Angle.degrees"){
        return(message("Invalid column names"))
    }
    for (i in 1:nrow(dataframe)){
        if (is.finite(dataframe$Distance.m[i]) != TRUE |  
        dataframe$Distance.m[i] < 0 | dataframe$Distance.m[i] > 100){
            return(message(sprintf("Invalid distance number at row %d", i)))
        }
        if (is.finite(dataframe$Angle.degrees[i]) != TRUE |
        dataframe$Angle.degrees[i] < 0 | dataframe$Angle.degrees[i] > 90){
            return(message(sprintf("Invalid angle at row %d", i)))
        }
    }
    return(TRUE)
    message("All columns read and valid")
}

#load df
trees <- read.csv("data/trees.csv")

#if nothing wrong with dataframe, run height code and write to results, else print error message
if (check_cols(trees)){
    height_df <- TreeHeight_loop(trees)
    write.csv(height_df, "results/TreeHts.csv", row.names = FALSE)
    message("Code complete, results saved")
} else {
   message("Invalid dataframe")
}
