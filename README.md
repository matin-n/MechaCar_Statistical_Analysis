# MechaCar Statistical Analysis

AutosRUs' newest prototype, the MechaCar, suffers from production trouble that blocks the manufacturing team's progress. AutoRUs' production data will be reviewed for insights that may help the manufacturing team.

In this statistical analysis, I will conduct the following:
- Perform multiple linear regression analysis to identify which variables in the dataset predict the mpg of MechaCar prototypes
- Collect summary statistics on the pounds per square inch (PSI) of the suspension coils from the manufacturing lots
- Run T-Tests to determine if the manufacturing lots are statistically different from the mean population
- Design a statistical study to compare the vehicle performance of the MechaCar vehicles against vehicles from other manufacturers

## Linear Regression to Predict MPG

The `MechaCar_mpg.csv` dataset holds the results of the 50 newest prototype MechaCars. The following metrics are `vehicle_length`, `vehicle_length`, `spoiler_angle`, `ground_clearance`, `AWD`, and `mpg`. A linear model that predicts the mpg of the MechaCar prototypes is created.

### Load Data
Multiple linear regression is created from the `MechaCar_mpg.csv` dataset to predict the `mpg`:
``` r
mecha_table <-
  read.csv("MechaCar_mpg.csv",
    check.names = FALSE,
    stringsAsFactors = FALSE
  )
head(mecha_table)
#>   vehicle_length vehicle_weight spoiler_angle ground_clearance AWD      mpg
#> 1       14.69710       6407.946      48.78998         14.64098   1 49.04918
#> 2       12.53421       5182.081      90.00000         14.36668   1 36.76606
#> 3       20.00000       8337.981      78.63232         12.25371   0 80.00000
#> 4       13.42849       9419.671      55.93903         12.98936   1 18.94149
#> 5       15.44998       3772.667      26.12816         15.10396   1 63.82457
#> 6       14.45357       7286.595      30.58568         13.10695   0 48.54268
```

### Multiple Linear Regression Model
To predict the miles per gallon `mpg` dependent variable, I added other variables of interest `vehicle_length`, `vehicle_weight`, `spoiler_angle`, `ground_clearance`, and `AWD` as independent variables to fit the multiple linear regression model:

``` r
mecha_model <-
  lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,
    data = mecha_table
  )
mecha_model
#>
#> Call:
#> lm(formula = mpg ~ vehicle_length + vehicle_weight + spoiler_angle +
#>     ground_clearance + AWD, data = mecha_table)
#>
#> Coefficients:
#>      (Intercept)    vehicle_length    vehicle_weight     spoiler_angle  
#>       -1.040e+02         6.267e+00         1.245e-03         6.877e-02  
#> ground_clearance               AWD  
#>        3.546e+00        -3.411e+00
```

### Summary of Model
Since the multiple linear regression model is created, I obtained the statistical metrics using the `summary()` function:
```r
summary(mecha_model)
#>
#> Call:
#> lm(formula = mpg ~ vehicle_length + vehicle_weight + spoiler_angle +
#>     ground_clearance + AWD, data = mecha_table)
#>
#> Residuals:
#>      Min       1Q   Median       3Q      Max
#> -19.4701  -4.4994  -0.0692   5.4433  18.5849
#>
#> Coefficients:
#>                    Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)      -1.040e+02  1.585e+01  -6.559 5.08e-08 ***
#> vehicle_length    6.267e+00  6.553e-01   9.563 2.60e-12 ***
#> vehicle_weight    1.245e-03  6.890e-04   1.807   0.0776 .  
#> spoiler_angle     6.877e-02  6.653e-02   1.034   0.3069    
#> ground_clearance  3.546e+00  5.412e-01   6.551 5.21e-08 ***
#> AWD              -3.411e+00  2.535e+00  -1.346   0.1852    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#>
#> Residual standard error: 8.774 on 44 degrees of freedom
#> Multiple R-squared:  0.7149, Adjusted R-squared:  0.6825
#> F-statistic: 22.07 on 5 and 44 DF,  p-value: 5.35e-11
```

According to the results, `vehicle_length` and `ground_clearance` are statistically unlikely to provide random amounts of variance to the linear model. In other words, `vehicle_length` and `ground_clearance` have a significant relationship with the response variable (`mpg`) since their P-values are less than 0.05.
  - P-value for the predictor variable `vehicle_length`: `2.60e-12`
  - P-value for the predicator variable `ground_clearance`: `5.21e-08`

The p-value (`5.35e-11`) is considered highly significant since it is less than the significance level of 0.05. The slope of the linear model is not considered to be zero because there is sufficient evidence to reject the null hypothesis.

The R-squared value of the model is `0.7149`, which indicates the predictors explain 71.5% of the variability in `mpg`. This linear model is about ~70% accurate in predicting the mpg of MehcaCar prototypes within this specific dataset.
