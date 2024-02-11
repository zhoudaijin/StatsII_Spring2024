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

# Set H0 and H1
# H0:There is no significant difference in the distribution of the two samples
# H1:There is a significant difference in the distribution of the two samples

# Set seeds to ensure reproducibility
set.seed(123)

# Generate 1000 Cauchy random variables
cauchy_data <- rcauchy(1000, location = 0, scale = 1)

# Create empirical distribution of observed data
ECDF <- ecdf(cauchy_data)
empiricalCDF <- ECDF(cauchy_data)

# Create theoretical cumulative distribution of observed data
theoretical_CDF <- pnorm(cauchy_data)
theoretical_CDF

# Calculate test statistic
D <- max(abs(empiricalCDF - theoretical_CDF))

# Calculate P value 
p_value <- sqrt(2 * pi) / D * sum(exp(-(2*(1:1000)-1)^2 * pi^2 / (8 * D^2)))

# Print p value
print(p_value)

# p value is 5.652523e-29

# Check the results using ks.test()
results <- ks.test(empiricalCDF, theoretical_CDF)

# Print results
print(results)

# the results: D = 0.135, p-value = 2.432e-08, alternative hypothesis: two-sided
# so, there is a sufficient reason to reject H0, 
# and there is a significant difference in the distribution of the two samples


#####################
# Problem 2
#####################

# Set seeds to ensure reproducibility
set.seed (123)

# Create dataframe
data <- data.frame(x = runif(200, 1, 10))
data$y <- 0 + 2.75*data$x + rnorm(200, 0, 1.5)

# Perform OLS linear regression using the lm() function
lm_model <- lm(y ~ x, data = data)

summary(lm_model)
# The intercept is 0.139187, the coefficient of x is 2.726699.

# Use the optim() function to perform linear regression 
# with the BFGS algorithm
optim_model <- optim(par=c(0, 1), 
                     fn=function(coef) {
                       sum((data$y - (coef[1] + coef[2] * data$x))^2)
                       }, method = "BFGS")

print(optim_model$par)
# The intercept is 0.139187, the coefficient of x is 2.726699, 
# which is equivalent to using lm.








