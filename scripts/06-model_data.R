#### Preamble ####
# Purpose: models the data so it predictis how much the fishing increases per year
# Author: Sakura Noskor
# Date: 23 November 2024
# Contact: sakura.noskor@mail.utoronto.ca

#### Workspace setup ####
library(tidyr)
library(dplyr)

# Convert columns that should be years to numeric
cleaned_pac <- read.csv("./data/02-analysis_data/cleaned_pacific_allyear.csv")

temp <- cleaned_pac  %>%
  select(-`Whole Country/Province/State`, -`Data Type`, -`Reporting Area`, -Species, -`Catch Type`)

temp <- temp %>%
  mutate(across(`1925`:`2023`, as.numeric))

long_data <- temp %>%
  pivot_longer(
    cols = starts_with("19") | starts_with("20"),  # Select columns starting with "19" or "20"
    names_to = "Year",
    values_to = "Catch"
  ) %>%
  mutate(Year = as.numeric(Year))

library(rstanarm)

model_formula <- Catch ~ Year + (1 | Country)

bayesian_model <- stan_glmer(
  formula = model_formula,
  data = long_data,
  family = gaussian(),  # Adjust this if using a different distribution for your data
  prior = normal(0, 2.5, autoscale = TRUE),
  prior_intercept = normal(0, 2.5, autoscale = TRUE),
  seed = 123,
  adapt_delta = 0.95,
  cores = 4
)


library(brms)

# Specify priors
priors <- c(
  set_prior("normal(0, 2.5)", class = "Intercept"),   # Prior for the intercept
  set_prior("normal(0, 2.5)", class = "sd")           # Prior for the standard deviation of random effects (Country)
)

# Fit the model using brms
bayesian_model_commercial_brms <- brm(
  formula = Is_Commercial ~ (1 | Country),  # Random effect for Country
  data = cleaned_pac2,
  family = bernoulli(),                    # Bernoulli family for binary outcomes
  prior = priors,                          # Use the prior argument here
  seed = 123
)

# Check the model summary
modelsummary(bayesian_model_commercial_brms)


# Extract random effects using brms
ranef_bayesian_model_commercial_brms <- ranef(bayesian_model_commercial_brms)

#### Save model ####
saveRDS(
  bayesian_model,
  file = "models/bayesian_model1.rds"
)
saveRDS(
  bayesian_model_commercial_brms,
  file = "models/bayesian_model2.rds"
)





