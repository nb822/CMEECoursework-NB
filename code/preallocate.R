NoPreallocFun <- function(x) {
    a <- vector()
    for (i in 1:x) {
        a <- c(a,i)
    }
}

PreallocFun <- function(x) {
    a <- rep(NA, x) #pre-allocate the vector
    for (i in 1:x){
        a[i] <- i
    }
}

system.time(NoPreallocFun(100000))
system.time(PreallocFun(100000))