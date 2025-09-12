# Code-for-Chinese-Household-Debt

To conduct the baseline model with debt function, run the main file directly

To conduct the baseline model of the high type, change the parameters:

** The grids had been mannually tapped into the parameter file, so that one will not need to compute using the grid creation file anymore.
par.bgrid_type = 'Real1' to 'Real2'
par.agrid_type = 'Real1' to 'Real2'

... in the parameters2.m

w to w2
... in the updatehousehold.m, line 94,95

and block the d_idt for Real1, line 54

and par.w to par.w2
... in the updatehousehold.m, line 106, 111, 126, 129

The code yields the figures of the households ending up with the stochastic states 1 & 2, to get the rest, and the DAR and Propensity to consume, run the following:

'stationaryFigures34.m'
'stationaryFigures56.m'
'stationaryFigures78.m'
'stationaryFiguresdbt.m'
