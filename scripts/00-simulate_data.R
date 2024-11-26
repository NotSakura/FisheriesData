#### Preamble ####
# Purpose: Simulates a dataset of Fishing data
# Author: Sakura Noskor
# Date: 23 November 2024
# Contact: sakura.noskor@mail.utoronto.ca
# Pre-requisites: The `tidyverse` package must be installed



#### Workspace setup ####
library(tidyverse)
# Load necessary library
library(dplyr)
set.seed(835)  # For reproducibility


species <- c("Salmon", "Tuna", "Cod", "Herring", "Mackerel")
areas <- c("Atlantic", "Pacific", "Indian Ocean", "Mediterranean", "Arctic")
countries <- c("USA", "Canada", "Norway", "Japan", "Australia")

n <- 1000
species_data <- sample(species, n, replace = TRUE)
area_data <- sample(areas, n, replace = TRUE)
country_data <- sample(countries, n, replace = TRUE)

catch_mean <- 500  # Mean catch in tons
catch_sd <- 150  # Standard deviation in tons

catch_data <- round(pmax(rnorm(n, mean = catch_mean, sd = catch_sd), 0), 0)

fish_catch_data <- data.frame(
  Species = species_data,
  Area = area_data,
  Country = country_data,
  Yearly_Fish_Catch = catch_data
)

head(fish_catch_data)


#### Save data ####
write_csv(fish_catch_data, "data/00-simulated_data/simulated_data.csv")
