library(tidyverse)
library(dplyr)
library(ggplot2)
library(MASS)
library(gbm)
library(matlab)

df<-read.csv('work/derived_data/clean.csv')
df_pca<-data.frame(df[4:25])
df_pca <- as.data.frame(sapply(df_pca, as.numeric))
df_pca[1:18]<- as.data.frame(sapply(df_pca[1:18], scale))

#PCA: Appears that the majority of variance is explained by first 2 PCs
pca_result<-prcomp(df_pca)
pca_result
imagesc(pca_result$x)
prop_var <- (pca_result$sdev^2) / sum(pca_result$sdev^2)
prop_var_df<-data.frame(1:22, prop_var)
colnames(prop_var_df)<-c("PC", "Proportion")
prop_plot<-ggplot(prop_var_df, aes(x=PC, y=Proportion))+
      geom_col()+
      labs(title="Proportion of Variance")
ggsave("work/figures/prop_plot.png",plot=prop_plot)

#Plot: REFF has a strong negative correlation along PC1, while the 3P 
#variables seem to be those weighted most along PC2 (positive association) 
#based on review of the loadings. Plotting HOF status (final plot) suggests that 
#there may be a weak association with HOF status and PC1 in particular, in which
#REFF had the strongest (negative) association.
pca_result
biplot(pca_result)
PC1 <- pca_result$x[, 1]
PC2 <- pca_result$x[, 2]
df_plot<-data.frame(PC1, PC2)
HOFbiplot<-ggplot(df_plot, aes(PC1, PC2)) +
  geom_point(aes(color=factor(df$HOF)), alpha=0.5)

ggsave("work/figures/HOFbiplot.png",plot=HOFbiplot)

png("work/figures/biplot_total.png")
biplot(pca_result, dpi=1200)
dev.off()


