a <- TRUE
#prints "a is TRUE" as boolean 'TRUE' has been assigned to variable 'a'.
if (a) {
    print ("a is TRUE")
} else {
    print ("a is FALSE")
}

#simple if statement, nothing printed if greater 0.5
z <- runif(1) ## Generate a uniformly distributed random number
if (z <= 0.5) {print ("Less than a half")}

#for loop where numbers 1-10 are squared and printed
for (i in 1:10) {
    j <- i * i
    print(paste(i, " squared is", j ))
}
#simple for loop that prints the species name for each species in the list
for(species in c('Heliodoxa rubinoides', 
                 'Boissonneaua jardini', 
                 'Sula nebouxii')) {
      print(paste('The species is', species))
}

#same structure as above
v1 <- c("a","bc","def")
for (i in v1) {
    print(i)
}

#while loop that prints the squares of numbers 1-10. Similar to for loop above
i <- 0
while (i < 10) {
    i <- i+1
    print(i^2)
}