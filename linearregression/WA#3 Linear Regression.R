install.packages('tideyverse')
install.packages("ggplot2")
library(tidyverse)
library(ggplot2)

wa3Train <- read.csv(file.choose(), header = TRUE)
wa3Score <- read.csv(file.choose(), header = TRUE)

# Checks to see if the range of values in the scoring data is in the range of values
# in the training data
ranges <- function(data, columns=colnames(data)) {
  for (x in columns) {
    print(x)
    cat("min: ", min(data[[x]]), "\n",sep = " ")
    cat("max: ", max(data[[x]]), "\n",sep = " ")
  }
}

ranges(wa3Train)
ranges(wa3Score)

# Finds the range of each attribute
apply(wa3Train, 2, range)
apply(wa3Score, 2, range)

# Filters scoring data to match ranges in training data
wa3Score0 <- wa3Score%>%
  filter(iq <= 134 & tenure <= 21 & sibs <= 13)

apply(wa3Train, 2, range)
apply(wa3Score0, 2, range)

# Checks for na values
na <- function(x) {
  sum(is.na(x))
}

apply(wa3Train, 2, na)
apply(wa3Score0, 2, na)

# Finds the mean of each column
means <- function(data, columns=colnames(data)) {
  for (x in columns) {
    print(x)
    print(mean(data[[x]]))
  }
}

means(wa3Train)

# Checks for outlier values
boxplot(wa3Train, las = 2)

# Replaces outliers
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

# Checks if outliers were actually replaced
wa3Train0 <- replace_outliers(wa3Train,c("wage","hours","iq","educ","exper","tenure",
                                         "age","sibs"))
wa3Train0[c(1:50),]

# Removes Employee ID because it is not predictive of wages
wa3Train0 <- wa3Train0[,-1]
wa3Train0

# Build initial linear model
model0 <- lm(wage ~ ., data = wa3Train0)
summary(model0)

# Removes age and sibs because they are not predictive of wage
wa3Train0 <- wa3Train0[,c(-7,-10)]
colnames(wa3Train0)
model1 <- lm(wage ~ ., data = wa3Train0)
summary(model1)

# Removes hours because hours is not predictive of wage
wa3Train0 <- wa3Train0[,-2]
colnames(wa3Train0)
model2 <- lm(wage ~ ., data = wa3Train0)
summary(model2)

# Predictions
Predicted_wage <- predict(model2, newdata = wa3Score0)
predictdf <- data.frame(Predicted_wage,wa3Score0)
predictdf <- predictdf[c(2,1,3:11)]
predictdf
View(predictdf)

# Total weekly salary budget
budget <- data.frame("Sum_of_Predicted_Wages" = sum(Predicted_wage))
budget
