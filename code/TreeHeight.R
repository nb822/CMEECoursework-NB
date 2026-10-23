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

#load df
trees <- read.csv("data/trees.csv")

#if nothing wrong with dataframe, run height code and write to results, else print error message
if (!check_cols(trees)) {
    #message already in check_cols so no need for extra
    quit()
}

height_df <- TreeHeight_loop(trees)
write.csv(height_df, "results/TreeHts.csv", row.names = FALSE)
message("Code complete, results saved")

