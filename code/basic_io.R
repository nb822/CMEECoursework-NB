# A simple R script showing file input and output 
#run from root with >Rscript code/basic_io.R 

MyData <- read.csv("data/trees.csv", header = TRUE) #import w/ headers
write.csv(MyData, "results/MyData.csv")             #write to results folder
write.table(MyData[1,], file = "results/MyData.csv", append = TRUE) # append to it
