## working through plotting exercises
require(tidyverse)

MyDF <- read.csv("data/ecol_archives_e_089_51_d_1.csv")
MyDF <- as_tibble(MyDF)
glimpse(MyDF)

MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location <- as.factor(MyDF$Location)
glimpse(MyDF)

#convert all mass units to same 
unique(MyDF$Prey.mass.unit)
MyDF$Prey.mass[MyDF$Prey.mass.unit == "mg"] <- MyDF$Prey.mass[MyDF$Prey.mass.unit == "mg"] / 1000
MyDF$Prey.mass.unit[MyDF$Prey.mass.unit == "mg"] <- "g"
unique(MyDF$Prey.mass.unit)

#plotting
plot(MyDF$Predator.mass, MyDF$Prey.mass)
plot(log10(MyDF$Predator.mass), log10(MyDF$Prey.mass), pch = 20, xlab = "Log10 predator mass (g)", ylab = "Log10 Prey mass (g)")

#histograms
#right skewed
hist(MyDF$Predator.mass)
#try logs
hist(log10(MyDF$Predator.mass), xlab = "log10(Predator mass(g))", ylab = "Count", col = "lightblue")

#SUBPLOTS
par(mfcol=c(2,1))
#specify which subplot to use first
par(mfg = c(1,1))

hist(log10(MyDF$Predator.mass), xlab = "log10(Predator Mass (g))", ylab = "Count", col = "lightblue", main = 'Predator')
par(mfg = c(2,1)) # Second sub-plot
hist(log10(MyDF$Prey.mass), xlab = "log10(Prey Mass (g))", ylab = "Count", col = "lightgreen", main = 'Prey') # nolint
dev.off()

#OVERLAYING PLOTS
hist(log10(MyDF$Predator.mass), 
    xlab = "log10(Predator Mass (g))", 
    ylab = "Count", 
    breaks = 20,
    col = rgb(1,0,0,0.5), 
    main = 'Predator-prey size overlap')

hist(log10(MyDF$Prey.mass), 
    col = rgb(0,0,1,0.5), 
    breaks = 20,
    add = TRUE)

#add legend
legend('topleft',
    c('Predators', 'Prey'),
    fill = c(rgb(1,0,0,0.5), rgb(0,0,1,0.5)))


#boxplots
boxplot(log10(MyDF$Predator.mass) ~ MyDF$Type.of.feeding.interaction,
    xlab = "Location",
    ylab = "Log10 Predator mass (g)",
    main = "Predator mass by feeding interaction type")