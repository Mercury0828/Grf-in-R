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
Until termination condition,\\
  draw possible split variables\\
  compute peseudo outcomes,
  find best split
 repopulate leaves for honesty
 precompute sufficient statistics

### forest 
Stored the collection of trees in the forest and training observations and out-of-bag information

### forestTrainer -> forest
for each tree group,
  draw half sample
  for each tree in group,
   train tree
   
### predictions
Stored estimates of the variables and estimates of the variance of the variables

### prediction collector -> predictions
for each test sample,
 for each tree group(considering OOB),
  for each tree,
    retrieve sufficient statistics
 compute point estimator
 calculate variance estimator
 
### forest predictor -> predictions
find the leaves for all test samples(or OOB samples)
collect predictions


## Current progress and TODO list
### Current progress
Working on data and tree classes

### TODO
Test the written function, add comments
Code for treeTrainer
