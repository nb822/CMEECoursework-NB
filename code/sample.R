## A function to take a sample of size n from a population 'popn' and return its means
myexperiment <- function(popn, n) {
    pop_sample <- sample(popn, n, replace = FALSE)
    return(mean(pop_sample))
}

# calculate means using a for loop on a vector without pre-allocation
loopy_sample1 <- function(popn, n, num) {
    result1 <- vector()
    for(i in 1:num) {
        result1 <- c(result1, myexperiment(popn, n))
    }
    return(result1)
}

#same as loopy1 but with pre-allocation
loopy_sample2 <- function(popn, n, num) {
    result2 <- vector( ,num)
    for(i in 1:num) {
        result2[i] <- myexperiment(popn, n)
    }
    return(result2)
}

#same as loopy2 but a list rather than a vector
loopy_sample3 <- function(popn, n, num) {
    result3 <- vector("list", num)
    for(i in 1:num) {
        result3[[i]] <- myexperiment(popn, n)
    } 
    return(result3)
}

#using lapply
lapply_sample <- function(popn, n, num) {
    result4 <- lapply(1:num, function(i) myexperiment(popn, n))
    return(result4)
}

#using sapply - takes in a list and returns a vector
sapply_sample <- function(popn, n, num) {
    result5 <- sapply(1:num, function(i) myexperiment(popn, n))
    return(result5)
}

set.seed(12345)
popn <- rnorm(10000)
hist(popn)
n <- 1000 #sample size
num <- 10000 #number of times to rerun the sampling


print("Using loops without preallocation on a vector took:" )
print(system.time(loopy_sample1(popn, n, num)))

print("Using loops with preallocation on a vector took:" )
print(system.time(loopy_sample2(popn, n, num)))

print("Using loops with preallocation on a list took:" )
print(system.time(loopy_sample3(popn, n, num)))

print("Using the vectorised sapply function (on a list) took:" )
print(system.time(sapply_sample(popn, n, num)))

print("Using the vectorised lapply function (on a list) took:" )
print(system.time(lapply_sample(popn, n, num)))

