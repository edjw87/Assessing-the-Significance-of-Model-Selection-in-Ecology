### read in necessary functions
source('Ibex.R')   
source('model_sel_permutations.R')

## read ibex data file
data=read.csv('GP_data.csv')  

### These are the candidate predictor variables
postmp=which(is.na(data[,3])==FALSE) #locations in which there are no missing snow density values
n=data[postmp,2] ### current population count
x=data[postmp,3] ### log population count
sd=data[postmp,5] ### snow density
n_sd=n*sd ### interaction between snow density and population count
x_sd=x*sd ### interaction between snow density and log population count

### This is the dependent variable
Y=data[postmp,4] ### Vector of "relative population change".  These are the outcomes that we want to predict.

vars=cbind(n,x,sd,n_sd,x_sd) ### create a matrix of predictor variables for use in Ibex.R

##### define included variables in each model
var_combinations=matrix(rep(0,20*5,1),20,5) ### initialise matrix of selected variables

### Define combinations of variables (models).  One row for each combination.
var_combinations[1,]=c(1,0,1,1,0) #m1
var_combinations[2,]=c(0,1,1,0,1) #m2
var_combinations[3,]=c(0,0,1,1,0) #m3
var_combinations[4,]=c(0,0,1,0,1) #m4
var_combinations[5,]=c(1,0,0,1,0) #m5
var_combinations[6,]=c(0,1,0,0,1) #m6
var_combinations[7,]=c(1,0,1,0,0) #m7
var_combinations[8,]=c(0,1,1,0,0) #m8
var_combinations[9,]=c(0,0,0,1,0) #m9
var_combinations[10,]=c(0,0,0,0,1) #m10

var_combinations[11,]=c(1,0,1,1,0) #m11
var_combinations[12,]=c(0,1,1,0,1) #m12
var_combinations[13,]=c(0,0,1,1,0) #m13
var_combinations[14,]=c(0,0,1,0,1) #m14
var_combinations[15,]=c(1,0,0,1,0) #m15
var_combinations[16,]=c(0,1,0,0,1) #m16
var_combinations[17,]=c(1,0,1,0,0) #m17
var_combinations[18,]=c(0,1,1,0,0) #m18
var_combinations[19,]=c(0,0,0,1,0) #m19
var_combinations[20,]=c(0,0,0,0,1) #m20

threshold_value=c(rep(NA,10),rep(154,10))  ## define threshold values for each model (vector with entry for each model). Here models 11-20 are threshold models and so a threshold is defined
threshold_variable=3 ### select variable column in "vars" on which to add threshold (scalar).  Here, we set the threshold on the third variable (snow density).

repeats=4096 #### define number of permutations in permutation test
pars=list("outcome"=Y,"vars"=vars,"combinations"=var_combinations,"threshold_value"=threshold_value,"threshold_variable"=threshold_variable) ### make a list for the parameters in Ibex.R.  The first argument must be the outcomes that are to be permuted

output=model_sel_permutations(repeats,Ibex,pars) ### run the permutation test and save them in "output" which is a list.

print('Single model p-values')   ### print the results
print(output$single_model_p_value) ### single model p-values are given in the first element of the list.
print('Model selection p-value')
print(output$model_selection_p_value) ### model selection p-value is given in the second element of the list
