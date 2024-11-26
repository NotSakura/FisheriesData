#### Preamble ####
# Purpose: Simulates a dataset of Fishing data
# Author: Sakura Noskor
# Date: 23 November 2024
# Contact: sakura.noskor@mail.utoronto.ca
# Pre-requisites: go to "https://www.npafc.org/statistics/" and look for "NPAFC Catch Statistics (updated 28 June 2024)". Click on that you will get the csv file containing all the data. 

library(tidyverse)


# Load the simulated data
#the data is already downloaded in the repository. 
data <- read.xlsx('../data/01-raw_data/NPAFC_Catch_Stat-1925-2023.xlsx', sheet = 1) 




         
