
library(dplyr)

accidents <- read.csv("./Data/accidents.csv", header = T)

accidents_sample <- sample_n(accidents, size = 1000)

accidents_sample$Day_of_Week <- factor(accidents_sample$Day_of_Week)
levels(accidents_sample$Day_of_Week) <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
