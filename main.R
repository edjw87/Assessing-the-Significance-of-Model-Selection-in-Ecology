### read in necessary functions
source('Ibex.R')   
source('model_sel_permutations.R')

data=read.csv('GP_data.csv')  ## read ibex data file
Y=data[,4] ### define vector for "relative population change"

### These are the predictor variables for the ibex example

n=data[,2] ### current population count
x=data[,3] ### log population count
sd=data[,5] ### snow density
n_sd=n*sd ### interaction between snow density and population count
x_sd=x*sd ### interaction between snow density and log population count

vars=cbind(n,x,sd,n_sd,x_sd) ### create a matrix of predictor variables
outcomes=Y ### We aim to predict the relative population change

##### define included variables in each model
var_combinations=matrix(rep(0,10*5,1),10,5) ### initialise matrix of selected variables

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

repeats=4096 #### define number of permutations in permutation test
pars=list("outcome"=outcomes,"vars"=vars,"combinations"=var_combinations) ### make a list for the parameters for the input function.  The first argument must be the outcomes that are to be permuted

output=model_sel_permutations(repeats,Ibex,pars) ### run the permutation test and save them in "output" which is a list.

print('Single model p-values')   ### print the results
print(output$single_model_p_value) ### single model p-values are given in the first element of the list.
print('Model selection p-value')
print(output$model_selection_p_value) ### model selection p-value is given in the second element of the list
