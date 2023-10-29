library(tidyverse)
library(dplyr)

df<-read.csv('work/source_data/season.csv')
df_rookie<-read.csv('work/source_data/rookie.csv')

view(df_rookie)

df_work<- df %>% distinct(Player)
