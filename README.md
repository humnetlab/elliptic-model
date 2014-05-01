The code implements the elliptic model for social fluxes as presented in 

[The elliptic model for communication fluxes, Herrera-Yagüe et al](http://dx.doi.org/10.1088/1742-5468/2014/04/P04022)

![explanatory diagram](http://i.imgur.com/EvUkNZp.png)


General syntax 

Fluxes = elliptic_model(lat, lng, pop, FLEX=0, option="ellipse", totalSum=1)

* __lat__ is a 1-D vector containing latitudes of locations
* __lng__ is a 1-D vector containing longitudes of locations
* __pop__ is a 1-D vector containing the population of each location
* __FLEX__ is the flexibility parameter in kilometers. Defaults to 0
* __options__ either "ellipse" or "union" depending on the model to be applied
* __totalSum__ desired sum of all ellemnts in the resulting Fluxes matrix. Defaults to 1.





Python version
-----------------------------------

Depends on [numpy](http://www.numpy.org/)


R version
-----------

Depends on [sp](http://cran.r-project.org/web/packages/sp/index.html)

Matlab version
-----------

Works in octave
No dependency 
