# ======================================================================================================
# Title: Machine learning model for wheat yield and N surplus and the relative importance of their explanatory variables

# Code authors: Gang He (hegang029@nwafu.edu.cn)

# Date: 04/26/2025

# Publication: Data-driven nitrogen management benchmarks support China's wheat self-sufficiency by 2030

# Description: Establishing RF yield model and N surplus model

# ====================================================================================================== 
# Set up path
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Load data
fname = 'data.csv'
data = fread(fname)

#Random Forest model establishment
data_yield <- data[,-17]
grid <- expand.grid(
  mtry = c(2, 3, 5, 7), 
  splitrule = c("variance", "extratrees"), 
  min.node.size = c(1, 5, 10) )
control <- trainControl(method = "cv", number = 10)
model <- train(
  Yield ~ .,  
  data = data_yield,
  method = "ranger",
  trControl = control,
  tuneGrid = grid,
  importance = 'permutation',
  respect.unordered.factors = TRUE,
  num.trees = 500,
  keep.inbag = TRUE)
print(model$bestTune)
set.seed(123)
rf_yield = ranger(dependent.variable.name = "Yield",
                  data = data_yield,
                  importance = 'permutation',
                  mtry = 5,
                  min.node.size = 1,
                  respect.unordered.factors = T, 
                  num.trees = 1000, 
                  keep.inbag = T, 
                  oob.error = T)
# Determination of coefficient (R squared) by out of bag and importance of variables
print(rf)
importance <- rf_yield$variable.importance
total <- sum(importance)
importance_normalized <- (importance/ total) * 100
importance_sorted <- sort(importance_normalized, decreasing =T)

#Random Forest model establishment
data_N <- data[,-16]
grid <- expand.grid(
  mtry = c(2, 3, 5, 7), 
  splitrule = c("variance", "extratrees"), 
  min.node.size = c(1, 5, 10) )
control <- trainControl(method = "cv", number = 10)
model <- train(
  N_surplus ~ .,  
  data = data_N,
  method = "ranger",
  trControl = control,
  tuneGrid = grid,
  importance = 'permutation',
  respect.unordered.factors = TRUE,
  num.trees = 500,
  keep.inbag = TRUE)
print(model$bestTune)
set.seed(123)
rf_N = ranger(dependent.variable.name = "N_surplus",
              data = data_N,
              importance = 'permutation',
              mtry = 5,
              min.node.size = 1,
              respect.unordered.factors = T, 
              num.trees = 1000, 
              keep.inbag = T, 
              oob.error = T)
# Determination of coefficient (R squared) by out of bag and importance of variables
print(rf)
importance <- rf_N$variable.importance
total <- sum(importance)
importance_normalized <- (importance/ total) * 100
importance_sorted <- sort(importance_normalized, decreasing =T)
