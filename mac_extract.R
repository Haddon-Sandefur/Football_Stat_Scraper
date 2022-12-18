source("pull_stats.R")

library(tidyverse)

# MAC ======================================================= ======================================================= =======================================================

MAC_teams <- c("Akron",  # Vector of Conference Teams
                       "Ball_State",
                       "Bowling_Green",
                       "Buffalo",
                       "Central_Michigan",
                       "Eastern_Michigan",
                       "Kent_State",
                       "Miami_OH",
                       "Northern_Illinois",
                       "Ohio",
                       "Toledo",
                       "Western_Michigan")

MAC_list_home <- list() # Home List For Loop
MAC_list_away <- list() # Away List For Loop

for (i in 1:length(MAC_teams)) {
  
  MAC_list_home[[i]] <- pull_stats(paste("Games/MAC/",paste(MAC_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                           away = FALSE, 
                                           row_names = FALSE)$`Game Differentials` 
  
  MAC_list_away[[i]] <- pull_stats(paste("Games/MAC/",paste(MAC_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                           away = TRUE,
                                           row_names = FALSE)$`Game Differentials`
  
  MAC_list_home[[i]] <- MAC_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  MAC_list_away[[i]] <- MAC_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(MAC_list_home[[i]], MAC_list_away[[i]]), 
              file = (paste("Games/MAC/",paste(MAC_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(MAC_list_home[[i]], MAC_list_away[[i]])), digits = 3)), 
              file = (paste("Games/MAC/",paste(MAC_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}