model_sel_permutations <- function (repeats,FUN,pars) {
##### function to calculate p-values from single model and model selection permutation tests

STATtrue=do.call(FUN, pars) ### calculate model selection statistics from the outcomes in their original order.

#### Calculate model selection statistics under each permutation
STATperm=numeric() ### initialise matrix
for (i in 1:repeats)  ### use a random permutation and calculate model selection statistic
{
	pars[[1]]=sample(as.numeric(unlist(pars[1]))) ### permute the outcomes
	tmp=as.numeric(do.call(FUN, pars)) ### apply the user function with the provided parameters
	STATperm=rbind(STATperm,tmp) ### Add model selection statistics from particular permutation of the outcomes
}

#### Calculate p-values of each model under single model permutation test
single_model_p_value=numeric() ### initialise vector for p-values

for (j in 1:dim(STATperm)[2]) ### loop through each combination of variables
{
	single_model_p_value[j]=(which(sort(c(STATtrue[j],STATperm[,j]))==STATtrue[j])-1)/repeats  ### p-value for each combination of variables
}

tmp=numeric()  ##### find minimum model selection statistic over all models for each repeats and store in "tmp".
for (k in 1:dim(STATperm)[1]){
	tmp[k]=min(STATperm[k,])
}

model_selection_p_value=(which(sort(c(min(STATtrue),tmp))==min(STATtrue))-1)/repeats  ### Calculate model selection p-value

output=list("single_model_p_value"=single_model_p_value,"model_selection_p_value"=model_selection_p_value)  ### define outputs

return(output)
}
