install.packages('dplyr')
library(dplyr)
library(nnet)

wa4Train <- read.csv('/Users/bretttracy/Desktop/BUS 380/ISSatisfaction-Training-1.csv', header = TRUE)
wa4Score <- read.csv('/Users/bretttracy/Desktop//BUS 380/ISSatisfaction-Scoring-1.csv', header = TRUE)


View(wa4Train)
View(wa4Score)

# Check for missing values
nas <- apply(wa4Train, 2, is.na)
apply(nas, 2, sum)

# Detect outliers
boxplot_cols <- function(data, cols = colnames(data)) {
  for (x in cols) {
    boxplot(data[[x]], main = x)
  }
}

boxplot_cols(wa4Train)

# Convert the columns to factors to check for inconsistent data
i <- 1
while (i < length(wa4Train)) {
  wa4Train[,i] <- as.factor(wa4Train[,i])
  i <- i + 1
}
wa4Train$Satisfation <- as.factor(wa4Train$Satisfation)
tolower(levels(wa4Train$Satisfation))

# Remove outliers with the means of the column
detect_outliers <- function(x) {
  Q1 <- quantile(x, probs = .25)
  Q3 <- quantile(x, probs = .75)
  IQR <- Q3 - Q1
  x > IQR + (Q3*1.5) | x < IQR - (Q1*1.5)
}

remove_outliers <- function(data, cols=colnames(data)) {
  for (x in cols) {
    print(x)
    print(mean(data[,x]))
    data[detect_outliers(data[[x]]),x] <- mean(data[,x])
  }
  return(data)
}
wa4Train0 <- remove_outliers(wa4Train, c('ICU','IU','IF','ICO','ICR','SyA','SyI','SySc'))
colnames(wa4Train)

boxplot.stats(wa4Train$ICO)$out
boxplot.stats(wa4Train0$ICO)$out


# Set seed to make results reproducible
set.seed(117)

# Change "Satisfation" column to "Satisfaction"
colnames(wa4Train0)[32] <- "Satisfaction"

# Change all entries to lower case
wa4Train0$Satisfaction <- tolower(wa4Train0$Satisfaction)

# Change entry values
wa4Train0$Satisfaction[wa4Train0$Satisfaction=="somehow satisfied"] <- 'somewhat satisfied'
wa4Train0$Satisfaction[wa4Train0$Satisfaction=="somehow distatsified"] <- 'somewhat dissatisfied'

# Change chr to Factor
wa4Train1 <- as.data.frame(unclass(wa4Train0),                    
                           stringsAsFactors = TRUE)
# Remove ID column
wa4Train1 <- wa4Train1[-1]

# Build Neural Net Model
wa4NeuralNet <- nnet(Satisfaction~.,
                      data=wa4Train1, size=5, maxit=10000)

# Apply the model to our scoring dataset.
wa4Predictions <- predict(wa4NeuralNet, wa4Score, type="class")

# Combine predictions to the scoring dataset
wa4Results <- data.frame(wa4Predictions, wa4Score)
wa4Results <- wa4Results[c(2,1, 3:32)]

# Filter for dissatisfied customers
wa4Results <- wa4Results%>%
  filter(wa4Results$wa4Predictions=='dissatisfied')
View(wa4Results)
head(wa4Results)

ReviewList <- wa4Results[c(1,2)]
head(ReviewList)
