library(MASS)
library(nnet)
library(dplyr)
library(rpart)

results <- read.csv("~/Desktop/BUS 380/Project Data/results.csv", header = TRUE, stringsAsFactors = TRUE)
constructors <- read.csv("~/Desktop/BUS 380/Project Data/constructors.csv", header = TRUE, stringsAsFactors = TRUE)
drivers <- read.csv("~/Desktop/BUS 380/Project Data/drivers.csv", header = TRUE, stringsAsFactors = TRUE)
races <- read.csv("~/Desktop/BUS 380/Project Data/races.csv", header = TRUE, stringsAsFactors = TRUE)
circuits <- read.csv("~/Desktop/BUS 380/Project Data/circuits.csv", header = TRUE, stringsAsFactors = TRUE)
status <- read.csv("~/Desktop/BUS 380/Project Data/status.csv", header = TRUE, stringsAsFactors = TRUE)
pits <- read.csv("~/Desktop/BUS 380/Project Data/pit_stops.csv", header = TRUE, stringsAsFactors = TRUE)

# Merge datasets by Id columns
data0 <- merge(results,constructors,by = "constructorId")
data1 <- merge(data0, drivers, by = "driverId")
data2 <- merge(data1, races, by = "raceId")


# Remove Url links
data3 <- data2[c(1:37)]
data4 <- data3[c(-23,-31)]


# Remove url links and merge by Id
data5 <- merge(data4, circuits, by = "circuitId")
data6 <- data5[-43]

colnames(data6)
# Merge again
#data7 <- merge(data6, status, by = "statusId")
#data8 <- merge(data7, pits, by = "driverId")

# Removes ID columns, 'number.x', 'number.y', 'positionText','time.x', 'name.y', 'constructorRef',
# 'circuitRef'
dataTest <- data6[c(-1:-6,-10,-11,-14,-20,-25,-26,-33)]

# Change column name of 'milliseconds' to 'minutes'
colnames(dataTest)
View(dataTest)
colnames(dataTest)[c(6,12,13,18,22)] <- c("minutes","constructor_name","constructor_nationality",
                                       "driver_nationality","circuit_time")
colnames(dataTest)

# Multiply milliseconds column by conversion factor to minutes
dataTest$minutes <- as.numeric(as.character(dataTest$minutes))
dataTest$minutes <- dataTest$minutes*0.00001666667
#dataTest$pit_time <- as.numeric(as.character(dataTest$pit_time))
#dataTest$pit_time <- dataTest$pit_time*0.00001666667

# Change missing values in minutes to 0
dataTest$minutes[is.na(dataTest$minutes)] <- 0
#dataTest$pit_time[is.na(dataTest$pit_time)] <- 0

# Change fastestLapSpeed to numeric
dataTest$fastestLapSpeed <- as.numeric(as.character(dataTest$fastestLapSpeed))
dataTest$fastestLapSpeed[is.na(dataTest$fastestLapSpeed)] <- 0
View(dataTest)

# Remove entries where grid is zero
dataTest0 <- dataTest[dataTest$grid != 0,]
colnames(dataTest0)

# Check for other missing values
nas <- apply(dataTest, 2, is.na)
apply(nas, 2, sum)

# Detect Outliers
detect_outliers <- function(x) {
  Q1 = quantile(x, probs=.25)
  Q3 = quantile(x, probs=.75)
  IQR = Q3 - Q1
  x > Q3 + (IQR*1.5) | x < Q1 - (IQR*1.5)
}

remove_outliers <- function(data, columns = colnames(data)) {
  for(x in columns) {
    data <- data[!detect_outliers(data[[x]]),]
  }
  return(data)
}

# Copy data
dataTesty <- dataTest0
View(dataTesty)

# Remove outliers
noOutData0 <- remove_outliers(dataTesty,c("minutes"))
View(noOutData0)

# Create sample of data
set.seed(17)
sample <- noOutData0[sample(nrow(noOutData0), nrow(noOutData0)*.75),]
nrow(sample)
View(sample)

# Create test data set
set.seed(115)
test <- noOutData0[sample(nrow(noOutData0), nrow(noOutData0)*.25),]
nrow(test)

# First version of log model
logmodel0 <- glm(data = sample, Finished ~ minutes + lat + lng + year + laps + grid + 
                  round + fastestLapSpeed, family = binomial())
summary(logmodel0)

# First version of log model, remove 'stop', 'fastestLapSpeed', 'pit_time' because it is not predicitve
logmodel1 <- glm(data = sample, Finished ~ minutes + lat + lng + laps + grid + 
                   round + fastestLapSpeed, family = binomial())
summary(logmodel1)

logpredict <- predict(logmodel1,test,type = 'response')
predictions <- data.frame(logpredict,test)
View(predictions)
write.csv(predictions,file = "log_predictions.csv")
list <- predictions[predictions$minutes != 0,]
colnames(list)
newlist <- list[c(1,2,6,7,11,21,28,29)]
View(newlist)
newlist[order(-newlist$logpredict) & newlist$fastestLapSpeed!= 0,]
# First neural net
set.seed(117)

# Make position a factor
str(sample)

neuralnet <- nnet(position ~ grid + laps + minutes + fastestLapSpeed 
                  + constructor_nationality +  driver_nationality + round + country 
                  + name + circuit_time,
                      data=sample, size=2, maxit=10000)

# make predictions
nnetpredict <- predict(neuralnet,test, type = 'class')
nnetpredictions <- data.frame(nnetpredict,test)
View(nnetpredictions)
write.csv(nnetpredictions,file = "nnet_predictions.csv")

library(ggplot2)

# Plot predicted vs. actual class labels
nnet_predictions <- read.csv("~/Desktop/nnet_predictions.csv",header = TRUE)
View(nnet_predictions)
ggplot(nnet_predictions, aes(x = nnetpredict, y = position)) + 
  geom_point() +
  labs(x = "Actual Position", y = "Predicted Position")

# Plots predicted values
ggplot(nnet_predictions, aes(x = nnetpredict)) + 
  geom_bar(stat = "count")

# Plots actual values
ggplot(nnet_predictions, aes(x = position)) + 
  geom_bar()

# Create copy
copy <- nnet_predictions
add_points <- copy%>%
  mutate(pred_points = case_when(nnetpredict == 1 ~ 25,
                                 nnetpredict == 2 ~ 18,
                                 nnetpredict == 3 ~ 15,
                                 nnetpredict == 4 ~ 12,
                                 nnetpredict == 5 ~ 10,
                                 nnetpredict == 6 ~ 8,
                                 nnetpredict == 7 ~ 6,
                                 nnetpredict == 8 ~ 4,
                                 nnetpredict == 9 ~ 2,
                                 nnetpredict == 10 ~ 1,
                                 nnetpredict > 10 ~ 0))
add_points$pred_points[is.na(add_points$pred_points)]<-0
View(add_points)

# Aggregations
constructor_points <- add_points %>%
  group_by(constructor_name) %>%
  summarise(sum(pred_points)) %>%
  top_n(10)

cf <- as.data.frame(constructor_points)
cf[order(-cf$`sum(pred_points)`),]

driver_points <- add_points %>%
  group_by(driverRef) %>%
  summarise(sum(pred_points)) %>%
  top_n(10)
driver_points
df <- as.data.frame(driver_points)
df[order(-df$`sum(pred_points)`),]

