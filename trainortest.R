library(tidyverse)
library(dplyr)
library(ggplot2)
library(caret)

df<-read.csv('derived_data/merged.csv')

set.seed(123)

index<-createDataPartition(df$HOF, p =0.7, list = FALSE)
training_data <- df[index, ]
testing_data <- df[-index, ]

write_csv(training_data, "derived_data/training.csv")
write_csv(testing_data, "derived_data/testing.csv")
