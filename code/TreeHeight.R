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
    print(paste("Tree height is:", height))

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

    dataframe$Tree.Height.m <- NA
    row_number <- nrow(dataframe)

    for (i in 1:row_number) {
        height <- TreeHeight(dataframe[i, 2], dataframe[i, 3])
        dataframe[i, 4] <- height
    }
    return(dataframe)
}

trees <- read.csv("data/trees.csv")
height_df <- TreeHeight_loop(trees)
write.csv(height_df, "results/TreeHts.csv")
