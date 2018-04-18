# following http://www.statmethods.net/graphs/scatterplot.html

library(car)
scatterplot.matrix(~mpg+disp+drat+wt|cyl, data=mtcars,
                   main="Three Cylinder Options")

pairs(~mpg+disp+drat+wt,data=mtcars, 
      main="Simple Scatterplot Matrix")