library(tidyverse)
library(dplyr)

df<-read.csv('source_data/rookie.csv')

#Eval for missing data
col_names<-colnames(df)
m<-data.frame(matrix(ncol=24))
colnames(m)<-col_names
m[1, ]<- df %>% summarize(across(everything(), ~sum(is.na(.))))
m[2, ]<- df %>% summarize(across(everything(), ~sum(.=="")))
m[3, ]<- df %>% summarize(across(everything(), ~sum(.==" ")))
m[4, ]<- df %>% summarize(across(everything(), ~sum(.=="NA")))
m[5, ]<- df %>% summarize(across(everything(), ~sum(.=="-")))
m
df %>% filter(X3P.=="")

#476 missing, all variables consistently missing except for where 
#Hall.of.Fame.Class is missing. Will exclude based on value of one of the 
#other variables.
df %>% filter(is.na(GP))
df1<- df[!is.na(df$GP),]

#10 X3P. are "-". These individuals took 0 3-pointers during their rookie year.
#Will relabel as 0.
df1 %>% filter(X3P.=="-")
df1$X3P. <- as.numeric(sub("-", "0", df1$X3P.))

#Make a new binary variable HOF (1 if HOF, 0 if not). Only 26 individuals with
#HOF status in this dataset.
df1<- df1 %>% mutate(HOF=ifelse(!is.na(Hall.of.Fame.Class), 1, 0))
sum(df$HOF==1)
sum(df$HOF==0)

#Rename variables to indicate rookie year
rookie <- df1 %>% rename_with(~paste0("R", .), GP:EFF)
write_csv(rookie, "derived_data/clean.csv")

