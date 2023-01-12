# Dependencies
library(dplyr)

# Load Random Forest Model
load("rf.rda")
load("rfclass.rda")

# Read in Season Averages for Each Team
df_avg <- read.table("master_avg_v21.txt")

# Function for Returning Prediction
matchup <-function(Team1, Team2, data){ 
  
 
  
  # Grab the Teams we want to pit against each other, removing strings so we can take differences.
  dat1 <- data %>% filter(Team == Team1) %>% select(-Team, -Conference, -Team_P5_G5)
  dat2 <- data %>% filter(Team == Team2) %>% select(-Team, -Conference, -Team_P5_G5)
  
  
  # Here lies a problem. Depending on the order in which you input a team, this model will yield similar, albiet different predictions
  # for each matchup.This likely has to do with the influence certain ranges of values have on decision trees within the random forest.
  # We can -brutishly- solve this by taking both orders of a matchup (e.g. Team1 vs Team2 and Team2 vs Team1) and averaging the results. This will
  # give us a fixed probability for each matchup, irrespective of order.
  
  
  # Take differences.
  diffs1 <- data.frame(t(colSums(rbind(dat1, -dat2)))) 
  diffs2 <- data.frame(t(colSums(rbind(-dat1, dat2))))
  
  # Add Predictors back ===============================================================
  
  # Team1 -----------------------------
  diffs1$Team <- Team1
  
  diffs1$Conference <- as.character(data %>% filter(Team == Team1) %>% select(Conference))
  
  diffs1$Opponent <- Team2
  
  diffs1$Opp_Conference <- as.character(data %>% filter(Team == Team2) %>% select(Conference))
  
  # P5 or G5?
  
  diffs1$Team_P5_G5 <- as.character(data %>% filter(Team == Team1) %>% select(Team_P5_G5))
  diffs1$Opp_P5_G5 <- as.character(data %>% filter(Team == Team2) %>% select(Team_P5_G5))
  diffs1 <- diffs1 %>% mutate(P5vG5 = case_when(
    Team_P5_G5 == "P5" & Opp_P5_G5 == "G5" ~ "P5 vs G5",
    Team_P5_G5 == "G5" & Opp_P5_G5 == "P5" ~ "G5 vs P5",
    Team_P5_G5 == "P5" & Opp_P5_G5 == "P5" ~ "P5 vs P5",
    Team_P5_G5 == "G5" & Opp_P5_G5 == "G5" ~ "G5 vs G5"))
  
  
  # Team2 ----------------------------
  diffs2$Team <- Team2
  
  diffs2$Conference <- as.character(data %>% filter(Team == Team2) %>% select(Conference))
  
  diffs2$Opponent <- Team1
  
  diffs2$Opp_Conference <- as.character(data %>% filter(Team == Team1) %>% select(Conference))
  
  # P5 or G5?
  
  diffs2$Team_P5_G5 <- as.character(data %>% filter(Team == Team2) %>% select(Team_P5_G5))
  diffs2$Opp_P5_G5 <- as.character(data %>% filter(Team == Team1) %>% select(Team_P5_G5))
  diffs2 <- diffs2 %>% mutate(P5vG5 = case_when(
                            Team_P5_G5 == "P5" & Opp_P5_G5 == "G5" ~ "P5 vs G5",
                            Team_P5_G5 == "G5" & Opp_P5_G5 == "P5" ~ "G5 vs P5",
                            Team_P5_G5 == "P5" & Opp_P5_G5 == "P5" ~ "P5 vs P5",
                            Team_P5_G5 == "G5" & Opp_P5_G5 == "G5" ~ "G5 vs G5")
  )
  
  
  # Fixing Averaged CONF_Matchup, which needs to be swapped with what the data was trained on:
  
  diffs1$CONF_Matchup <-  diffs1$CONF_PWR
  diffs2$CONF_Matchup <-  diffs2$CONF_PWR
  
  # ===================================================================================
  
  # Getting random forest results for each possible arrangement. 
  rf1 = predict(rf, diffs1) 
  rf2 = predict(rf, diffs2) 
  class1 = predict(rfclass, diffs1, type = "prob")
  class2 = predict(rfclass, diffs2, type = "prob")
  
  
  # Averaging Everything
  rf_avg = round(mean(abs(c(rf1, rf2))), digits = 1)

  class_avg1 = round(mean(c(as.numeric(class1[2]), as.numeric(class2[1]))), digits = 3)
  
  class_avg2 = round(mean(c(as.numeric(class2[2]), as.numeric(class1[1]))), digits = 3)
  
  # Return Result ---------------------------------
  
  # Even though the classifier is about 80% accurate, the predicted probabilities feel 'off'. As such, we'll
  # Just report win/loss based on the outcome of the spread.
  return(list( result = paste(Team1, "is predicted to", ifelse(ifelse(rf1 >= rf2, -rf_avg, rf_avg) <= 0, "win", "lose"), "with a spread of", ifelse(rf1 >= rf2, -rf_avg, rf_avg)),
               diff_Score_pred = ifelse(rf1 >= rf2, rf_avg, -rf_avg)))
  
}




