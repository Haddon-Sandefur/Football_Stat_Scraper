# Sourcing Function
source("pull_stats.R")

library(tidyverse)

# Big12 ======================================================= ======================================================= =======================================================

Big12_teams <- c("Baylor",  # Vector of Conference Teams
                 "Iowa_State",
                 "Kansas",
                 "Kansas_State",
                 "Oklahoma",
                 "Oklahoma_State",
                 "TCU",
                 "Texas",
                 "Texas_Tech",
                 "West_Virginia")

Big12_list_home <- list() # Home List For Loop
Big12_list_away <- list() # Away List For Loop

for (i in 1:length(Big12_teams)) {
  
  Big12_list_home[[i]] <- pull_stats(paste("Games/Big12/",paste(Big12_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                     away = FALSE, 
                                     row_names = FALSE)$`Game Differentials` 
  
  Big12_list_away[[i]] <- pull_stats(paste("Games/Big12/",paste(Big12_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                     away = TRUE,
                                     row_names = FALSE)$`Game Differentials`
  
  Big12_list_home[[i]] <- Big12_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  Big12_list_away[[i]] <- Big12_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(Big12_list_home[[i]], Big12_list_away[[i]]), 
              file = (paste("Games/Big12/",paste(Big12_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(Big12_list_home[[i]], Big12_list_away[[i]])), digits = 3)), 
              file = (paste("Games/Big12/",paste(Big12_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}