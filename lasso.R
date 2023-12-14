library(tidyverse)
library(dplyr)
library(ggplot2)
library(Matrix)
library(glmnet)
library(caret)
library(dplyr)
library(pROC)
library(knitr)

df<-read.csv('derived_data/training.csv')
test<-read.csv('derived_data/testing.csv')
all<-read.csv('derived_data/merged.csv')

#Cleanup
df$HOF<-as.numeric(df$HOF)
df_model<-as.data.frame(c(df[4:16], df[19:24], df[28], df[32:50]))
df_model<- df_model %>% mutate_all(as.numeric)
matrix<-as.matrix(df_model)

#Lasso
set.seed(123)
lasso<-cv.glmnet(matrix, df$HOF, family=binomial, alpha=1)
optimal<-lasso$lambda.min
best <- glmnet(matrix, df$HOF, family=binomial, alpha = 1, lambda = optimal)
coef(best)
nonzero<- which(coef(best) != 0)
selected<- colnames(df_model)[nonzero-1]

#Logistic Regression
model<-glm(HOF~., df[,c("HOF", selected[1:6])], family="binomial")
summary(model)
output<- capture.output(summary(model))
writeLines(output, "figures/coeftable.txt")

#Model Fitting
predictions<-predict(model, newdata=df, type="response")
roc<-roc(df$HOF, predictions)
auc<-round(auc(roc), 3)
png("figures/fittingROC.png")
plot(roc, main="ROC, Training Data", xlim=c(1.0, 0), width=4)
text(0.5, 0.2, paste("AUC=", auc))
dev.off()

#Model Predictions: Testing Data
predictions<-predict(model, newdata=test, type="response")
roc<-roc(test$HOF, predictions)
auc<-round(auc(roc), 3)
png("figures/predictingROC.png")
plot(roc, main="ROC, Testing Data", xlim=c(1.0, 0), width=4)
text(0.5, 0.2, paste("AUC=", auc))
dev.off()

#Evaluating top predictions across entire dataset
predict_all<-predict(model, newdata=all, type="response")
roc<-roc(all$HOF, predict_all)
auc<-round(auc(roc), 3)
cutoff<-coords(roc, "best")
cutoff1<-capture.output(cutoff)
writeLines(cutoff1, "figures/cutoff.txt")

#F1 Score
Top<- all %>% mutate(pred=predict_all) %>% 
  mutate(HOF_pred=ifelse(pred>cutoff[,1], 1, 0)) %>% 
  select(Name.x, HOF, HOF_pred, pred) %>% arrange(desc(pred))
Top$HOF<- as.factor(Top$HOF)
Top$HOF_pred<- as.factor(Top$HOF_pred)
confusion_matrix <- confusionMatrix(Top$HOF_pred, Top$HOF)
f1_score <- confusion_matrix$byClass["F1"]
outputf1<- capture.output(f1_score)
writeLines(outputf1, "figures/f1score.txt")

#Common sense checks
TP <- Top %>% filter(Top$HOF==1 & Top$HOF_pred==1) %>% tally()
FN <- Top %>% filter(Top$HOF==1 & Top$HOF_pred==0) %>% tally()
FP <- Top %>% filter(Top$HOF==0 & Top$HOF_pred==1) %>% tally()
TN <- Top %>% filter(Top$HOF==0 & Top$HOF_pred==0) %>% tally()
table<-matrix(c(TP, FP, FN, TN), ncol=2, byrow=TRUE)
colnames(table)<-c("HOF", "non-HOF")
rownames(table)<-c("Predicted HOF", "Predicted non-HOF")
twobytwo<- capture.output(table)
writeLines(twobytwo, "figures/2x2.txt")

#Comparing currently active players predicted to by in HOF to those predicted 
#by my model
HOFModel<-Top %>% filter(HOF_pred==1)
HOF_BBRef<-read.csv("source_data/HOF_BBallRef.csv")
final<- HOFModel[HOFModel$Name.x %in% HOF_BBRef$Player, ]
compare <-  capture.output(final)
writeLines(compare, "figures/compare.txt")