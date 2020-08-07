The code in this repository can be used to apply the two permutation tests described in "Assessing the Significance of Model Selection in Ecology" by Edward Wheatcroft.  A preprint of the paper is available at https://arxiv.org/abs/2004.07583 and it is also under consideration for publication in the European Journal of Ecology.

Within the paper, two real world demonstrations of the tests are given for population modelling of (i) reindeer populations in Hardangervidda National Park and (ii) Ibex populations in Gran Paradiso National Park.  The code is demonstrated using the ibex example but it is straighforward to apply to any user-defined model.

RUNNING THE CODE FOR THE IBEX EXAMPLE

The following code can be used to apply the single model and model selection permutation tests in R. The code consists of the following two functions and a script demonstrating their usage.

1) model_sel_permutations.R (function to perform the single model and model selection permutation tests)
2) Ibex.R (function to use within model_sel_permutations.R to perform tests on the ibex example)
3) main.R (script demonstrating how to use the two functions to perform the tests)

The model_sel_permutations.R function performs the tests with a given, user defined, function.  This is demonstrated using the Ibex.R function but it is straighforward to use an alternative function (instructions for doing this are also described).

Further details on each of the functions is given below and their use is demonstrated in main.R

1) Ibex.R

Let n be the number of yearly observations (in this case of the relative population change), k the number of potential predictor variables and m the number of models (each one representing a different combination of predictor variables).

The function Ibex.R takes as arguments:

(i) outcome - a vector of outcomes of length n 
(ii) vars - an nxk matrix of predictor variables 
(iii) combinations - an mxk matrix of 1s and 0s which determines the predictor variables that are to be included in each model. Each row corresponds to a different combination of variables (model) and the number in each column determines whether that variable (as defined in the columns of "vars") is included or not (1 or 0).

The function fits a multiple linear regression and returns a vector of AIC values with each one corresponding to a different combination of variables (as determined by the "combinations" argument to the function).

2) model_sel_permutations.R

This is the function that applies the two permutation tests.  It takes as arguments :

(i) repeats - a single number defining the number of permutations of the outcomes used to calculate the estimated p-values of the two tests.
(ii) FUN - The name of the model function (in this case "Ibex")
(iii) pars - a list consisting of the inputs to the model function in the order they appear.  Each element of the list should be given the name of the argument.  E.g., for the ibex example, we define 

>pars=list("outcome"=Y,"vars"=vars,"combinations"=var_combinations) 

For the ibex example, the tests are then run with the command:

>output=model_sel_permutations(repeats,Ibex,pars) 

and the outputs form a list, the elements of which can be accessed by typing 

>print('Single model p-values:')
>print(output$single_model_p_value) 
>print('Model selection p-value:')
>print(output$model_selection_p_value)

RUNNING THE CODE WITH A USER DEFINED MODEL

The Ibex.R function provided is suitable for other population modelling examples using the Stochastic Ricker and Gompertz models as well as other linear generalised linear models (GLMs).  However, it is also straightforward to write a function for other models by replacing Ibex.R with a user-defined function. The only requirement of the function is that the first argument must be a vector of outcomes.  The tests can then be performed by running 

>output=model_sel_permutations(repeats,"function_name",pars) 

where "function_name" is replaced with the name of the function and "pars" is a list consisting of the inputs to the user-defined function (see the ibex example for syntax).  
