model_sel_permutations <- function (repeats,FUN,pars) {
##### function to calculate p-values from single model and model selection permutation tests

### calculate model selection statistics from the outcomes in their original order.
STATtrue=do.call(FUN, pars) 

#### Calculate model selection statistics under each permutation
STATperm=numeric() ### initialise matrix to store statistics from each permutation
for (i in 1:repeats)  ### use a random permutation of the outcomes and calculate the model selection statistic
{
	pars[[1]]=sample(as.numeric(unlist(pars[1]))) ### permute the outcomes and
	tmp=as.numeric(do.call(FUN, pars))+rnorm(1)*0.000001 ### apply the user function with the permuted outcomes (rnorm is added to break potential ties)
	STATperm=rbind(STATperm,tmp) ### Record model selection statistics from particular permutation of the outcomes
}

#### Calculate p-values of each model under single model permutation test
single_model_p_value=numeric() ### initialise vector for p-values

for (j in 1:dim(STATperm)[2]) ### loop through each combination of variables
{		
	single_model_p_value[j]=(which(sort(c(STATtrue[j],STATperm[,j]))==STATtrue[j])-1)/repeats  ### p-value for each combination of variables
}


#### Calculate p-value for model selection permutation test

tmp=numeric()  ##### find minimum model selection statistic over all models for each repeat and store in "tmp".
for (k in 1:dim(STATperm)[1]){
	tmp[k]=min(STATperm[k,])
}

model_selection_p_value=(which(sort(c(min(STATtrue),tmp))==min(STATtrue))-1)/repeats  ### Calculate model selection p-value

output=list("single_model_p_value"=single_model_p_value,"model_selection_p_value"=model_selection_p_value)  ### define outputs

return(output)
}
