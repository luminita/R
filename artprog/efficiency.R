# Tricks to make R code more effective 

## Vectorization (a function is applied to each element of a vector individually)
x<-1:4
y<-3:6
x>y # this is vectorized 
# Note 1: R functions that use vectorized operations are also vectorized!
# Note 2: ifelse if vectorized!

## cbind and rbind are often not efficient (it recreates the matrix)

##