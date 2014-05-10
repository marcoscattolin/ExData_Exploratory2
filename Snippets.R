library(lattice)

#convert Month from Numeric to factor
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data=airquality, layout=c(5,1))


mtcars <- transform(mtcars, am = factor(am, labels=c("Manual","Automatic")))
mtcars <- transform(mtcars, cyl = factor(cyl))
attach(mtcars)
xyplot(wt ~ qsec | cyl*am, data=mtcars, panel= function(x,y,...){
  panel.xyplot(x,y, ...)
  panel.lmline(x,y,lty=2)
})



library(ggplot2)
#hist
qplot(hwy, data=mpg, facets = .~drv, binwidth=2)
qplot(hwy, data=mpg, facets = drv~., binwidth=2)
qplot(hwy, data = mpg, fill=drv)
qplot(hwy, data = mpg, geom = "density", color=drv)

#scatter
qplot(displ, hwy, data=mpg, col = drv)
qplot(displ, hwy, data=mpg, shape = drv)

#scatter with smooth and linear regression lines
qplot(displ, hwy, data=mpg, col = drv, geom=c("point","smooth"))
qplot(displ, hwy, data=mpg, col = drv, geom=c("point","smooth"), method="lm")
qplot(displ, hwy, data=mpg, col = drv, geom=c("point","smooth"), method="lm", facets = .~drv)

#----------add complexity step by step
g <- ggplot(mpg, aes(displ, hwy))   #define reference data and data to be plotted
print(g)    #gives an error, plot is void

g <- g + geom_point() #specify points shall be used
print(g) 

g <- g + geom_smooth(method="lm") #specify points shall be used
print(g) 

g <- g + facet_grid(.~drv) #specify points shall be used
print(g)

#specify color variability
g <- ggplot(mpg, aes(displ, hwy)) 
g <- g + geom_point(aes(color = drv), size = 4, alpha = 1/1.5)
print(g)

#define X label with math notation
g <- g + labs(x = expression("log "*X[2]))
print(g)

g <- geom_smooth(size=4, linetype=3, method = "lm", se = FALSE)
print(g)

#smooth scatterplot
x <- rnorm(10000)
y <- rnorm(10000)
smoothScatter(x,y)


