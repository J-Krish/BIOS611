library(tidyverse)
library(dplyr)
library(ggplot2)
library(MASS)
library(gbm)
library(matlab)

df<-read.csv('work/derived_data/clean.csv')
df<-data.frame(df[3:25])
ncol(df)

#Classification plots
plot(data.frame(df[2:4], df[23]), pch = 16, cex = 0.5)
plot(data.frame(df[5:7], df[23]), pch = 16, cex = 0.5)
plot(data.frame(df[8:10], df[23]), pch = 16, cex = 0.5)
plot(data.frame(df[11:13], df[23]), pch = 16, cex = 0.5)
plot(data.frame(df[14:16], df[23]), pch = 16, cex = 0.5)
plot(data.frame(df[17:19], df[23]), pch = 16, cex = 0.5)
plot(data.frame(df[20:22], df[23]), pch = 16, cex = 0.5)

#Potentially notable differences: games played (RGP), minutes played (RMIN),
#RFG., RFT., RTOV., REFF
ggplot(df, aes(x=RGP, fill=as.factor(HOF), group=as.factor(HOF)))+
  geom_histogram()+
  labs(title="Histogram of Rookie Games Played by HOF Status")

ggplot(df, aes(x=RMIN, fill=as.factor(HOF), group=as.factor(HOF)))+
  geom_histogram()+
  labs(title="Histogram of Rookie Minutes Played by HOF Status")

ggplot(df, aes(x=REFF, fill=as.factor(HOF), group=as.factor(HOF)))+
  geom_histogram()+
  labs(title="Histogram of Rookie Efficiency by HOF Status")
  