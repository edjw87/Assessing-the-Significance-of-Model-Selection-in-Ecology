Ibex <- function (outcome,vars,combinations,threshold_value,threshold_variable) {
### function to produce the AIC of different combinations of predictor variables in a multiple linear regression
### The arguments are as follows:
### outcome - a vector of outcomes of length n 
### vars - an nxk matrix of predictor variables 
### combinations - an mxk matrix consisting of 1s and 0s which determines the predictor variables that are to be included in the model. Each row corresponds to a different combination of variables (model) and each column determines whether that variable is included or not (1 or 0).
### threshold_value - threshold value for selected variable
### threshold_variable - variable (the column in "vars") on which threshold is applied

output=numeric() ### initialise output vector
for (i in 1:dim(combinations)[1]){   ### loop through each combination of variables (model)
	includedvars=which(combinations[i,]==1)
	subvars=vars[,includedvars]  ### find which variables are to be included
	
	if (is.na(threshold_value[i])){  ### if there is no threshold,  perform regression on selected variables
		if (length(subvars)==0){ ### if no variables, perform regression with only a constant term and calculate AIC
			output[i]=-2*logLik(lm(outcome~1))+2*1 	
		}	else{ ### if variables defined, perform regression and calculate AIC
			output[i]=-2*logLik(lm(outcome~subvars))+(sum(combinations[i,])+2)*2 ### Perform regression and calculate AIC
		}
	} else{ ### if threshold value is supplied, find separate parameters on each side of the threshold
		if (length(subvars)==0){  
			output[i]=-2*logLik(lm(outcome~1))+2*1 ### if no variables, perform regression with only a constant term and calculate AIC	
		} else{
			if (length(includedvars)>1){	
				vars1=vars[,includedvars] #### pull out selected variables into a new matrix
				vars2=vars[,includedvars] #### pull out selected variables into another new matrix
			} else{
				vars1=matrix(vars[,includedvars]) #### if only one variable is selected, convert vector into a matrix
				vars2=matrix(vars[,includedvars]) ## as above
			}
			pos1=which(vars[,threshold_variable]<threshold_value[i]) ### find points below threshold
			vars1[pos1,]=0  ##### put zeros into the matrix when selected variable is less than threshold
			pos2=which(vars[,threshold_variable]>=threshold_value[i]) ### find points above or equal to threshold
			vars2[pos2,]=0  ##### put zeros into the matrix when selected variable is greater than or equal threshold
			varsnew=cbind(vars1,vars2) ### bind the 2 matrices into 1 big one.
			output[i]=-2*logLik(lm(outcome~varsnew))+(2*sum(combinations[i,])+2)*2 ### Perform regression and calculate AIC for threshold model
		}
	}
}

return(output)  #### return AIC values for each combination of variables
}
