# build a random matrix
M <- matrix(rnorm(100), 10, 10)

#take the mean of each row, 2 would mean over each column
rowMeans <- apply(M, 1, mean)
rowMeans

#now the variance
rowVars <- apply(M, 1, var)
rowVars

# by column
colMeans <- apply(M, 2, mean)
colMeans

