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

