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

lapply(c("nnet", "MASS"),  pkgTest)

# set wd for current folder
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


#####################
# Problem 1
#####################
library(nnet)

### 1
# load data
gdp_data <- read.csv("https://raw.githubusercontent.com/ASDS-TCD/StatsII_Spring2024/main/datasets/gdpChange.csv", stringsAsFactors = F)
head(gdp_data)

# Assign negative numbers, 0 and positive numbers to different strings respectively
gdp_data$GDPWdiff_category <- ifelse(gdp_data$GDPWdiff < 0, "negative",
                                     ifelse(gdp_data$GDPWdiff == 0, "no_change", "positive"))

# Convert required columns to factor variables
gdp_data$GDPWdiff_category <- factor(gdp_data$GDPWdiff_category, ordered = FALSE )
gdp_data$REG <- as.factor(gdp_data$REG)
gdp_data$OIL <- as.factor(gdp_data$OIL)

# Check the transformed dataframe
head(gdp_data)

# Set "no change" to the reference category
gdp_data$GDPWdiff_category <- relevel(gdp_data$GDPWdiff_category, ref = "no_change")

# run the muiltinomial regression model
multinom_model <- multinom(GDPWdiff_category ~ REG + OIL, data = gdp_data)

# Check the information of the model
summary(multinom_model)

# so,the unordered multinomial logit models are :
# for negative: ln(P_negative/P_no change) = 3.805370 + 1.379282*X_REG + 4.783968*X_OIL
# for positive: ln(P_positive/P_no change) = 4.533759 + 1.769007*X_REG + 4.576321*X_OIL

# Exponentiate coefficients
exp(coef(multinom_model)[,c (1:3)])


### 2

# Run ordered logit
ordered_model <- polr(GDPWdiff_category ~ REG + OIL, data = gdp_data, Hess = T)

# Check the information of the model
summary(ordered_model)

# so,the ordered multinomial logit models are :
# ln( P(Y <= no change)) = -5.3199 + 0.4102*REG -0.1788*OIL
# ln( P(Y <= negative)) = -0.7036 + 0.4102*REG -0.1788*OIL


# Get odds ratios and CIs
exp(cbind(OR = coef(ordered_model), confint(ordered_model)))


#####################
# Problem 2
#####################

### 1

# load data
mexico_elections <- read.csv("https://raw.githubusercontent.com/ASDS-TCD/StatsII_Spring2024/main/datasets/MexicoMuniData.csv")
head(mexico_elections)
View(mexico_elections)

# Convert required columns to factor variables
mexico_elections$PAN.governor.06 <- as.factor(mexico_elections$PAN.governor.06)
mexico_elections$competitive.district <- as.factor(mexico_elections$competitive.district)

# Run poisson regression model
poisson_model <- glm( PAN.visits.06 ~ PAN.governor.06 + competitive.district + marginality.06, data = mexico_elections, family = poisson(link = "log"))

# Check the information of the model
summary(poisson_model)

# so the poisson regression model is :
# ln(lambda) = -3.81023 - 0.31158*X_PAN.governor.06 - 0.08135*X_competitive.district - 2.08014*X_marginality.06


### 3

# Extract coefficients
coeffs <- coefficients(poisson_model)

# Substitute values into the model, so we can get the estimated mean number of visits
lambda <- exp(coeffs[1] + coeffs[2]*1 + coeffs[3]*1 + coeffs[4]*0)

# Print the results
print(lambda)



