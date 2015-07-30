####################### CHAPTER 3
# working directory 
getwd()
setwd("C:/work/training/other/R")
# save workspace (saved to a file .RData)
save.image()
# command history
history(Inf)
# saves the value of the last evaluated expression
.Last.value
# list of packages currently installed 
library() # OR 
installed.packages()
# list of packages currently loaded into R 
search()
# load a library 
library(nzr)
# returns TRUE if the package could be loaded, FALSE otherwise 
require(nzr)
# unload a package 
detach(package:MASS)
# get help about some builtin dataset 
help(iris)
# see all the datasets 
data(package="MASS")
# install a package from CRAN 
# install.packages("packagename")
# run an R script 
# source("hello.R", echo=TRUE)
# get the R home directory 
Sys.getenv("R_HOME")
# customize R: save a file .Rprofile in Documents
# eg options(prompt="R>")
help(options)


####################### CHAPTER 4: Input and Output 
# 4.1 enter the data manually from keyboard
# a vector 
x <- c(1, 2, 3)
# a data frame 
x <- data.frame(labels=c("Low", "Mid", "High"),
                lbound=c(0, 0.1, 0.2),
                ubound=c(1, 2, 3))
# use an interactive editor 
scores <- data.frame()
scores <- edit(scores)

# 4.2 format your output (total number of significant digits) 
print(pi, digits=2)
cat(format(pi, digits=2), "\n")
x <- c(2.1235, 4.163736, 0.00123)
print(x, digits = 3)
# alter the format of all outputs! 
options(digits=3)

# 4.3 Redirecting output to a file
# use cat 
cat("TEST TEST ", file="C:\\work\\tmp\\test_r.txt")
cat("TEST TEST ", file="C:\\work\\tmp\\test_r.txt", append=TRUE)
# use a connection 
f <- file("C:\\work\\tmp\\test_r.txt", "w")
cat("TEST", "\n", file=f)
cat("TEST2", "\n", file=f)
close(f)
# use sink to redirect all outputs to a file 
sink("C:/work/tmp/test_r.txt")
print(x)
sink()

# 4.4 Listing files 
list.files(recursive=F)
# show hidden files as well 
list.files(all.files=T)

# 4.6 Read fixed-width records
# you need to know the widths of the columns 
# returns a data frame
# use records<-read.fwf("filename", widths=c(w1, w2, ..), col.names=)

# 4.7 Reading tabular data files 
# lines starting with # are ignored, returns a data frame 
dfm <- read.table("C:/work/training/other/R/test_data/test_r_1.txt", stringsAsFactors=FALSE, header=T)
class(dfm)

# 4.8 Read a .csv file 
# returns a data frame
tbl <- read.csv("C:/work/training/other/R/test_data/test_r_2.csv", header=T)
str(tbl)
# do not interpret non numeric as factor 
tbl <- read.csv("C:/work/training/other/R/test_data/test_r_2.csv", header=T, as.is=T)
str(tbl)

# 4.9 write to .csv files 
write.csv(tbl, file="C:/work/tmp/test.csv", row.names=F, col.name=T)
# use write.table if you want something more flexible 

# 4.10 Reading tabular data or CSV data from the web 
# tbl <- read.csv("http://..")

# 4.11 Read data from HTML tables
library(XML)
url <- "http://www.nada.kth.se/~lumi/index.php"
# read all tables 
tbl <- readHTMLTable(url)
# read only one table 
tbl <- readHTMLTable(url, which=3)

# 4.12 Reding files with a complex structure 
# use readLines to read all or a number of lines as character strings
lines <- readLines("C:/work/training/other/R/test_data/test_r_2.csv")
# scan reads one token at a time and returns a list
# useful parameters: n, nlines, skip, na.strings(=what should be interpreted as NA) 
data <- scan("C:/work/training/other/R/test_data/test_r_3.txt", 
            what=list(date=character(0), val1=numeric(0), val2=numeric(0)))

# 4.14 Saving and transporting objects 
# write the objects to a file 
# binary file 
save(data, file="C:/work/tmp/TEST.RData")
data<-1
# loads the data IN THE VARIABLES; returns the list of variables 
z<-load("C:/work/tmp/TEST.RData")

# ASCII file 
dput(data, file="C:/work/tmp/TEST.RData")
dump("data", file="C:/work/tmp/TEST.RData")
z<-source("C:/work/tmp/TEST.RData")


####################### CHAPTER 5: Data structures
## 1. Vectors 
# vectors are homogenous (all elements have the same mode)
v <- c(1, 2, 3)
# vector elements can be indexed by multiple positions 
v[c(1,3)]
# vector elements can have names 
names(v) <- c("One", "Two", "Three")
v["Three"]

## 2. Lists
# lists are heterogenous (elements can have different modes)
l <- list(1, 2, list(1, 2, 3), "Four")
l
# lists are indexed by position using double brackets 
l[[3]][[1]]
# extract sublists 
l[c(1, 4)]
# list elements can have names 
names(l)<-c("Int", "Int", "List", "String") 
l[["Int"]]
l$String

## 3. Scalars
# scalars are vectors of length 1 
x <- 1
x[1]

## 4. Matrices 
# vector with dimensions 
m1 <- 1:8
dim(m1) <- c(2, 4)
m1
m2 <- list("One", "Two", c(1, 2), "Three")
dim(m2) <- c(2, 2)
m2[1, 2][[1]]

## 5. Factors 
# like a vector, each different value is called a level 
# this is basically a categorical variable 
a <- factor(c(1, 2, 1, 1, 2))
a

## 6. Data frames 
# columns are vectors and/or factors and must have names 
d <- data.frame(col1=c(1, 2, 3), col2=factor(c(1, 2, 1)))
# accessing elements using list notation 
d$col1
d[[1]]
d[1]
# accessing elements by using matrix notation 
d[1,]
d[, 1]
d[1, 1]

## 5.1 Appending data to a vector 
v <- 1:10
v <- c(v, 12:20)
v[20] <- 1

## 5.2 Inserting data into a vector 
v <- 10:20
v <- append(v, 1:3, after=4)
v
v <- append(v, 1:3, after=0)
v

## 5.3 Recycling Rule 
# when applying arythmetics for vectors of different lengths 
# R recycles the shorter vector as many times as necessary 
v1 <- c(1, 2, 3, 4, 5, 6)
v2 <- c(10, 11)
v3 <- v1 + v2
v3

# cbind creates column vectors 
c1 <- cbind(1:10, 10:11)
c1

## 5.4 Creating a factor 
# the levels are taken by default from the values; you can also explicitly set them 
f <- factor(c(1, 2, 1, 1), levels=c(1, 2, 3))
f

## 5.5 Combining multiple vectors into one vector and a factor 
# useful for different analyses such as ANOVA
v1 <- c(1, 2, 3, 1)
v2 <- c(2, 1, 2, 1)
v3 <- c(20)
d <- stack(list(v1=v1, v2=v2, v3=v3))
aovan <- aov(values ~ ind, data=d)
aovan

## 5.7-5.8 Accessing elements in lists 
l <- list(one=1, two="Mean", three=c(1, 2))
# get ONE element
class(l[[2]])
# getting ONE element as a list; l[i] ~ l[c(i)]
class(l[2])
# access elements using names 
l[["two"]]
l$three
# this one returns a list 
l[c("one", "three")]

## 5.9 Build a Name/Value Association list 
# alt 1 
names <- c("One", "Two", "Three")
values <- 1:3
l <- list()
l[names] <- values
# alt 2
l <- list()
l$one <- 1
l$two <- 2

## 5.10 Remove an element from a list 
# just assign it null 
l <- list(1, 2, 3, 4)
l[[2]] <- NULL
l[c(1, 2)] <- NULL
l

## 5.11 Flatten a list into a vector 
l <- list(1, 2, 3, 4)
v <- unlist(l)
v

## 5.12-5.13 Removing elements from a list if NULL or according to condition
l <- list(1, 2, 3)
l[[10]] <- 10
l
l[sapply(l, is.null)] <- NULL
l
l <- list(1, 2, 3, 10)
l[l<4] <- NULL
l

## 5.14 Initializing a matrix 
m <- matrix(1:10, 5, 2)
m

## 5.15 Performing matrix operations 
m <- matrix(1:25, 5, 5)
# matrix transposition 
t(m)
# matrix inverse 
solve(m)
# multiplymatrices 
m %*% m
# diagonal matrix 
diag(3)

## 5.16 Row and Column names for matrices 
m <- matrix(1:6, 2, 3)
rownames(m) <- c("Row one", "Row two")
colnames(m) <- c("Col one", "Col two", "Col three")
m
m["Row one", "Col three"]

## 5.17 Select one row or column from a matrix 
# a. Result is a vector 
m[1,]
m[,1]
# b. Result as a matrix
m[1,, drop=FALSE]
m[,1, drop=FALSE]

## 5.18 Initialize a data frame from column data 
c1 <- c(1, 2, 3)
c2 <- c("One", "Two", "Three")
c3 <- factor(c(10, 10, 11))
d1 <- data.frame(c1, c2, c3)
d1
d1 <- data.frame(col1=c1, col2=c2, col3=c3)
d1

## 5.19 Combine one-row data frame in one big data frame
d1 <- data.frame(col1="One", col2=1)
d2 <- data.frame(col1="Two", col2=2)
d3 <- data.frame(col1="Three", col2=3)
do.call(rbind, list(d1, d2, d3))

## 5.20 Append rows to a data frame 
# store the rows as data frames and use rbind to append them 
d1 <- data.frame(col1="One", col2=1)
d2 <- data.frame(col1="Two", col2=2)
d4<-do.call(rbind, list(d1, d2))
d3 <- data.frame(col1="Three", col2=3)
rbind(d4, d3)

## 5.22-5.24 Selecting in data frames 
d <- data.frame(c1=c(1, 2, 3), c2=c("A", "B", "C"))
# a column (result is a vector)
d[[1]]
# returning a data frame 
d[c(1)]
d[2]
# using matrix notation 
# returns a vector 
d[, 1]
# force it to return a data frame 
d[, 1, drop=FALSE]
# returns a data frame 
d[, c(1, 2)]
# use column names 
# return a vector/factor
d[["c1"]]
d$c1
d[, "c1"]
# return a data frame
d["c1"]
d[c("c1", "c2")]
d[, c("c1", "c2")]
# simpler way to select rows and columns 
d2 <- subset(d, select=c1, subset=(c2=="B"))
# more complex example of subset
library(MASS)
x<-subset(Cars93, select=c(Manufacturer, Model),
       subset=(MPG.highway > median(MPG.highway)))

y<-subset(Cars93, select=c(Manufacturer, Model),
          subset=(MPG.highway > median(MPG.highway)))

## 5.25 Change the names of the data frame columns 
m <- matrix(1:20, 5, 4)
d <- as.data.frame(m)
colnames(d) <- c("c1", "c2", "c3", "c4")
d

## 5.26 Edit a data frame 
d <- as.data.frame(matrix(1:20, 5, 4))
temp <- edit(d)
d <- temp

## 5.27 Remove NAs from a data frame 
d <- as.data.frame(matrix(1:20, 5, 4))
d$c4 = c(1, 2, 3, NA, NA)
# removes the ROWs that contain some NA
clean <- na.omit(d) 

## 5.28 Exclude columns by name 
d <- as.data.frame(matrix(1:20, 5, 4))
subset(d, select=c(-V1,-V4))

## 5.29-5.30 Combining data frames 
# use cbind or rbind for combining by column and rows
# to combine by a common column (only rows with a matching value are merged)
d1 <- data.frame(c1=c(1,2,3), c2=c(4, 5, 6))
d2 <- data.frame(c2=c(6, 4, 1), c3=c(7,8,9))
merge(d1, d2, by="c2")

## 5.31 Accessing data frame columns easier 
# note that this is confusing when you use the exposed names for updates, avoid 
# doing that
d1 <- data.frame(c1=c(1,2,3), c2=c(4, 5, 6))
with(d1, c1+c2 - mean(c1))


####################### CHAPTER 6: Data transformations 
## 6.1 Splitting a vector into groups 
# returns a list of vectors, each vector corresponding to a group 
v <- c(1, 2, 3, 4)
f <- factor(c("A", "A", "B", "B"))
groups1<-split(v, f)
# if all the vectors have the same length it returns a data frame 
groups2<-unstack(data.frame(v, f))
class(groups2)

## 6.2 Applying a function to each list element 
l <- list(c(1, 2, 3, 4))
f <- function(x) {return (x+1);}
# lapply returns the result in a list 
# sapply returns the result in a vector, a matrix or a list (depending on 
# what the function returns)
r1 <- lapply(l, f)
r2 <- sapply(l, f)

## 6.3-6.4 Applying a function to every row/column of a matrix or data frame 
m <- matrix(1:6, 3, 2)
d <- data.frame(one=c(1, 2, 3), two=10:12)
rownames(m)<-c("One", "Two", "Three")
colnames(m)<-c("Uno", "Dos")
f <- function(x) {return(sum(x))}
# apply the function to every row of m (this works )
r <- apply(m, 1, f)
r
r <- apply(d, 1, f)
r
# apply the function to every column of a matrix  
c <- apply(m, 2, f)
c
c <- apply(d, 2, f)
c
c <- lapply(d, f)
c
# cool recipe to find the 10 predictors with best correlation with a
# response variable and use them to run linear regression 
# cor is the function applied, y=resp is passed as second argument to the function 
# cors <- sapply(pred, cor, y=resp)
# mask <- (rank(-abs(cors)) <= 10)
# pred <- pred[,mask]
# r <- lm(resp ~ pred)

## 6.5 Apply a function to groups of data 
# you first need to create a grouping factor, then use tapply 
v <- c(1:3, 100:101)
fa <- factor(c("Group1", "Group1", "Group1", "Group2", "Group2"))
tapply(v, fa, sum)
fun <- function(x) {return (c(mean(x), sd(x)))}
tapply(v, fa, fun)

## 6.6 Apply a function to group of rows of rows in a data frame 
# you need to create a factor that groups your rows, then use by 
# note that the paramater of the function is a data frame! 
# (by rearranges data in a data frame)
library(MASS)
by(Aids2, Aids2$sex, summary)

## 6.7 Applying a function to parallel vectors or lists 
v1 <- c(-1, 2, -3)
v2 <- 10:12
fun <- function(x1, x2) {return(x1*x2)}
mapply(fun, v1, v2)


####################### CHAPTER 7: Strings and Dates 
help(DateTimeClasses)
## 7.1-7.7 String operations 
s <- "Lumi"
vs <- c(s, "Mihaela")
# length of a string: nchar. The length function returns the length of a vector! 
nchar(s)
nchar(vs)
# concatenate strings 
paste(vs[1], vs[2], sep=".")
paste(vs, "is", "happy")
paste(vs, "is", "happy", collapse = " and ")
# extract substrings 
substr(s, 1, 2)
substr(vs, 1, 2)
# note that all arguments of substr can be vectors 
substr(vs, c(1, 6), c(2, 8))
# splitting a string 
s <- "Anna is 30 years old"
s2 <- "Mary is young, is she?"
r <- strsplit(c(s, s2), " ")
r
class(r)
# replacing substrings
# first instance 
sub("is","isnt", s2)
# all instances 
gsub("is","isnt", s2)
# generate pairwise combinations of strings as a matrix
# outer calculates outer product, but you can replace multiplication with some 
# other function eg paste; the last parameter is passed to the function 
s1 <- c("A", "B", "C")
s2 <- c("D", "E")
outer(s1, s2, paste, sep="+")

## 7.8 - .. Dates processing 
# current data 
Sys.Date()
# convert string to a date 
as.Date("2012-06-12", format="%Y-%m-%d")
# convert a Date to a string 
format(Sys.Date(), format="%d-%m-%Y")
as.character(Sys.Date())
# create a date from parts (note that the parameters can also be vectors!)
# use IDODatetime if you want to have also time
as.Date(ISOdate(2015, 07, 29))
# get the julian date (number of days since 1.01.1970)
as.integer(Sys.Date())
julian(Sys.Date())
# extract parts of a date 
d<-as.Date("1982-09-18")
p<-as.POSIXlt(d)
p$mday
p$mon # Jan is 0
p$year + 1900
p$wday
# create a sequence of dates 
s<-as.Date("1982-09-18")
e<-as.Date("1983-09-18")
seq(from=s, to=e, by=7)
seq(from=s, to=e, length.out=10)
seq(from=s, to=e, by="month")
seq(from=s, to=e, by="3 months")


####################### CHAPTER 8: Probability
# dnorm: density function
# pnorm: distribution function
# qnorm: quantile function 
# rnorm: random variables 
# help about a distribution 
?Normal
# 8.1 How many combinations of n items taken k at a time (binomial coefficients)  
choose(3, 2)

# 8.2 Generate all combinations of n items taken k at a time 
combn(c("A", "B", "C"), 2)

# 8.3 Generate random numbers 
# uniform between 0 and 1 
runif(5)
# standard normal distribution 
rnorm(5)
rnorm(4, mean=c(1, 20), sd=c(1, 1))

# 8.5 Generate a random sample 
# sample w/wo replacement 
sample(1:10, 5)
sample(1:10, 5, replace=TRUE)
# generate a sequence of Bernoulli trials with p = 0.3
sample(c(TRUE, FALSE), 20, replace=TRUE, prob=c(0.3, 0.7))

# 8.7 Randomly permuting a vector 
sample(1:10)

# 8.8  Calculating probabilities  
# P(X=x) -> use the density function (eg dnorm)
# For P(X<=x) -> use the probability function (eg pnorm) 
dnorm(0.0)
pnorm(0.0)
pnorm(0.5)
# the survival function P(X>x)
pnorm(0.5, lower.tail=FALSE)
# how many data points are within 2 standard deviations from the mean? 
pnorm(2.0) - pnorm(-2.0)

# 8.10 Converting probabilities to quantiles 
# Giving a probability p and a distribution, we want to find out x such as P(X<=x) = p
qnorm(0.97725)
# to check: pnorm(2.0)
# see the extremities of a 95% interval 
qnorm(c(0.025, 0.975))

# 8.11 Plotting a density function 
x <- seq(-3, 3, by=0.01)
fx <- dnorm(x)
plot(x, fx, type='l')
# fill the region for X > 2
region.x <- c(2, x[x>2], 3)
region.y <- c(0, fx[x>2], 0)
polygon(region.x, region.y, density = -1, col="blue")


####################### CHAPTER 9: General Statistics
## 9.1 Summarize data 
v <- 1:11
summary(v)
# The summary of a factor returns counts 
fa <- factor(c(1, 2, 1, 2, 3, 1))
summary(fa)
# The summary of a data frame works by column, and gives counts for factor
# columns and a statistical summary for numeric ones 
d <- data.frame(col1=1:5, col2=c("A", "B", "A", "A", "C"))
summary(d)
# for a list you need to use lapply 
l <- list(c1=1:10, c2=100:110)
lapply(l, summary)

## 9.2 Calculating relative frequencies 
v <- 1:10
mean(v>2)
# fraction of observations that exceed two standard deviations from the mean 
v <- rnorm(100)
mean(abs(v-mean(v)) > 2*sd(v))

## 9.3 Tabulating factors and creating contingency tables 
fa1 <- factor(c("A", "B", "A", "A", "C"))
fa2 <- factor(c("Z", "B", "X", "X", "Z"))
table(fa1, fa2)

## 9.4 Testing categorical variables for independence 
# use a chi-squared test 
fa1 <- factor(c("A", "B", "A", "A", "C", "A", "D", "A"))
fa2 <- factor(c("Z", "B", "X", "X", "Z", "X", "V", "X"))
summary(table(fa1, fa2))

## 9.5 Calculate quantiles 
# find v such as the fraction of observations below v is f
v <- 1:100 
quantile(v, c(0.25, 0.75))
# find quartiles 
quantile(v)

## 9.6 Inverting quantiles 
# given an observation x find its quantile 
v <- 1:100 
x <- 5
mean(v < x)

## 9.7 Normalize data 
v <- 1:100 
z1 <- scale(v)
z2 <- (v - mean(v))/sd(v)

## 9.8 Test the mean of a sample (t test)
# Given a sample, test if the mean can be mu (mu is the null hypothesis)
# !If n<30, this gives meaningful results only if the population is normally distributed
s <- rnorm(100)
t.test(s, mu=1.0)

## 9.9 Calculating a confidence interval for the mean 
# !If n<30, this gives meaningful results only if the population is normally distributed
s <- rnorm(100)
t.test(s)
t.test(s, conf.level=0.99)

## 9.10 Calculating a confidence interval for the median 
s <- rnorm(100)
wilcox.test(s, conf.int=TRUE, conf.level=0.99)

## 9.11 Testing a sample proportion 
# assume that we have a sample of n trials with x successes; we want to test whether 
# the probability of success is p 
prop.test(1000, 1900, 0.51)
# one tailed test 
prop.test(1000, 1900, 0.5, alternative="greater")

## 9.12 Confidence interval for a proportion 
# 1000 successes out of 1900 trials 
prop.test(1000, 1900, conf.level=0.99)

## 9.13 Testing for normality 
# Use the shapiro test; if p<0.05 -> not normally distributed, otherwise is 
s <- rnorm(100)
shapiro.test(s)
s <- rt(1000, 3)

## 9.14 Testing if a sequence of binary values are random 
# done by applying a so-called runs test for randomness 
# if pvalue < 0.05 -> the sequence is probably not random 
v <- factor(sample(c(0, 1), 100, replace=TRUE))
#install.packages("tseries")
library(tseries)
runs.test(v)

## 9.15 Comparing the means of two samples 
# if one the samples has less than 20 data points -> populations must be normally distributed
s1 <- rnorm(100, mean=100, sd=10)
s2 <- rnorm(150, mean=101, sd=15)
t.test(s1, s2, paired=FALSE)

## 9.16 Comparing the locations of two samples non-parametrically 
# Assumption: the two populations have the same shape
s1 <- rpois(100, 5)
s2 <- rpois(150, 6)
wilcox.test(s1, s2, paired=FALSE)

## 9.17 Testing a correlation for significance 
# if p < 0.05, they are most probably correlated 
s1<-rnorm(100)
s2<-s1 + rnorm(100)
# if s1 and s2 come from normally distributed populations  
cor.test(s1, s2)
# if s1 and s2 DID not come from normally distributed populatons
cor.test(s1, s2, method="spearman")

## 9.18 Testing for equal proportions 
# if p < 0.05, they are most probably not equal proportions 
# you can have several groups 
# eg if 3 groups, all with 100 trials but diff number of success 
prop.test(c(45, 49, 77), c(100, 100, 100))

## 9.19 Perform pairwise comparisons between group means 
# giving a list of samples, you want to perform a pairwise comparison between all of them 
# if p<0.05, probably the two groups have different means 
s1 <- rnorm(100)
s2 <- rnorm(50, mean=0.5, sd=3)
s3 <- rnorm(150, mean=0.1, sd=1)
# make a factor to identify the groups
# ugly 
fa <- factor(c(rep(c("A"), length(s1)), 
               rep(c("B"), length(s2)), 
               rep(c("C"), length(s3))))
# elegant 
data <- stack(list(A=s1, B=s2, C=s3))
pairwise.t.test(c(s1, s2, s3), fa)
pairwise.t.test(data$values, data$ind)

## 9.20 Testing if two samples come from the same distribution 
# use a Kolmogorov-Smirnov test (nonparametric)
# if p < 0.05 the two samples are probably drawn from different distributions 
s2 <- rnorm(50, mean=0.2, sd=6)
s3 <- rnorm(150, mean=0.1, sd=10)
ks.test(s2, s3)


