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

