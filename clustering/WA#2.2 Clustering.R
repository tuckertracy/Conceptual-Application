install.packages("ggpubr")
install.packages("factoextra")
install.packages("ggplot2")
install.packages("tidyverse")
library(tidyverse)
library(ggpubr)
library(factoextra)
library(ggplot2)



# Clusters on entire dataset #

# Import dataset
hhp <- read.csv(file.choose(), header = TRUE)
View(hhp)
str(hhp)

# converts the sub meter attributes from int to num
# hhp[,6:8] <- apply(hhp[,6:8], 2, function (x) { as.numeric(x)})

# Check for missing value
sum(is.na(hhp))

# Calls boxplot.stats() and summary() on each column in given data frame
out <-function(df) {
  for (x in colnames(df)) {
    print(x)
    print(boxplot.stats(df[[x]]))
   }
}
out(hhp)

# Find outliers to remove
plots <- function (x) {
   ggplot(data=hhp, aes(x=x)) +
      geom_boxplot()
}

apply(hhp, 2, plots)

# create detect outlier and remove outlier function
# Credit: https://www.geeksforgeeks.org/how-to-remove-outliers-from-multiple-columns-in-r-dataframe/
# I changed some structure but the idea is largely from credited website
detect_outliers <- function(x) {
  
  # calculate first quantile
  Quantile1 <- quantile(x, probs=.25)
  
  # calculate third quantile
  Quantile3 <- quantile(x, probs=.75)
  
  # calculate inter quartile range
  IQR = Quantile3-Quantile1
  
  # return true or false
  x > Quantile3 + (IQR*1.5) | x < Quantile1 - (IQR*1.5)
  
}

# have to use double brackets because detect outliers requires direct column access which is 
# accessed through the double brackets
remove_outliers <- function(df, columns=colnames(df)) {
  for (x in columns) {
    df <- df[!detect_outliers(df[[x]]),]
  }
  return(df)
}

# cannot remove outliers from sub meter columns because you cannot scale data that consist of only
# one value. The following commented code can be used as an example
# scale(matrix(30, nrow = 10, ncol = 10))
# scale(matrix(1:10, nrow = 10, ncol = 10))


hhp <- remove_outliers(hhp,c("Global_apparent_power",
                             "Global_active_power",
                             "Global_reactive_power",
                             "Voltage",
                             "Global_intensity"))
hhp

# Understanding the double bracket syntax
# for (x in colnames(hhp)) {
#  print(hhp[[x]])
# }

# Decide optimal number of clusters using elbow method
fviz_nbclust(hhp, kmeans, method = "wss")

# Now there are no missing data or inconsistent data entries, begin clustering
set.seed(1)
hhp_clu <- kmeans(scale(hhp), 6, nstart = 25)

# Creates a data frame displaying the zise of the clusters and the centers of the clusters
attach(hhp_clu)
data.frame(size, centers)

# Creates a data frame that binds the original dataset and the cluster column from 
# the kmeans algorithm
cluster_table <- data.frame(cluster, hhp)
View(cluster_table)

# Visualize the clusters
fviz_cluster(hhp_clu,hhp,geom="point",ellispe.type="convex",ggtheme = theme_bw())






# Clusters based on active power, volatge, and amps #


# Create data frames from original dataset that may be insightful
attach(hhp)
hhp0 <- data.frame(Global_apparent_power,Voltage,Global_intensity)
detach(hhp)

# Decide optimal number of clusters using elbow method
fviz_nbclust(hhp0, kmeans, method = "wss")

# Now there are no missing data or inconsistent data entries, begin clustering
set.seed(123)
hhp0_clu <- kmeans(scale(hhp0), 6, nstart = 25)

# Creates a data frame displaying the zise of the clusters and the centers of the clusters
attach(hhp0_clu)
data.frame(size,centers)
detach(hhp0_clu)
# Creates a data frame that binds the original dataset and the cluster column from 
# the kmeans algorithm
cluster_table0 <- data.frame(cluster, hhp0)
View(cluster_table0)

# Visualize the clusters
fviz_cluster(hhp0_clu,hhp0,geom="point",ellispe.type="convex")






# Clusters on the sub metered appliances #


# Create data frames from original dataset that may be insightful
attach(hhp)
hhp1 <- data.frame(Sub_metering_1, Sub_metering_2,Sub_metering_3)
detach(hhp)

# Decide optimal number of clusters using elbow method
fviz_nbclust(hhp1, kmeans, method = "wss")

# Now there are no missing data or inconsistent data entries, begin clustering
set.seed(935)
hhp1_clu <- kmeans(scale(hhp1), 4, nstart = 25)

# Creates a data frame displaying the zise of the clusters and the centers of the clusters
attach(hhp1_clu)
data.frame(size,centers)

# Creates a data frame that binds the original dataset and the cluster column from 
# the kmeans algorithm
cluster_table1 <- data.frame(cluster, hhp1)
View(cluster_table1)

# Visualize the clusters
fviz_cluster(hhp1_clu,hhp1,geom="point",ellispe.type="convex")
