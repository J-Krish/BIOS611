library(tidyverse)
library(dplyr)
library(ggplot2)
library(MASS)
library(gbm)
library(matlab)

#V1: Using traditional count statistics (PTs, RBs, AST, BLK, STL)+exposure (MIN)
#and Year Drafted
df<-read.csv('derived_data/clean.csv')
df_pca<-data.frame(c(df[4],df[6:7], df[19:22]))
df_pca<- as.data.frame(sapply(df_pca, as.numeric))
df_pca<- as.data.frame(sapply(df_pca, scale))

#PCA: Appears that the majority of variance is explained by first 2 PCs
pca_result<-prcomp(df_pca)
pca_result
imagesc(pca_result$x)
prop_var <- (pca_result$sdev^2) / sum(pca_result$sdev^2)
prop_var_df<-data.frame(1:7, prop_var)
colnames(prop_var_df)<-c("PC", "Proportion")
prop_plot<-ggplot(prop_var_df, aes(x=PC, y=Proportion))+
  geom_col()+
  labs(title="Proportion of Variance")
prop_plot
ggsave("figures/prop_plot.png",plot=prop_plot)

#Plot:Plotting HOF status (final plot) suggests that there may be a weak 
#association with HOF status and PC1 in particular. No great clustering effect 
#noted, but there seems to be trends that might be exploitable.
pca_result
biplot(pca_result)
PC1 <- pca_result$x[, 1]
PC2 <- pca_result$x[, 2]
df_plot<-data.frame(PC1, PC2)
HOFbiplot<-ggplot(df_plot, aes(PC1, PC2)) +
  geom_point(aes(color=factor(df$HOF)), alpha=0.5)
HOFbiplot

ggsave("figures/HOFbiplot.png",plot=HOFbiplot)

png("figures/biplot_total.png")
biplot(pca_result, dpi=1200)
dev.off()