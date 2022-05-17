# Grf-in-R
The core code of generalized random forest using R

Take https://github.com/grf-labs/grf.git as a reference, rewrite the core code for grf using R

## Code main structure
### data
Contains some basic manipulation methods for data sets and datasets, such as insertion and deletion

### tree
Stores the structure of a single tree and some operations in the tree

### treeTrainer -> tree
Training method for a single tree

Draw half sample for honesty  
Until termination condition,  
&emsp;&emsp; draw possible split variables  
&emsp;&emsp;&emsp;&emsp;  compute peseudo outcomes,  
&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;&nbsp;&nbsp;  find best split  
&emsp;&emsp; repopulate leaves for honesty  
&emsp;&emsp; precompute sufficient statistics  

### forest 
Stored the collection of trees in the forest and training observations and out-of-bag information

### forestTrainer -> forest
for each tree group,  
&emsp;&emsp;draw half sample  
&emsp;&emsp;  for each tree in group,  
&emsp;&emsp;&emsp;&emsp;   train tree
   
### predictions
Stored estimates of the variables and estimates of the variance of the variables

### prediction collector -> predictions
for each test sample,  
&emsp;&emsp; for each tree group(considering OOB),  
&emsp;&emsp;&emsp;&emsp;  for each tree,  
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;    retrieve sufficient statistics  
&emsp;&emsp; compute average sufficient statistics  
&emsp;&emsp; compute point estimator  
&emsp;&emsp; calculate variance estimator
 
### forest predictor -> predictions
find the leaves for all test samples(or OOB samples)  
collect predictions


## Current progress and TODO list
### Current progress
Working on data and tree classes

### TODO
Test the written function, add comments  
Code for treeTrainer
