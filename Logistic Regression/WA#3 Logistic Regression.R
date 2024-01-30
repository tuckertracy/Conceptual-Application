install.packages('tideyverse')
install.packages("corrplot")
install.packages('car')
library(tidyverse)
library(corrplot)
library(car)


train <- read.csv(file.choose(), header = TRUE)
score <- read.csv(file.choose(), header = TRUE)

# Checks for missing values
na <- function(x) {
  sum(is.na(x))
}

apply(train, 2, na)
apply(score, 2, na)

# Checks for inconsistent entries in binominal attributes 
train1 <- data.frame(as.factor(train0$gender),as.factor(train0$marital),
                     as.factor(train0$active))
str(train1)

score1 <- data.frame(as.factor(score0$gender),as.factor(score0$marital))
str(score1)

# Checks for outiers
boxplot(train$income, las = 2)

# Replaces outliers with average of the attribute
outlier <- function(x) {
  Q1 <- quantile(x, probs=0.25)
  Q3 <- quantile(x, probs=0.75)
  IQR <- Q3- Q1
  x > Q3 + (IQR*1.5) | x < Q1 - (IQR*1.5)
}

replace_outliers <- function(data, columns=colnames(data)) {
  for (x in columns) {
    print(x)
    data[outlier(data[[x]]),x] <- mean(data[[x]])
  }
  print(data)
}

train0 <- replace_outliers(train)

# Checks for range discrepancies
apply(train0, 2, range)
apply(score, 2, range)

# Filters scoring dataset to be within range of training data
score0 <- score%>%
  filter(age >= 21 & age <= 55 & income >= 14 & income <= 82)

apply(train0, 2, range)
apply(score0, 2, range)

# Build intial logistic model
train0 <- train0[,-1]
logmodel <- glm(data = train0, active ~ ., family = binomial())
summary(logmodel)

# Remove marital, bfast, and income from model
names(train0)
train0 <- train0[,c(-3,-4,-6)]
logmodel0 <- glm(data = train0, active ~ ., family = binomial())
summary(logmodel0)

# Checks for multicollinearity
vif(logmodel0)

corr <- cor(train0, method = "pearson" )
View(corr)

corrplot(corr, method = "shade")

# Predictions
predicted <- predict(logmodel0,score0,type = "response")
preddf <- data.frame(predicted,score0)
preddf[c(2,1,3:8)]

# List of individuals likely to adopt an active lifestyle
list <- preddf%>%
  arrange(desc(predicted))%>%
  filter(predicted >= 0.5 & predicted <= 0.65)
list <- list[c(2,1,3:8)]
list
