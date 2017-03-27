# R-confidence-intervals-R-squared
R function that takes an `lm' object and returns and approximate one- or two-sided confidence interval for population R-squared.

It helps to judge how strong the linear relation between regressors and response truely is with given (approximate) certainty. A positive lower bound of a one-sided confidence interval means the corresponding global F-test provides a significant result on the corresponding level.

## Example
```
  library(MBESS)
  fit <- lm(Sepal.Length ~ Petal.Width, data = iris) # R-squared: 0.669
  confintR2(fit, alternative = "greater")            # Lower 95% limit for true R-squared: 0.5982115
```