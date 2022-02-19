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

## Summary Statistics on Suspension Coils

The MechaCar suspension coils' design specifications state that the suspension coils' variance must not exceed 100 pounds per square inch. Therefore, I analyzed to determine if MechaCar is breaching its design specifications.

### Load Data
I imported the MechaCar suspension coils data from `Suspension_Coil.csv` into `suspension_coil_table`:
```r
suspension_coil_table <-
  read.csv("Suspension_Coil.csv",
    check.names = FALSE,
    stringsAsFactors = FALSE
  )
head(suspension_coil_table)
#>   VehicleID Manufacturing_Lot  PSI
#> 1    V40858              Lot1 1499
#> 2    V40607              Lot1 1500
#> 3    V31443              Lot1 1500
#> 4     V6004              Lot1 1500
#> 5     V7000              Lot1 1501
#> 6    V17344              Lot1 1501
```

### Manufacturing Lot Statistics
I created a summary table to determine the mean, median, variance, and standard deviation of the PSI within the `Manufacturing_Lot` as a whole:
```r
total_summary <-
  suspension_coil_table %>% summarise(
    mean = mean(PSI),
    median = median(PSI),
    variance = var(PSI),
    sd = sd(PSI)
  )  
#>      mean median variance       sd
#> 1 1498.78   1500 62.29356 7.892627
```

### Manufacturing Lot (Individual) Statistics
I created a second summary table by grouping each `Manufacturing_Lot` to determine the mean, median, variance, and standard deviation PSI values within the three different lots:
```r
lot_summary <- suspension_coil_table %>%
  group_by(Manufacturing_Lot) %>%
  summarise(
    mean = mean(PSI),
    median = median(PSI),
    variance = var(PSI),
    sd = sd(PSI)
  )  
#>   Manufacturing_Lot    mean median    variance         sd
#> 1              Lot1 1500.00 1500.0   0.9795918  0.9897433
#> 2              Lot2 1500.20 1500.0   7.4693878  2.7330181
#> 3              Lot3 1496.14 1498.5 170.2861224 13.0493725
```
### Results
Analyzing the first summary table (`total_summary`) indicates the suspension coil manufacturing of all the lots as a whole meets the design specifications since the variance is `62.29356` and does not exceed the 100 PSI.

However, when looking at each lot individually, it is evident that `Lot1` and `Lot2` can pass the design specification since each lot has a PSI variance value of `0.9795918` and `7.4693878`, which does not exceed 100 pounds per square inch limit. But, the suspension coils in `Lot3` have a PSI variance value of `170.2861224`, which is far greater than the maximum value limit of 100 PSI.

## T-Tests on Suspension Coils

Multiple T-Tests were conducted using the `t.test()` function to determine if all manufacturing lots and each lot individually are statistically different from the population mean of 1,500 pounds per square inch.

### Manufactoring Lots
```r
t.test(suspension_coil_table %>% pull(name = "PSI"),
  mu = 1500
)
#
#>
#>  One Sample t-test
#>
#> data:  suspension_coil_table %>% pull(name = "PSI")
#> t = -1.8931, df = 149, p-value = 0.06028
#> alternative hypothesis: true mean is not equal to 1500
#> 95 percent confidence interval:
#>  1497.507 1500.053
#> sample estimates:
#> mean of x
#>   1498.78
```
Assuming our significance level is the common 0.05 percent, the p-value (`0.06028`) is greater than the significance level. Therefore, there is not sufficient evidence to reject the null hypothesis, and the PSI across all manufacturing lots is statistically different from the population mean of 1,500 pounds per square inch.



### Lot 1
```r
t.test(
  suspension_coil_table %>% filter(Manufacturing_Lot == "Lot1") %>% pull(name = "PSI"),
  mu = 1500
)
#>
#>  One Sample t-test
#>
#> data:  suspension_coil_table %>% filter(Manufacturing_Lot == "Lot1") %>% pull(name = "PSI")
#> t = 0, df = 49, p-value = 1
#> alternative hypothesis: true mean is not equal to 1500
#> 95 percent confidence interval:
#>  1499.719 1500.281
#> sample estimates:
#> mean of x
#>      1500
```
Assuming our significance level is the common 0.05 percent, the p-value (`1`) is greater than the significance level. Therefore, there is not sufficient evidence to reject the null hypothesis, and the PSI across manufacturing lot 1 is statistically different from the population mean of 1,500 pounds per square inch.



### Lot 2
```r
t.test(
  suspension_coil_table %>% filter(Manufacturing_Lot == "Lot2") %>% pull(name = "PSI"),
  mu = 1500
)
#>
#>  One Sample t-test
#>
#> data:  suspension_coil_table %>% filter(Manufacturing_Lot == "Lot2") %>% pull(name = "PSI")
#> t = 0.51745, df = 49, p-value = 0.6072
#> alternative hypothesis: true mean is not equal to 1500
#> 95 percent confidence interval:
#>  1499.423 1500.977
#> sample estimates:
#> mean of x
#>    1500.2
```
Assuming our significance level is the common 0.05 percent, the p-value (`0.04168`) is lower than the significance level. Therefore, there is sufficient evidence to reject the null hypothesis, and the PSI across manufacturing lot 3 is not statistically different from the population mean of 1,500 pounds per square inch.


### Lot 3
```r
t.test(
  suspension_coil_table %>% filter(Manufacturing_Lot == "Lot3") %>% pull(name = "PSI"),
  mu = 1500
)
#>
#>  One Sample t-test
#>
#> data:  suspension_coil_table %>% filter(Manufacturing_Lot == "Lot3") %>% pull(name = "PSI")
#> t = -2.0916, df = 49, p-value = 0.04168
#> alternative hypothesis: true mean is not equal to 1500
#> 95 percent confidence interval:
#>  1492.431 1499.849
#> sample estimates:
#> mean of x
#>   1496.14
```
Assuming our significance level is the common 0.05 perecent, the p-value (`0.04168`) is lower than the significance level. Therefore, there is sufficient evidence to reject the null hypothesis, and the PSI across manufacturing lot 3 is not statistically different from the population mean of 1,500 pounds per square inch.

## Study Design: MechaCar vs. Competition

A statistical study that can quantify how MechaCars perform against the competition can be conducted by analyzing metrics of interest to a consumer. For instance, metrics of a car cost, fuel efficiency (highway or city), horsepower, maintenance cost, or safety rating can be used. One of the factors that are important to a consumer is the fuel efficiency. The null hypothesis in this study design is that there is a statistical difference between the fuel efficiency between MechaCar vehicles and the competitor. The alternative hypothesis is that there is not a statistical difference between highway fuel efficiency between MechaCar vehicles and the competitor. We can use a paired T-Test since we are pairing observations in one dataset with observations in another. The data that would be needed is the fuel efficiency of both MechaCar and the competitor.

## Resources
- Data Source: [`MechaCar_mpg.csv`](MechaCar_mpg.csv), [`Suspension_Coil.csv`](Suspension_Coil.csv)
- Source Code: [`MechaCarChallenge.R`](MechaCarChallenge.R)
- Software: [`RStudio 2021.09.2+382 "Ghost Orchid" Release`](https://www.rstudio.com/), [`R version 4.1.2 (Bird Hippie)`](https://www.r-project.org/)
- Libraries: [`tidyverse`](https://tidyverse.org), [`dplyr`](https://dplyr.tidyverse.org)
