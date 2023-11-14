install.packages("arules")
library(arules)

# Import dataset
gro <- read.csv(file.choose(), header = TRUE, colClasses = "factor")
View(gro)

# check for inconsistent data
str(gro)

# check for missing data
sum(is.na(gro))

# We do not want to find relationships when items are not purchased. So, any value of 0 will
# be removed
gro[gro == 0] <- NA
View(gro)

# Now we want to remove receipt id attribute
groc <- gro[,-1]
View(groc)

# Now that the data preparation is complete we can generate association rules
rules0 <- apriori(groc, parameter = list(minlen = 2, supp = .2, conf = .8))
inspect(rules0)

# No rules in previous ARM model, so lets reduce support and confidence interval
rules1 <- apriori(groc, parameter = list(minlen = 2, supp = .1, conf = .1))
inspect(rules1)

# Previous ARM model had too many rules, let's filter for the stringer rules
rules2 <- apriori(groc, parameter = list(minlen = 2, supp = .15, conf = .5))
inspect(rules2)

# Still too many rules, lets find stronger confidence
rules3 <- apriori(groc, parameter = list(minlen = 2, supp = .15, conf = .5))
inspect(rules3)

# Let's visualize our rules to see which are the most important
plot(rules3)
plot(rules3, method = "grouped")
plot(rules3, method = "graph")
plot(rules3, method = "paracoord")
