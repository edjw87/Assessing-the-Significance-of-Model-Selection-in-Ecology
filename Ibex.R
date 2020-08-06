Ibex <- function (outcome,vars,combinations) {
### function to produce the AIC of different combinations of predictor variables in a multiple linear regression
### The arguments are as follows:
### outcome - a vector of outcomes of length n 
### vars - an nxk matrix of predictor variables 
### combinations - an mxk matrix consisting of 1s and 0s which determines the predictor variables that are to be included in the model. Each row corresponds to a different combination of variables (model) and each column determines whether that variable is included or not (1 or 0).

output=numeric()
for (i in 1:dim(combinations)[1]){
	subvars=vars[,which(combinations[i,]==1)]
	if (length(subvars)==0){
		output[i]=AIC(lm(outcome~1))
	}	else	{
		output[i]=AIC(lm(outcome~subvars))
	}
}

return(output)
}
