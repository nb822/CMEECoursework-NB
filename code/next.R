# can use next to skip the current iteration of a loop and move on to the next one
for (i in 1:10) {
    if ((i %% 2) == 0) {
        next
    }
    print(i)
}
