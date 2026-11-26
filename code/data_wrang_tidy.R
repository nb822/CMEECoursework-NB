# Load the data
MyData <- as.matrix(read.csv("data/pound_hill_data.csv", header = FALSE))

# The metadata file does have a header and uses semicolons as separators.
MyMetaData <- read.csv("data/pound_hill_meta_data.csv", header = TRUE, sep = ";")

#load packages
if (!require("tidyverse")) install.packages("tidyverse")
require(tidyverse)

# inspect the data, uncomment the following lines to see the output
#class(MyData)
#glimpse(MyData)

#transpose the data, uncomment the following lines to see the output
MyData <- t(MyData) 
#head(MyData)
#dim(MyData)

#set column names to the first row of the transposed data. This is equivalent to colnames(MyData) <- MyData[1, ]
colnames(MyData) <- MyData[1, ]

#stringr equivalent of MyData[MyData == ""] <- 0. Treating blanks as 0 following metadata
MyData[] <- str_replace(MyData, "^$", "0")

# need to turn matrix to tibble to use tidyr::pivot_longer() function. Using as_tibble() with .name_repair = "minimal" to avoid changing column names.
TempData <- MyData[-1, ] |>
  as_tibble(.name_repair = "minimal")


#pivoting the data from wide to long format using tidyr::pivot_longer()
MyWrangledData <- TempData |>
  tidyr::pivot_longer(
    cols = -c(Cultivation, Block, Plot, Quadrat),
    names_to = "Species",
    values_to = "Count"
  )

#change class of different columns as in data_wrang.R
MyWrangledData <- MyWrangledData |>
  mutate(
    Cultivation = as.factor(Cultivation),
    Block = as.factor(Block),
    Plot = as.factor(Plot),
    Quadrat = as.factor(Quadrat),
    Count = as.integer(Count)
  )  %>% 
  arrange(Species)

#save file
dir.create("results", showWarnings = FALSE)
write_csv(MyWrangledData, "results/pound_hill_long_tidyverse.csv")
print("File saved as results/pound_hill_long_tidyverse.csv")