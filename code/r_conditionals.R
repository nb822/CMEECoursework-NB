#function to test whether a number is even or odd
is.even <- function(n = 2) {
    if (n %% 2 == 0) {
        return(paste(n, 'is even!'))
    } else {
        return(paste(n, 'is odd!'))
    }
}

is.even(6)
#default is 2
is.even()
is.even(3)

#checks if a number is a power of 2
is.power2 <- function(n = 2) {
    if (log2(n) %% 1 == 0) {
        return(paste(n, 'is a power of 2!'))
    } else {
        return(paste(n, 'is not a power of 2!'))
    }
}

is.power2()
is.power2(3)
is.power2(4)
is.power2(8)

#checks if a number is prime
is.prime <- function(n = 2) {
    if (n==0) {
        return(paste(n, 'is a zero!'))
    } else if (n == 1) {
        return(paste(n, 'is just a unit!'))
    } else if (n == 2) {
        return(paste(n, 'is a prime number!'))
    }

    ints <- 2:(n-1)

    if (all(n%%ints != 0)) {
        return(paste(n, 'is a prime number!'))
    } else {
        return(paste(n, 'is a composite!'))
    }
}

is.prime()
is.prime(3)
is.prime(10)