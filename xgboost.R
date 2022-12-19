library(tidyverse)
library(xgboost)
library(shapviz)

df <- read.table("master_set.txt")

set.seed(117)

index <- sample(1:nrow(df), size = 914, replace = FALSE)

df_train <- df[index,]
df_test <- df[-index,]

m_train <- as.matrix(df_train %>%  select(-Opponent, -Team, -Result) %>% 
                     mutate_all(as.numeric))

m_test <- as.matrix(df_test %>%  select(-Opponent, -Team, -Result) %>% 
                       mutate_all(as.numeric))

xgb <- xgboost(data = m_train, label = m_train[,17] , verbose = 1, nrounds = 5)

str(m_train)


m_train[,17]

predict(xgb, m_test)
