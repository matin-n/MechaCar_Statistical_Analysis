library("dplyr")

# Deliverable 1: Linear Regression to Predict MPG ---------------------------
mecha_table <-
  read.csv("MechaCar_mpg.csv",
    check.names = FALSE,
    stringsAsFactors = FALSE
  ) # import MechaCar_mpg.csv
head(mecha_table)


mecha_model <-
  lm(
    formula = mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,
    data = mecha_table
  ) # fit the linear regression model and save into `mecha_model`
mecha_model # output coefficient for each variable in the linear equation
summary(mecha_model) # generate summary statistics


# Deliverable 2: Create Visualizations for the Trip Analysis ---------------------------
suspension_coil_table <-
  read.csv("Suspension_Coil.csv",
    check.names = FALSE,
    stringsAsFactors = FALSE
  ) # import `Suspension_Coil.csv`
head(suspension_coil_table)


total_summary <-
  suspension_coil_table %>% summarise(
    mean = mean(PSI),
    median = median(PSI),
    variance = var(PSI),
    sd = sd(PSI)
  ) #  get the mean, median, variance, and standard deviation of the suspension coil’s PSI column
print(total_summary)

lot_summary <- suspension_coil_table %>%
  group_by(Manufacturing_Lot) %>%
  summarise(
    mean = mean(PSI),
    median = median(PSI),
    variance = var(PSI),
    sd = sd(PSI)
  ) # group each manufacturing lot by the mean, median, variance, and standard deviation of the suspension coil’s PSI column
print.data.frame(lot_summary)
