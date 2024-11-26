#### Preamble ####
# Purpose: tests the simuated dataset of Fishing data
# Author: Sakura Noskor
# Date: 23 November 2024
# Contact: sakura.noskor@mail.utoronto.ca
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
  # - necessary packages must be installed and loaded



#install.packages("validate")
#install.packages("validate")

#### Workspace setup ####
library(tidyverse)

# Load necessary libraries
# Load necessary libraries
library(testthat)
library(validate)
library(readr)

# Load the simulated data
fish_catch_data <- read_csv("data/00-simulated_data/simulated_data.csv")


# Test if the fish catch data contains no negative values
test_that("Yearly Fish Catch contains no negative values", {
  # Check that all values in Yearly_Fish_Catch are greater than or equal to 0
  expect_true(all(fish_catch_data$Yearly_Fish_Catch >= 0))
})

# Test if the data frame has the expected structure
test_that("Data frame has expected structure", {
  # Check if the data frame has 4 columns
  expect_equal(ncol(fish_catch_data), 4)
  
  # Check the column names
  expect_true(all(c("Species", "Area", "Country", "Yearly_Fish_Catch") %in% colnames(fish_catch_data)))
  
  # Check if the types of the columns are correct
  expect_true(is.factor(fish_catch_data$Species))
  expect_true(is.factor(fish_catch_data$Area))
  expect_true(is.factor(fish_catch_data$Country))
  expect_true(is.numeric(fish_catch_data$Yearly_Fish_Catch))
})

# Test if the sampling for Species, Area, and Country is correct
test_that("Sampling from predefined categories is correct", {
  # Check if species are correctly sampled from the species list
  expect_true(all(fish_catch_data$Species %in% species))
  
  # Check if area is correctly sampled from the area list
  expect_true(all(fish_catch_data$Area %in% areas))
  
  # Check if country is correctly sampled from the country list
  expect_true(all(fish_catch_data$Country %in% countries))
})

# Test if the catch data is within reasonable bounds
test_that("Catch data is within reasonable bounds", {
  # Check if the catch data lies within a reasonable range (e.g., 0 to 1000 tons)
  expect_true(all(fish_catch_data$Yearly_Fish_Catch >= 0 & fish_catch_data$Yearly_Fish_Catch <= 1000))
})

# Test if the generated data has a reasonable mean and sd for Yearly_Fish_Catch
test_that("Catch data has expected mean and sd", {
  # Check if the mean and standard deviation are within a reasonable range
  catch_mean_actual <- mean(fish_catch_data$Yearly_Fish_Catch)
  catch_sd_actual <- sd(fish_catch_data$Yearly_Fish_Catch)
  
  # Set tolerance levels for the expected mean and SD
  tolerance_mean <- 50
  tolerance_sd <- 20
  
  expect_true(abs(catch_mean_actual - catch_mean) <= tolerance_mean)
  expect_true(abs(catch_sd_actual - catch_sd) <= tolerance_sd)
})


