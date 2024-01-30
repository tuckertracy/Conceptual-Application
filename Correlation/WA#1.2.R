install.packages("corrplot")
library(corrplot)

#Finds the location of the null values in the dataset
apply(is.na(BostonHousing), 2, which)

#Replaces the missing values in BostonHousing$MEDV with the mean of the values
#in BostonHousing$MEDV
BostonHousing$MEDV[is.na(BostonHousing$MEDV)] <- mean(BostonHousing$MEDV, na.rm = TRUE)
is.na(BostonHousing$MEDV)

#Rounds inconsistent data in CHAS attribute
BostonHousing$CHAS <- round(BostonHousing$CHAS)
BostonHousing$CHAS

#Creates a correlation matrix of pearson correlation coefficients 
bstn_corr_p <- cor(BostonHousing, method = "pearson")
View(bstn_corr_p)

#Generates a visualization of the correlation matrix
corrplot(bstn_corr_p, method = 'color')

#Reduces the data to the significant correlations
sig_att <- BostonHousing[c(5:9,11:14)]

#Generates correlation matrix
sig_att_corr <- cor(sig_att, method = 'pearson')

#Visualizes correlation matrix
corrplot(sig_att_corr, method = 'number')

#Function for creating histograms
create_histogram <- function(x) {
  
  #Creates the histogram
  new_histogram <- ggplot(BostonHousing,aes(x=x)) + geom_histogram()
  
  #Returns the histogram
  return(new_histogram)
}


#Produces histograms to check for outliers in each attribute
apply(X=BostonHousing,
      FUN = create_histogram,
      MARGIN = 2)










#Function for returning the outliers
the_outliers <- function(x) {
  
  #Finds the outliers
  outliers <- boxplot.stats(x)$out
  
  #Returns the outliers
  return(outliers)
}

#Returns the outliers for all attributes
apply(X = BostonHousing,
      FUN = the_outliers,
      MARGIN = 2)

#function that removes outliers from a data frame
remove_outliers <- function(data) {
  
  #obtains the first quartile
  q1 <- quantile(data,probs = .25)
  
  #obtains the 3rd quartile
  q3 <- quantile(data,probs = .75)
  
  #calculates the inter quratile range
  iqr <- q3-q1
  
  #return true if the value is an outlier
  detect <- data > q3+1.5*iqr | data < q1-1.5*iqr
  
  #updates data frame with no outliers
  new_data <- subset(data,
                 data<q3 & data>q1)
  
  #return the data frame
  return(new_data)
}



#Removes outliers from all attributes
crim_no_out <- remove_outliers(BostonHousing$CRIM)
zn_no_out <- remove_outliers(BostonHousing$ZN)
indus_no_out <- remove_outliers(BostonHousing$INDUS)
chas_no_out <- BostonHousing$CHAS
nox_no_out <- remove_outliers(BostonHousing$NOX)
rm_no_out <- remove_outliers(BostonHousing$RM)
age_no_out <- remove_outliers(BostonHousing$AGE)
dis_no_out <- remove_outliers(BostonHousing$DIS)
rad_no_out <- remove_outliers(BostonHousing$RAD)
tax_no_out <- remove_outliers(BostonHousing$TAX)
ptratio_no_out <- remove_outliers(BostonHousing$PTRATIO)
b_no_out <- remove_outliers(BostonHousing$B)
lstat_no_out <- remove_outliers(BostonHousing$LSTAT)
medv_no_out <- remove_outliers(BostonHousing$MEDV)
