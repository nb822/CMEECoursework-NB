# Packages ---------------------------------------------------------------
message("\n----------------LOADING PACKAGES-------------------------\n")
library(tidyverse)
library(reshape2)

# Load the data ----------------------------------------------------------
# The first rows describe the sampling design, so do not use one as a header yet.
MyData <- as.matrix(read.csv("data/pound_hill_data.csv", header = FALSE))

# The metadata file does have a header and uses semicolons as separators.
MyMetaData <- read.csv("data/pound_hill_meta_data.csv", header = TRUE, sep = ";")

# Inspect the data --------------------------------------------------------
message("\n----------------PREVIEW DATA -------------------------\n")
head(MyData, n=3)
message("\n----------------DATA MATRIX DIMENSIONS -------------------------\n")
dim(MyData)
str(MyData)
message("\n----------------METADATA -------------------------\n")
head(MyMetaData)

# Transpose so species become columns and sampled quadrats become rows.
MyData <- t(MyData) 

#can convert blank cells in species count rows to zero per metadata -----------
message("\n\nWARNING: Converting blank entries to observed zeros: verify this with new data\n\n")
MyData[MyData == ""] <- 0

# Convert the raw matrix to a data frame --------------------------------
#[-1,] excludes the first row
TempData <- as.data.frame(MyData[-1, ], stringsAsFactors = FALSE)
colnames(TempData) <- MyData[1, ]
rownames(TempData) <- NULL

# Convert from wide to long form ----------------------------------------

MyWrangledData <- melt(
  TempData,
  id = c("Cultivation", "Block", "Plot", "Quadrat"),
  variable.name = "Species",
  value.name = "Count"
)

# Make sure count data numeric and non-negative -----------------------------
MyWrangledData$Count <- as.integer(MyWrangledData$Count)
MyWrangledData$Cultivation <- as.factor(MyWrangledData$Cultivation)
MyWrangledData$Block <- as.factor(MyWrangledData$Block)
MyWrangledData$Plot <- as.factor(MyWrangledData$Plot)
MyWrangledData$Quadrat <- as.factor(MyWrangledData$Quadrat)
 
if(min(MyWrangledData$Count) < 0){
    message("WARNING: negative values detected")
}

#determine number of distinct species, quadrats and plots
MyWrangledData <- as_tibble(MyWrangledData)

#number of species

n_species <- MyWrangledData  %>% distinct(Species)  %>% nrow()
message(sprintf("Number of species: %d", n_species))

#number of plots
n_plots <- MyWrangledData  %>%  distinct(Cultivation, Block, Plot)  %>% nrow()
message(sprintf("Number of plots: %d", n_plots))

##number of quadrats
n_quads <- MyWrangledData  %>% 
    dplyr::distinct(Cultivation, Block, Plot, Quadrat)  %>% 
    nrow()
message(sprintf("Number of quadrats: %d", n_quads))

# Make a quadrat-level table containing Cultivation, Block, Plot, Quadrat and Richness
# richness = number of species with more than 0 
quadrat_richness <- MyWrangledData  %>% 
    dplyr::group_by(Cultivation, Block, Plot, Quadrat)  %>% 
    summarise(Richness = sum(Count != 0), .groups = "drop")

# Make a plot-level table containing Cultivation, Block, Plot and mean Richness
plot_mean_richness <- quadrat_richness  %>%
    dplyr::group_by(Cultivation, Block, Plot)  %>% 
    summarise(Mean_Richness = mean(Richness), .groups = "drop")
#save table
write.csv(plot_mean_richness, "results/pound_hill_plot_richness.csv", row.names = FALSE)
message("\n Plot mean richness table saved to results/pound_hill_plot_richness.csv\n")

# Plot mean richness among three different cultivation treatments 
pdf("results/pound_hill_plot_richness.pdf", 11.7, 8.3) 


ggplot(plot_mean_richness, aes(x = Cultivation, y = Mean_Richness, fill = Block))+
    geom_col(position = "dodge")+
    scale_fill_manual(values = c("#41AEBD", "#97E9D5", "#A2CF49", "#608F3D"))+
    xlab("Cultivation month")+
    ylab("Species richness")+
    theme_classic()

graphics.off()
message("\nSpecies richness by plot graph saved to results/pound_hill_plot_richness.pdf\n\n")

# FIGURE INTERPRETATION
# All plots show a general pattern of species richness increasing from March to May, and decreasing from May to October. Peak richness May in all plots.
# The difference in richness between March and October is variable and depends on the plot. 




## EXTENSION EXERCISE: plot-level summary for total abundance
quadrat_abundance <- MyWrangledData  %>% 
    dplyr::group_by(Cultivation, Block, Plot, Quadrat)  %>% 
    summarise(Abundance = sum(Count), .groups = "drop")

# Make a plot-level table containing Cultivation, Block, Plot and mean Richness
plot_total_abundance <- quadrat_abundance  %>%
    dplyr::group_by(Cultivation, Block, Plot)  %>% 
    summarise(Total_abundance = sum(Abundance), .groups = "drop")

ggplot(plot_total_abundance, aes(x = Cultivation, y = Total_abundance, fill = Block))+
    geom_col(position = "dodge")+
    scale_fill_manual(values = c("#41AEBD", "#97E9D5", "#A2CF49", "#608F3D"))+
    xlab("Cultivation month")+
    ylab("Total plot plant abundance")+
    theme_classic()


# FIGURE INTERPRETATION. 
# Unlike richness, patterns of abundance vary among plots. 
# May is only the peak month of abundance for one plot. Indicating that more species rich plots aren't necessarily the most plant-dense. This may be due to increased competition, where reduced richness leads to numerical dominance of some species.