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
