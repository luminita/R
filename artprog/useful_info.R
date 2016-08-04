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

## 3. Matrices and arrays 
# matrices are vectors with two attributes: number of rows and number of columns 
# matrices are stored in column-major order
# example: generate a covariance matrix of size n with correlation rho between variables
makecov <- function(n, rho) {
  res <- matrix(nrow=n, ncol=n)
  res <- ifelse(row(res) == col(res), 1, rho)
  return(res)
}
makecov(3, 0.7)

# matrix has an attribute called dim
x <- matrix(1:8,nrow=4)
class(x)
attributes(x)

# to avoid reducing the dimension of the matrix, you can use the drop argument at slicing 

## 4. Lists 
# lists are equivalent of python dictionaries 
# how to access elements in a list 
x<-list(name="John", salary=30000, union=T)
x$name

x[["name"]]
x[[1]]

# ! If single brackets are used, then the result is another list! -> you can do slicing 
x[1]

# to delete an element just make it NULL
x$union<-NULL
x

# lapply applies a function to each of the components of a list and returns a list 
# sapply simplifies the result to a vector or a matrix 
x<-list(1:10, 1:20)
lapply(x, median)
sapply(x, median)

# you can index using a vector 
x<-list(name="John", salary=30000, union=T)
x[c("name", "salary")]

# order returns the indices of a sorted vector wrt the original vector 
y<-c(7, 1, 9)
order(y)

# interesting example of using lapply: at which positions in a vector different letters appear
g<-c("F", "M", "M", "F", "F")
indices<-lapply(list(F="F", M="M"), function(gender) which(g==gender))
indices

## 5. Data frames 
kids<-c("kub", "kub2")
ages<-c(1.0, 0.1)
d<-data.frame(kids, ages)
d

# one can use both list and matrix notation for data frames 
d$kids
d[,2]
# return a data frame
d[,2, drop=F]

# you can do joins between data frames using merge 
children<-c("kubulita", "kub", "kub2")
smartness<-c(10, 9, 10)
d2<-data.frame(children, smartness)
d3<-merge(d, d2, by.x="kids", by.y="children")
d3

# how to sort a data frame
indices<-order(d3$ages)
d3[indices,]


## 6. Factors and tables 
# factors are vectors that include levels
fa<-factor(c(11,2,11))
fa
# one can use tapply with factors 
ages<-factor(c("young", "young", "old", "young"))
affil<-factor(c("S", "S", "S", "M"))
income<-c(10, 20, 50, 15)
tapply(income, list(ages, affil), mean)
# get the indices where certain factor values appear
x<-factor(c(1, 2, 3, 1, 2, 3))
split(1:length(x), x)
# table creates contingency tables; there are special functions 
# that can be used on such tables eg dimnames 
table(affil, ages)


## 7. R programming structures 
# to loop over nonvectors 
u<-matrix(c(1,2,3,1,2,4), ncol=2)
v<-matrix(c(8,12,20,15,10,2), ncol=2)
for(m in c("u", "v")) {
  z<-get(m)
  print(lm(z[,2] ~ z[,1]))
}
# if else structures return the last value assigned 
x<-2
y<-if (x==2) x else x+1
# super assignment operator to write to variables at "upper" levels
x<-1
f<-function(a) {
  x<<-a*a
}
f(2)
x
# closure: function that creates a local variable and then creates another function 
# that accesses that variable
counter<-function() {
  i<-0
  f<-function() {
    i<<-i+1
    cat("this counter has value", i, "\n")
  }
  return(f)
}
c1<-counter()
c2<-counter()
c1()
c1()
c2()
c1()
c2()
# quicksort
qs<-function(x) {
  if(length(x) <= 1) return(x)
  pivot<-x[1]
  left<-x[x<=pivot][-1]
  right<-x[x>pivot]
  return(c(qs(left), pivot, qs(right)))
}
# replacement functions: any assignment statement where the left side is not 
# an identifier
# what exactly happens below is x<-"names<-"(x, value=c("a", "b", "ab"))
x<-c(1,2,3)
names(x)<-c("one", "two", "three")
# write your pwn binary operator by writing a function starting and ending wth %%
"%ab%"<-function(a,b) return(a*b)
2 %ab% 4


## 8. Doing math and simulations in R
# min and pmin (pmin does a zip of the arguments, and then the min of each group)
x<-matrix(c(1,5,6,2,4,2, -1, 10, -2), ncol=3)
min(x[,1], x[,2], x[,3])
pmin(x[,1], x[,2], x[,3])
# function minimization, maximization 
f<-function(x) return(x^2-sin(x))
nlm(f, 1)
# differentiation
D(expression(x^2), "x")
f<-function(x) return(x^2-sin(x))
integrate(f,0,1)
# statistics prefixes: d gives density, p gives cumulative function, q quantiles 
# r random numbers 
# how to sort data frames
d<-data.frame(v1=c(2,7,5), v2=c("a", "c", "b"))
sorted_d<-d[order(d$v1),]
# solve system of equations 
a<-matrix(c(1,1,-1,1), nrow=2)
b<-c(2,4)
solve(a, b)
# compute the inverse of a matrix
solve(a)
