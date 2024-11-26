#### Preamble ####
# Purpose: Cleans fishing raw dataset
# Author: Sakura Noskor
# Date: 23 November 2024
# Contact: sakura.noskor@mail.utoronto.ca

#install.packages("readxl")

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(janitor)
library(readxl)
library(openxlsx)


#### Clean data ####

data <- read.xlsx('../data/01-raw_data/NPAFC_Catch_Stat-1925-2023.xlsx', sheet = 1) 
print(data)
colnames(data) <- data[1, ]
data <- data[-1, ]

cleaned_pac2 <- data %>%
  filter(`Data Type` == "Number (000's)", `Whole Country/Province/State` == "Whole country", Species == "Total")  %>%
  select(Country, Species, `Catch Type`, `2022`) %>%
  filter(!is.na(`2022`) & `2022` != 0)
cleaned_pac2


cleaned_pac <- data %>%
  filter(Species == "Total", `Data Type` == "Number (000's)", `Reporting Area` == "Whole country") %>%
  filter(!is.na(Country)) %>%
  filter(!is.na(`1925`) & `1925` != 0) %>%
  filter(!is.na(`1946`) & `1946` != 0)

cleaned_pac


#### Save data ####
write_csv(cleaned_pac, "./data/02-analysis_data/cleaned_pacific_allyear.csv")
arrow::write_parquet(cleaned_pac, "./data/02-analysis_data/cleaned_pacific_allyear.parquet")

write_csv(cleaned_pac2, "./data/02-analysis_data/cleaned_pacific2022.csv")
arrow::write_parquet(cleaned_pac2, "./data/02-analysis_data/cleaned_pacific2022.parquet")
