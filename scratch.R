library(tidyverse)
library(dplyr)

#Eval for missing data
df<-read.csv('work/source_data/NBA.csv')

#Missing data
col_names<-colnames(df)
m<-data.frame(matrix(ncol=24))
colnames(m)<-col_names
m[1, ]<- df %>% summarize(across(everything(), ~sum(is.na(.))))
m[2, ]<- df %>% summarize(across(everything(), ~sum(.=="")))
m[3, ]<- df %>% summarize(across(everything(), ~sum(.==" ")))
m[4, ]<- df %>% summarize(across(everything(), ~sum(.=="NA")))
m[5, ]<- df %>% summarize(across(everything(), ~sum(.=="-")))
m

#Eval for missing data: 476 missing, all variables consistently missing/no
#pattern to missingness. Will exclude.
df %>% filter(is.na(GP))
df1<- df[!is.na(df$GP),]
df %>% tally()
df1 %>% tally()
