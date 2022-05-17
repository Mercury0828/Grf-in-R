library(methods)

#####################
### Tree class holds some methods for a single tree in a random forest, including variable splits, 
### finding leaf samples and sufficient statistics per leaf
 
### Descriptions of Class members 
### parameters    type          Description
### root_node     int           The index of the root node of the tree
### child_nodes   N*2 matrix    child_nodes[,1] is the index of the left subtree of the root node and child_nodes[,2] for right subtree
### TODO:


##################
setClass("tree",representation(root_node="numeric",child_nodes="numeric",leaf_samples="numeric",
                               split_vars ="numeric",split_values = "numeric",
                               drawn_samples = "numeric", send_missing_left = "numeric",
                               prediction_values = "numeric"))

### initialize
### Function: Class initialization functions
### Input: 

### Output: 

setMethod("initialize", "tree", function(.Object, root_node=NULL, child_nodes=NULL, leaf_samples=NULL, split_vars = NULL,
                                         split_values=NULL, drawn_samples=NULL, send_missing_left=NULL, prediction_values=NULL)
{
  if(!is.null(root_node))
  {
    .Object@root_node <- root_node
  }
  if(!is.null(child_nodes))
  {
    .Object@child_nodes <- child_nodes
  }
  if(!is.null(leaf_samples))
  {
    .Object@leaf_samples <- leaf_samples
  }
  if(!is.null(split_vars))
  {
    .Object@split_vars <- split_vars
  }
  if(!is.null(split_values))
  {
    .Object@split_values <- split_values
  }
  if(!is.null(drawn_samples))
  {
    .Object@drawn_samples <- drawn_samples
  }
  if(!is.null(send_missing_left))
  {
    .Object@send_missing_left <- send_missing_left
  }
  if(!is.null(prediction_values))
  {
    .Object@prediction_values <- prediction_values
  }
  .Object
})


### is_leaf
### Function:
### Input: 

### Output:
setGeneric("is_leaf", function(object, ...) standardGeneric("is_leaf"))
setMethod("is_leaf",signature(object="tree"), function(object, node)
{
  
  child_nodes = object@child_nodes
  (child_nodes[node,1]==0)&(child_nodes[node,2]==0)

})

### find_leaf_node
### Function: 
### Input: 

### Output:
setGeneric("find_leaf_node", function(object,data, ...) standardGeneric("find_leaf_node"))
setMethod("find_leaf_node",signature(object="tree",data="data"), function(object, data, sample)
{
  node = object@root_node
  while(TRUE)
  {
    #Break if terminal node
    if(is_leaf(object,node))
      break 
    #Move to child
    split_var<-object@split_vars[node]
    split_val<-object@split_values[node]
    value <-getdata(data,sample,split_var)
    send_missing_left<-object@send_missing_left
    if((value<=split_val)| #ordinary split
       (send_missing_left&is.null(value))| #are we sending NaN left
       is.null(split_val)&is.null(value)) #are we splitting on NaN
    {
      #Move to left child
      node = child_nodes[node,1];
    }
    else
    {
      #Move to right child
      node = child_nodes[node,2];
    }
  }
  node
})

### find_leaf_node
### Function: 
### Input: 

### Output:
setGeneric("find_leaf_nodes", function(object,data, ...) standardGeneric("find_leaf_nodes"))
setMethod("find_leaf_nodes",signature(object="tree",data="data"), function(object, data, samples)
{
  num_rows<- data@num_rows
  prediction_leaf_nodes <- vector(numeric, num_rows)
  
  for(sample in samples)
    prediction_leaf_nodes[sample]=find_leaf_node(object,sample)
  prediction_leaf_nodes
})
