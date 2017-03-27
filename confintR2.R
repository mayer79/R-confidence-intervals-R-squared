# Computes approximate one- or two-sided approximate confidence intervals for true R2
# Package MBESS is required in order to access the non-central F distribution
# Apply on result of lm
# 
# Example
# fit <- lm(Sepal.Length ~ Petal.Width, data = iris) # R-squared: 0.669
# confintR2(fit, alternative = "greater")            # Lower 95% limit: 0.5982115
confintR2 <- function(fit, alternative = c("two.sided", "less", "greater"), conf.level = 0.95) {
  alternative <- match.arg(alternative)
  alpha.lower <- alpha.upper <- 0
  
  if (alternative == "two.sided") {
    alpha.lower <- alpha.upper <- (1 - conf.level) / 2
  } else if (alternative == "greater") {
    alpha.lower <- 1 - conf.level
  } else if (alternative == "less") {
    alpha.upper <- 1 - conf.level
  }
  
  fstat <- summary(fit)$fstatistic
  df.1 <- fstat[2]
  df.2 <- fstat[3]
  Delta <- unlist(MBESS::conf.limits.ncf(
    F.value = fstat[1], 
    df.1, df.2, 
    alpha.lower,
    alpha.upper, 
    conf.level = NULL)[c("Lower.Limit", "Upper.Limit")])
  
  out <- c(Delta / (Delta + df.1 + df.2 + 1))
  out[is.na(out)] <- 0
  out
}