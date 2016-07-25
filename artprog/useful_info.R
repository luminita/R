## 1. Getting started
# data sets in R 
data()
# modulo operator is %% 
3%%2
# a global variable can be written to from within a function using <<-
x<-2
f<-function() x<<-3
f()
x
# you can use mode(x) to see the mode of a variable 
x<-c("abc", "d")
mode(x)
# matrix multiplication operator is %*%
# compact way of printing lists is using str()
hn<-hist(Nile)
str(hn)
# instances of classes in R are usually just list with extra class attributes 
# you can use the options() function to see the different options 
# that you can configure in an .Rprofile file 
# .Rdata stores the data, and .Rhistory stores the command history
# use the example functionto run th eexamples that come in the help
example(persp)
# get help about a package 
help(package=MASS)
# good tips for searching in the end of the book 


## 2. Vectors 
# when using something like 1:length(x), make sure length(x) > 0; better use seq
# matrices are stored BY COLUMN 
# negative subscripts exclude elements 
x<-c(1, 7, 9)
x[-1]
# use seq instead of length
x<-c(12, 13, 14, 15)
for (i in seq(x)) print(i)
# NA:unknown and NULL:nonexistent
# filtering: make elements > 3 equal to 0 
x <- 1:10
x[x > 3] <- 0
x
# filtering can be done with subset in which case NA are treated differently 
# find indexes at which a condition is true 
x <- 1:10
which(x > 3)





