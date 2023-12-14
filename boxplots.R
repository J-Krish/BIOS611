library(tidyverse)
library(dplyr)
library(ggplot2)
library(gridExtra)

df<- read.csv('derived_data/clean.csv')
df$HOF <- as.factor(df$HOF)
levels(df$HOF) <- c("No", "Yes")
df <- df %>% rename("Games Played"="RGP") %>% rename("Minutes Played"="RMIN") %>%
              rename("Points per Game"="RPTS") %>% 
              rename("Field Goals Made per Game"="RFGM") %>% 
              rename("Field Goal Percentage"="RFG.") %>% 
              rename("3-Pointers Made per Game"="RX3P.Made") %>% 
              rename("3-Pointer Percentage"="RX3P.") %>% 
              rename("Free Throws Made"="RFTM") %>% 
              rename("Free Throw Percentage"="RFT.") %>% 
              rename("Rebounds per Game"="RREB") %>% 
              rename("Assists per Game"="RAST") %>% 
              rename("Steals per Game"="RSTL") %>% 
              rename("Blocks per Game"="RBLK") %>% 
              rename("Turnovers per Game"="RTOV") %>% 
              rename("Efficiency"="REFF")
variables <- c("Games Played", "Minutes Played", "Points per Game", 
               "Field Goals Made per Game", "Field Goal Percentage", 
               "3-Pointers Made per Game", "3-Pointer Percentage", 
               "Free Throws Made", "Free Throw Percentage", "Rebounds per Game",
               "Assists per Game", "Steals per Game", "Blocks per Game", 
               "Turnovers per Game", "Efficiency")
plots<-list()

for (var in variables) {
    plot_data <- data.frame(Category = df$HOF, Values = df[[var]])
    plot<-ggplot(plot_data, aes(x = Category, y = Values, fill = Category)) +
      geom_boxplot(show.legend = FALSE) +
      labs(title = paste(var),
           x = "Hall-of-Fame Status",
           y = var)
    plots[[var]] <- plot
}
plots

exposure<-grid.arrange(grobs=plots[1:2], ncol=2)
aggregate<-grid.arrange(grobs=c(plots[3], plots[10:11]), ncol=3)
aggregate2<-grid.arrange(grobs=plots[12:13], ncol=2)
efficiency<-grid.arrange(grobs=plots[15], ncol=1)
threept<-grid.arrange(grobs=c(plots[6:7]), ncol=2)

ggsave("figures/exposure.png",plot=exposure, height=4, width=8)
ggsave("figures/aggregate.png",plot=aggregate, height=4, width=8)
ggsave("figures/aggregate2.png",plot=aggregate2, height=4, width=8)
ggsave("figures/efficiency.png",plot=efficiency, height=4, width=8)
ggsave("figures/threept.png",plot=threept, height=4, width=8)


