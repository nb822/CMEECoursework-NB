# A simple R script showing file input and output 
#run from root with >Rscript code/basic_io.R 

mkdir("results", showWarnings = FALSE) #create results folder if it doesn't exist

MyData <- read.csv("data/trees.csv", header = TRUE) #import w/ headers
write.csv(MyData, "results/MyData.csv")             #write to results folder
write.table(MyData[1,], file = "results/MyData.csv", append = TRUE) # append to it
write.csv(MyData, "results/MyData.csv", row.names = TRUE) # Write row names
write.table(MyData, "results/MyData.csv", col.names = FALSE) # Omit column names