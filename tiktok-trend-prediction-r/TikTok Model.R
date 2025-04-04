# Load necessary libraries
library(randomForest)
library(caret)  # caret is for data splitting and model evaluation
library(tidyverse)
library(glmnet)
library(keras)
#install_keras()

# Define a function to calculate OOS R-squared
calculate_r_squared <- function(actual, predicted) {
  sst <- sum((actual - mean(actual))^2)
  sse <- sum((actual - predicted)^2)
  r_squared <- 1 - (sse / sst)
  return(r_squared)
}

# Load the dataset and preprocess
df <- read.csv("TikTok_songs_2021.csv")

# Remove irrelevant non-numeric columns
df_clean <- df %>%
  select(-track_name, -artist_name, -album)

# Convert categorical variables to numeric
df_clean$mode <- as.numeric(as.factor(df_clean$mode))
df_clean$key <- as.numeric(as.factor(df_clean$key))

# Standardization
df_clean_scaled <- df_clean %>%
  mutate(across(where(is.numeric), scale))

# Define the target variable and features
y <- df_clean_scaled$track_pop
X <- select(df_clean_scaled, -track_pop)

# Split the data into training and testing sets
set.seed(123)
trainIndex <- createDataPartition(y, p = 0.8, list = FALSE)
X_train <- X[trainIndex, ]
y_train <- y[trainIndex]
X_test <- X[-trainIndex, ]
y_test <- y[-trainIndex]

#############################################
# PCA

# Assuming X_train and y_train are your training dataset features and target variable respectively
# Step 1: Perform PCA on the scaled training data
X_train_scaled <- scale(X_train)

# Perform PCA
pca <- prcomp(X_train_scaled, center = TRUE, scale. = TRUE)

# Transform the test data using the PCA model
X_test_scaled <- scale(X_test, center = attr(X_train_scaled, "scaled:center"), scale = attr(X_train_scaled, "scaled:scale"))
pca_test <- predict(pca, newdata = X_test_scaled)  # Predicting using PCA

# Step 2: Create a data frame of the principal components
pca_train <- as.data.frame(pca$x)

# Choose the number of components you want to keep based on explained variance
num_pcs <- 10  # Adjust based on scree plot analysis
selected_pcs <- pca_train[, 1:num_pcs]

# Add the target variable to the PCA data frame
pca_data <- data.frame(selected_pcs, track_pop = y_train)

# Step 3: Fit a linear regression model using the selected principal components
pca_model <- lm(track_pop ~ ., data = pca_data)


# Step 4: Summarize the model to display significance levels
pca_summary <- summary(pca_model)

# Print the summary
print(pca_summary)

# According to the summary, we choose Principal Component 2 (PC2), PC3, and PC8
# Step 5: Prepare the PCA test data
pca_test_df <- as.data.frame(pca_test)  # Convert to data frame
pca_test_selected <- pca_test_df[, c("PC2", "PC3", "PC8")]  # Select relevant components

# Step 6: Fit the linear regression model using selected PCs
pca_model_final <- lm(track_pop ~ PC2 + PC3 + PC8, data = pca_data)

# Step 7: Summarize the final model
model_summary <- summary(pca_model_final)
print(model_summary)

# # Step 8: Calculate predictions using the PCA test data
pca_test_selected <- as.data.frame(pca_test[, c("PC2", "PC3", "PC8")])  # Ensure these columns exist in pca_test
predictions <- predict(pca_model_final, newdata = pca_test_selected)

# Print predictions to check if they were generated successfully
print(head(predictions))

# Step 9: Calculate evaluation metrics
actuals <- y_test
MAE <- mean(abs(actuals - predictions))
RMSE <- sqrt(mean((actuals - predictions)^2))
R_squared <- model_summary$r.squared
adj_R_squared <- model_summary$adj.r.squared

OOS_R_squared <- calculate_r_squared(actuals, predictions)

# Print evaluation metrics
cat("OOS R-squared:", OOS_R_squared, "\n")
cat("Mean Absolute Error (MAE):", MAE, "\n")
cat("Root Mean Squared Error (RMSE):", RMSE, "\n")


# Step 10: Visualize actual vs. predicted values
ggplot(data.frame(Actual = actuals, Predicted = predictions), aes(x = Actual, y = Predicted)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0, color = "red") +
  labs(title = "Actual vs. Predicted", x = "Actual Values", y = "Predicted Values") +
  theme_minimal()

# ####################################
# #Reason for choosing 10 principal component - PCA is not that effective
# 
# # Load necessary libraries
# library(ggplot2)
# 
# # Perform PCA on the scaled training data
# X_scaled <- scale(X_train)
# pca <- prcomp(X_scaled, center = TRUE, scale. = TRUE)
# 
# # Get the eigenvalues and explained variance
# eigenvalues <- pca$sdev^2
# explained_variance <- eigenvalues / sum(eigenvalues)
# cumulative_variance <- cumsum(explained_variance)
# 
# # Create a data frame for plotting
# pca_summary <- data.frame(
#   PC = 1:length(explained_variance),
#   Eigenvalue = eigenvalues,
#   ExplainedVariance = explained_variance,
#   CumulativeVariance = cumulative_variance
# )
# 
# # Print the pca_summary to check its structure
# print(head(pca_summary))  # Display the first few rows
# str(pca_summary)  # Check the structure of the data frame
# 
# # Plot Cumulative Explained Variance
# cumulative_plot <- ggplot(pca_summary, aes(x = PC, y = CumulativeVariance)) +
#   geom_line(color = "blue", linewidth = 1) +  # Updated size to linewidth
#   geom_point(color = "blue", size = 2) +
#   labs(title = "Cumulative Explained Variance", x = "Number of Principal Components", y = "Cumulative Variance Explained") +
#   ylim(0, 1) +
#   theme_minimal()
# 
# # Print Cumulative Plot
# print(cumulative_plot)


################################################################################
################################################################################
#Random Forest

# Set up a grid of possible `mtry` values to test
mtry_grid <- expand.grid(mtry = seq(2, ncol(X_train), by = 1))  # Test mtry from 2 to the number of features

# Train control: 5-fold cross-validation
train_control <- trainControl(method = "cv", number = 5)

# Train the model using Random Forest and test different mtry values
rf_tune <- train(track_pop ~ ., data = data.frame(X_train, track_pop = y_train),
                 method = "rf",
                 tuneGrid = mtry_grid,  # Grid of `mtry` values
                 trControl = train_control,  # Cross-validation settings
                 ntree = 500)  # Number of trees

# View the results of cross-validation
print(rf_tune)

# Extract cross-validation results from the rf_tune model
cv_results <- rf_tune$results

# Plot mtry vs RMSE
ggplot(cv_results, aes(x = mtry, y = RMSE)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  labs(title = "RMSE vs. mtry Values in Random Forest",
       x = "Number of Variables Tried at Each Split (mtry)",
       y = "Root Mean Squared Error (RMSE)") +
  theme_minimal()

# Plot mtry vs R-squared
ggplot(cv_results, aes(x = mtry, y = Rsquared)) +
  geom_line(color = "green", size = 1) +
  geom_point(color = "red", size = 2) +
  labs(title = "R² vs. mtry Values in Random Forest",
       x = "Number of Variables Tried at Each Split (mtry)",
       y = "R-squared") +
  theme_minimal()

# Best `mtry` value based on cross-validation
best_mtry <- rf_tune$bestTune$mtry
cat("Best mtry value:", best_mtry, "\n")

# Train the Random Forest model with the best `mtry` value
set.seed(123)  # For reproducibility
rf_model_best <- randomForest(track_pop ~ ., data = data.frame(X_train, track_pop = y_train), 
                              ntree = 500, 
                              mtry = best_mtry, 
                              importance = TRUE)

# Make predictions on the test set
rf_predictions_best <- predict(rf_model_best, newdata = X_test)

# Evaluate the performance of the model with the best `mtry`
rf_r_squared_best <- calculate_r_squared(y_test, rf_predictions_best)
rf_MAE_best <- mean(abs(y_test - rf_predictions_best))
rf_RMSE_best <- sqrt(mean((y_test - rf_predictions_best)^2))

cat("OOS R-squared:", rf_r_squared_best, "\n")
cat("Best Random Forest MAE:", rf_MAE_best, "\n")
cat("Best Random Forest RMSE:", rf_RMSE_best, "\n")

# Create a data frame with actual and predicted values
rf_results <- data.frame(
  Actual = y_test,
  Predicted = rf_predictions_best
)

# Plot actual vs predicted values
ggplot(rf_results, aes(x = Actual, y = Predicted)) +
  geom_point(color = "blue", size = 2) +  # Scatter plot points
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +  # Diagonal reference line
  labs(
    title = "Random Forest: Actual vs. Predicted Values",
    x = "Actual Values",
    y = "Predicted Values"
  ) +
  theme_minimal()
#############################################################################

# Prepare data for LASSO (creating model matrix)
X_train_matrix_lasso <- model.matrix(~ ., data = X_train)[, -1]
X_test_matrix_lasso <- model.matrix(~ ., data = X_test)[, -1]

# Train LASSO model using cross-validation
lasso_cv <- cv.glmnet(X_train_matrix_lasso, y_train, alpha = 1)

plot(lasso_cv)

# Best lambda selection
best_lambda <- lasso_cv$lambda.min
cat("Best Lambda:", best_lambda, "\n")

# Fit LASSO model with the best lambda
lasso_model <- glmnet(X_train_matrix_lasso, y_train, alpha = 1, lambda = best_lambda)

# Predict on the test set
lasso_predictions <- predict(lasso_model, s = best_lambda, newx = X_test_matrix_lasso)

# Evaluate LASSO Model
lasso_r_squared <- calculate_r_squared(y_test, lasso_predictions)
lasso_MAE <- mean(abs(y_test - lasso_predictions))
lasso_RMSE <- sqrt(mean((y_test - lasso_predictions)^2))

cat("LASSO OOS R-squared:", lasso_r_squared, "\n")
cat("LASSO MAE:", lasso_MAE, "\n")
cat("LASSO RMSE:", lasso_RMSE, "\n")

# Create a data frame with actual and predicted values
lasso_predictions <- as.vector(lasso_predictions)
lasso_results <- data.frame(Actual = y_test, Predicted = lasso_predictions)

# Plot actual vs predicted values
ggplot(lasso_results, aes(x = Actual, y = Predicted)) +
  geom_point(color = "blue") +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "LASSO: Actual vs. Predicted Values",
       x = "Actual Values", y = "Predicted Values") +
  theme_minimal()

###############################################################################

#Deep Learning: Neural Network
# Convert training and testing data to matrix format
X_train_matrix <- as.matrix(X_train)
X_test_matrix <- as.matrix(X_test)

# Ensure the target variables are vectors
y_train_vector <- as.vector(y_train)
y_test_vector <- as.vector(y_test)

# Define the neural network model
nnmodel <- keras_model_sequential() %>%
  layer_dense(units = 64, activation = "relu", input_shape = ncol(X_train_matrix)) %>%
  layer_dense(units = 32, activation = "relu") %>%
  layer_dense(units = 1, activation = "linear")


# Compile the model
nnmodel %>% compile(
  optimizer = "adam",  # Adam optimizer for gradient descent
  loss = "mean_squared_error",  # Loss function for regression
  metrics = c("mean_absolute_error")  # Track MAE during training
)

# View the model architecture
summary(nnmodel)

# Train the model with matrix input
history <- nnmodel %>% fit(
  X_train_matrix, y_train,
  epochs = 100,
  batch_size = 32,
  validation_split = 0.2
)


# Plot the training and validation loss over epochs
plot(history)

# Evaluate the neural network model
nnmodel %>% evaluate(X_test_matrix, y_test_vector)

# Make predictions on the test data
nn_predictions <- nnmodel %>% predict(X_test_matrix)

# Convert predictions to a vector
nn_predictions <- as.vector(nn_predictions)

# Evaluate performance using custom functions
nn_r_squared <- calculate_r_squared(y_test, nn_predictions)
nn_MAE <- mean(abs(y_test - nn_predictions))
nn_RMSE <- sqrt(mean((y_test - nn_predictions)^2))

cat("Neural Network OOS R-squared:", nn_r_squared, "\n")
cat("Neural Network MAE:", nn_MAE, "\n")
cat("Neural Network RMSE:", nn_RMSE, "\n")
