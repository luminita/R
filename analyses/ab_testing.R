## Documentation: http://www.marketingdistillery.com/2014/08/03/ab-tests-in-marketing-sample-size-and-significance-using-r/


## 1. Testing proportions (conversion rate, click through rate etc)
# Assumptions: independence of groups  
# Null hypothesis: proportions are equal in both groups 

# 1.1 Using the standard R package 
# Calculate the needed sample size in order to see a given effect 
# p1 is the known effect, and p2 is the smallest effect you want to see 
power.prop.test(p1=0.5, p2=0.6, sig.level=0.05, power=0.9)

# Calculate the effect you can see with a given sample size 
power.prop.test(n=1000, p1=0.5, sig.level=0.05, power=0.9)

# Once you performed the experiment, to check the proportions 
# if p < 0.05 we can reject the hypothesis that the two proportions are equal 
a <- c(80, 32)
b <- c(1000, 300)
prop.test(a, b, conf.level = 0.95)

# 1.2 Use the package pwr used to compute the power of tests 
install.packages("pwr")
library(pwr)
# the parameter passed as null is calculated from the others 
# h=0.2 is small, h=0.5 is medium, h=0.8 is big effect
pwr.2p2n.test(h=0.2, n1=1000, n2=NULL, sig.level=0.01, power=0.9)


## 2. Testing means (time spent on page,  etc)
# Use some version of unpaired t test, preferably the Welch test which 
# can be used with unequal sample sizes and unequal variances 

# get the sample size 
pwr.t2n.test(n1=100, d=0.4, sig.level=0.01, power=0.8)

# once you performed the experiment, you can run a t test to see 
# if you obtained a statistical significant result 
s1 = rnorm(100)
s2 = rnorm(20, 0.01, 2)
t.test(s1, s2)
