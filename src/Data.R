#####################
### Data class contains the dataset and defined some methods for the dataset
### finding leaf samples and sufficient statistics per leaf

### Descriptions of Class members 
### parameters    type          Description
### datas         matrix        Dataset
### num_rows      int           Number of rows in the data set
### num_cols      int           Number of cols in the data set
### TODO:


##################

library(methods)
setClass("data",representation(datas="numeric",num_rows="numeric",num_cols="numeric",
                               outcome_index ="numeric",treatment_index = "numeric",
                               instrument_index = "numeric", weight_index = "numeric",
                               causal_survival_numerator_index = "numeric", causal_survival_denominator_index = "numeric",
                               censor_index = "numeric"))

setMethod("initialize", "data", function(.Object, datas=NULL, num_rows=NULL, num_cols=NULL)
{
  if(!is.null(datas))
  {
    .Object@datas <- datas
  }
  if(!is.null(num_rows))
  {
    .Object@num_rows <- num_rows
  }
  if(!is.null(num_cols))
  {
    .Object@num_cols <- num_cols
  }
  .Object
})

setGeneric("getdata", function(object, ...) standardGeneric("getdata"))
setMethod("getdata",signature(object="data"), function(object, row, col)
{
  object@datas[row,col]
})

setGeneric("is_failure", function(object, ...) standardGeneric("is_failure"))
setMethod("is_failure", signature(object="data"), function(object, row)
{
  getdata(object,row,object@censor_index)>0
})

setGeneric("get_causal_survival_denominator", function(object, ...) standardGeneric("get_causal_survival_denominator"))
setMethod("get_causal_survival_denominator", signature(object="data"), function(object, row)
{
  getdata(object,row,object@causal_survival_denominator_index)
})

setGeneric("get_causal_survival_numerator", function(object, ...) standardGeneric("get_causal_survival_numerator"))
setMethod("get_causal_survival_numerator", signature(object="data"), function(object, row)
{
  getdata(object,row,object@causal_survival_numerator_index)
})

setGeneric("get_weight", function(object, ...) standardGeneric("get_weight"))
setMethod("get_weight", signature(object="data"), function(object, row)
{
  if(!is.null(object@weight_index))
  {
    getdata(object,row,object@weight_index)
  }
  else
  {
    1.0
  }
  
})

setGeneric("get_instrument", function(object, ...) standardGeneric("get_instrument"))
setMethod("get_instrument", signature(object="data"), function(object, row)
{
  getdata(object,row,object@instrument_index)
})


setGeneric("get_treatments", function(object, ...) standardGeneric("get_treatments"))
setMethod("get_treatments", signature(object="data"), function(object, row)
{
  object@treatment_index[row,object@treatment_index]
})

setGeneric("get_treatment", function(object, ...) standardGeneric("get_treatment"))
setMethod("get_treatment", signature(object="data"), function(object, row)
{
  get_treatments(object,row)[1]
})

