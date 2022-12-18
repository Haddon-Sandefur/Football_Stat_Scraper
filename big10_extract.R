# Sourcing Function
source("pull_stats.R")

library(tidyverse)

# Big10 ======================================================= ======================================================= =======================================================

Big10_teams <- c("Illinois",  # Vector of Conference Teams
               "Indiana",
               "Iowa",
               "Maryland",
               "Michigan",
               "Michigan_State",
               "Minnesota",
               "Nebraska",
               "Northwestern",
               "Ohio_State",
               "Penn_State",
               "Purdue",
               "Rutgers",
               "Wisconsin")

Big10_list_home <- list() # Home List For Loop
Big10_list_away <- list() # Away List For Loop

for (i in 1:length(Big10_teams)) {
  
  Big10_list_home[[i]] <- pull_stats(paste("Games/Big10/",paste(Big10_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                   away = FALSE, 
                                   row_names = FALSE)$`Game Differentials` 
  
  Big10_list_away[[i]] <- pull_stats(paste("Games/Big10/",paste(Big10_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                   away = TRUE,
                                   row_names = FALSE)$`Game Differentials`
  
  Big10_list_home[[i]] <- Big10_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  Big10_list_away[[i]] <- Big10_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(Big10_list_home[[i]], Big10_list_away[[i]]), 
              file = (paste("Games/Big10/",paste(Big10_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(Big10_list_home[[i]], Big10_list_away[[i]])), digits = 3)), 
              file = (paste("Games/Big10/",paste(Big10_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}