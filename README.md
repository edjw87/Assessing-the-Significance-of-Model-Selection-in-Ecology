RUNNING THE CODE FOR THE IBEX EXAMPLE

The following code can be used to apply the single model and model selection permutation tests in R. The code consists of the following two functions and a script demonstrating their usage.

1) model_sel_permutations.R (function to perform the single model and model selection permutation tests)
2) Ibex.R (function to use within model_sel_permutations.R to perform tests on the ibex example)
3) main.R (script demonstrating how to use the two functions to perform the tests)

The model_sel_permutations.R function performs the tests with a given, user defined, function.  This is demonstrated using the Ibex.R function but it is straighforward to use an alternative function.   

Further details on each of the functions is given below and is demonstrated in main.R

1) Ibex.R

This function takes as arguments:

(i) outcome - a vector of outcomes of length n 
(ii) vars - an nxk matrix of predictor variables 
(iii) combinations - an mxk matrix consisting of 1s and 0s which determines the predictor variables that are to be included in the model. Each row corresponds to a different combination of variables (model) and each column determines whether that variable is included or not (1 or 0).

where n is the number of forecasts and outcome, m is the number of candidate models and k is the number of candidate predictor variables:

The function fits a multiple regression and returns a vector in which each element is the AIC for a defined combination of variables.

2) model_sel_permutations.R

This function takes as arguments 
(i) repeats - the number of permutations of the outcomes
(ii) FUN - The name of the model function (in this case "Ibex")
(iii) pars - a list consisting of the inputs to the model function in the order they appear.  Each element of the list should be given the name of the argument.  E.g., for the ibex example, we define 

>pars=list("outcome"=outcomes,"vars"=vars,"combinations"=var_combinations) 


RUNNING THE CODE  WITH A USER DEFINED MODEL

The permutation tests can be run for other statistical models by providing alternative model functions.  The only requirement is that, as with the "Ibex" function, the first argument must be a vector of outcomes.  The tests can then be performed by running 

>output=model_sel_permutations(repeats,"function_name",pars) 

where "function_name" is replaced with the name of the function and "pars" is a list consisting of the inputs to the user-defined function (see the ibex example for syntax).  
