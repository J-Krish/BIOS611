library(tidyverse)
library(dplyr)
library(stringi)

df_rookie<-read.csv('derived_data/clean.csv')
df_adv<-read.csv('source_data/Advanced.csv')
colnames(df_adv)[colnames(df_adv)=="player"]<-"Name"
colnames(df_adv)[colnames(df_adv)=="season"]<-"Year.Drafted"
df_adv$Year.Drafted<-df_adv$Year.Drafted-1
df_rookie <- df_rookie %>%
  mutate(Name_lower = tolower(Name)) %>% mutate(Name_clean=stri_trans_general(Name_lower,"Latin-ASCII"))
df_adv <-df_adv %>%
  mutate(Name_lower = tolower(Name)) %>% mutate(Name_clean=stri_trans_general(Name_lower,"Latin-ASCII"))

#Keep rookie year data only
min_df_adv <- df_adv %>% filter(experience==1)

#For players who were traded multiple times their rookie year, keep row with 
#highest minutes played
dedup_min_df_adv<- min_df_adv %>% 
  arrange(player_id, desc(mp)) %>% 
  distinct(player_id, .keep_all = TRUE)

#Join
df_work<- df_rookie %>% left_join(dedup_min_df_adv, by=c("Name_clean", "Year.Drafted"))
                                  
#Choose final columns
column_names <- names(df_work)
column_indices <- seq_along(column_names)
column_info <- data.frame(Column_Name = column_names, Column_Index = column_indices)
column_info
df_final <-c(df_work[1:25], df_work[31:36], df_work[40:58])
df_final<-data.frame(df_final)

#Review missing data. 39 were missing advanced stats, generally due to 
#differing names between datasets (ex. Charles Whitney is also known as
#Hawkeye Whitney; Peter versus Pete; etc.). Given small number and none were
#Hall of Famers, will exclude.
missing<- df_final %>% filter(is.na(vorp))
df_final_1<- df_final[!is.na(df_final$vorp),]

write_csv(df_final_1, "derived_data/merged.csv")
