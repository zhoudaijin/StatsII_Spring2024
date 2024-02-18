#####################
# load libraries
# set wd
# clear global .envir
#####################

# remove objects
rm(list=ls())
# detach all libraries
detachAllPackages <- function() {
  basic.packages <- c("package:stats", "package:graphics", "package:grDevices", "package:utils", "package:datasets", "package:methods", "package:base")
  package.list <- search()[ifelse(unlist(gregexpr("package:", search()))==1, TRUE, FALSE)]
  package.list <- setdiff(package.list, basic.packages)
  if (length(package.list)>0)  for (package in package.list) detach(package,  character.only=TRUE)
}
detachAllPackages()

# load libraries
pkgTest <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[,  "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg,  dependencies = TRUE)
  sapply(pkg,  require,  character.only = TRUE)
}

# here is where you load any necessary packages
# ex: stringr
# lapply(c("stringr"),  pkgTest)

lapply(c(),  pkgTest)

# set wd for current folder
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#####################
# Problem 1
#####################

## Quesiton 1

install.packages("texreg")
library(texreg)

install.packages("xtable")
library(xtable)

# load data
load(url("https://github.com/ASDS-TCD/StatsII_Spring2024/blob/main/datasets/climateSupport.RData?raw=true"))
load("/Users/daisy/Downloads/climateSupport.RData")
ls()

# Preview data
summary(climateSupport)  # View summary statistics of the data
head(climateSupport)     # View the first few rows of the data

# Convert data format of DV into binary outcome
climateSupport$choice <- ifelse(climateSupport$choice == "Supported", 1, 0)

# Change data format of IVs to unordered factors
climateSupport$countries <- factor(climateSupport$countries, ordered = FALSE)
climateSupport$sanctions <- factor(climateSupport$sanctions, ordered = FALSE)

# Use the relevel function to set the baseline level and fit logistic regression model
climateSupport$countries <- relevel(climateSupport$countries, ref = "20 of 192")
climateSupport$sanctions <- relevel(climateSupport$sanctions, ref = "None")
model <- glm(choice ~ ., family = binomial(link = "logit"), data = climateSupport)

# Output the results of the model
summary(model)

# Create LaTeX table for the model
texreg(model)

## Likelihood ratio test

# H0: beta_1 = beta_2 = ...= beta_5 = 0
# H1: at least one slope is not equal to 0
#  Create a null model
null_model <- glm(choice ~ 1, 
                  data = climateSupport, 
                  family = "binomial")

#  Run an anova test on the model compared to the null model 
anova_result_1 <- anova(null_model, model, test = "LRT") 

# print results
print(anova_result_1)

# Create LaTeX table for the model

# Create a data frame containing ANOVA results
result_table_1 <- xtable(anova_result_1)

# Convert to xtable format
print(result_table_1, include.rownames = FALSE)


## Quesiton 2 

# (a)

# Fitted logistic regression model is:
# logit^(p/(1-p)) = beta0 + beta_1*countries_80 + beta_2*countries_160 + 
# beta_3*sanctions_5% + beta_4*sanctions_15% + beta_5*sanctions_20% 

# After substituting the coefficients, get:
# logit^(p/(1-p)) = -0.27266 + 0.33636*countries_80 + 0.64835*countries_160 + 
# 0.19186*sanctions_5% - 0.13325*sanctions_15% - 0.30356*sanctions_20% 

# according to: logit^(p_5%/(1-p_5%)) =  -0.27266 + 0.64835*countries_160 + 0.19186*sanctions_5%
log_odd_p_5 <- -0.27266 + 0.64835*1 + 0.19186*1

# According to: logit^(p_15%/(1-p_15%)) =  -0.27266 + 0.64835*countries_160 - 0.13325*sanctions_15%
log_odd_p_15 <- -0.27266 + 0.64835*1 - 0.13325*1

# Subtract two log odds, get the difference of log odds
delta = log_p_15 - log_p_5 

# Indexed results according to the formula: OR = exp^(delta)
exp(delta)

# Print results:0.7224479


# (b)

# After substituting the coefficients, get:
# logit^(p_80/(1-p_80)) =  -0.27266 + 0.33636*countries_80
log_odd_p_80 <- -0.27266 + 0.33636*1

# According to the formula: P = exp(logit^(P/(1-P))/(1+exp(logit^(P/(1-P)))
p_80 = exp(log_odd_p_80) / (1 + exp(log_odd_p_80))

# Print the results
print(p_80)

# Results : 0.5159196


# (c)

# Fit a logistic regression model that includes interaction terms
interaction_model <- glm(choice ~ countries * sanctions, family = binomial(link = "logit"), data = climateSupport)

# Use anova() to compare with the addictive model
anova_result_2 <- anova(interaction_model, model, test = "Chi")

# Print results
print(anova_result_2)

# Create LaTeX table for the model

# Create a data frame containing ANOVA results
result_table_2 <- xtable(anova_result_2)

# Convert to xtable format
print(result_table_2, include.rownames = FALSE)











