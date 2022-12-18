# Sourcing Function
source("pull_stats.R")

library(tidyverse)

# ACC ======================================================= ======================================================= =======================================================

ACC_teams <- c("Boston_College",  # Vector of Conference Teams
               "Clemson",
               "Duke",
               "Florida_State",
               "Georgia_Tech",
               "Louisville",
               "Miami",
               "NC_State",
               "North_Carolina",
               "Pittsburgh",
               "Syracuse",
               "Virginia",
               "Virginia_Tech",
               "Wake_Forest")

ACC_list_home <- list() # Home List For Loop
ACC_list_away <- list() # Away List For Loop

for (i in 1:length(ACC_teams)) {
  
  ACC_list_home[[i]] <- pull_stats(paste("Games/ACC/",paste(ACC_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                   away = FALSE, 
                                   row_names = FALSE)$`Game Differentials` 
  
  ACC_list_away[[i]] <- pull_stats(paste("Games/ACC/",paste(ACC_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                   away = TRUE,
                                   row_names = FALSE)$`Game Differentials`
  
  ACC_list_home[[i]] <- ACC_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  ACC_list_away[[i]] <- ACC_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(ACC_list_home[[i]], ACC_list_away[[i]]), 
              file = (paste("Games/ACC/",paste(ACC_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(ACC_list_home[[i]], ACC_list_away[[i]])), digits = 3)), 
              file = (paste("Games/ACC/",paste(ACC_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}