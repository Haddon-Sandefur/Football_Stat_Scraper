library(dplyr)
library(caret)


# Read In Data
df <- read.table("master_set_v21.txt")

# Set Seed
set.seed(2023)

# Random Index Generation/ Sample 3/4 of the rows in the dataset.
index <- sample(1:floor(.75*nrow(df)))

# Split Data into two sets. A Train and Test Set by the index above.
df_train <- df[index,]
df_test <- df[-index,]

# Weights for P5 G5 Sampling
wts <- ifelse(df_train$P5vG5 == "P5 vs G5" | df_train$P5vG5 == "G5 vs P5", .65, 1-.65)


# Random Forest Creation

# For now, we're not going to do anything super complicated. The current objective is to build a use-case model
# to integrate into a web app so users can have fun playing with a prediction model. The below model is a simple random forest
# that factors in all covariates other than the final score/result. Such covariates even include the teams, relative conference
# power rankings, P5 and G5 statuses, and whether the game features a matchup between a G5 and a P5 school.Adding these factors
# will inflate the number of predictors the algorithm will try. Since this model is cross-validated (to eyeball general
# performance) and since there are 131 total teams for "Team", the computation time is high. Consequently, we'll save 
# this model as a file once it's finished.

# Caret Object that contains tuning arguments for the Random Forest


trcntrl <- caret::trainControl(method = "repeatedcv",
                               number = 10,
                               search = "grid",
                               )


# Random Forest Model: Regression ========================================
set.seed(2023)



rf <- train(diff_Score~., 
            data = df_train %>% select(-Result, 
                                 -Result_num, 
                                 #-Opponent, 
                                 #-Opp_Conference, 
                                 #-Conference
                                 -CONF_PWR
                                 ),
            method = 'rf',
            metric = 'RMSE',
            weights = wts,
            tuneLength = 5,
            trControl = trcntrl
            )

# Result
print(rf)

# Train rMSE
sqrt(mean((predict(rf, df_train)-df_train$diff_Score)^2))

# Test rMSE
sqrt(mean((predict(rf, df_test)-df_test$diff_Score)^2))

# rMSE ~ 9

# Importance
varImp(rf)

# Save Model
save(rf, file = "rf.rda")



# Classifier ===============================================================
set.seed(2023)

# Random Forest Model
rfclass <- train(Result ~., 
            data = df_train %>% select(-Result_num, 
                                 -diff_Score, 
                                 #-Opponent, 
                                 #-Opp_Conference, 
                                 #-Conference
                                 -CONF_PWR
                                 
            ),
            method = 'rf',
            metric = 'Accuracy',
            weights = wts,
            tuneLength = 5,
            trControl = trcntrl
)

# Result
print(rfclass)


df_test$pred <- factor(predict(rfclass, df_test))
df_test$Result <- factor(df_test$Result)

# Confusion Matrix
confusionMatrix(data = df_test$Result, reference = df_test$pred)

# Accuracy on Test Set is ~85%... 

# Importance
varImp(rfclass)

save(rfclass, file = "rfclass.rda")

# Let's see if the Spread Model does any better at classifying wins and losses than the Random Forest Classifier: ======================

df_test$spread <- predict(rf, df_test)
df_test <- df_test %>% mutate(spread_pred = factor(ifelse(spread >= 0, "W", "L")))

confusionMatrix(data = df_test$Result, reference = df_test$spread_pred)

# It does just slightly!
                                                            