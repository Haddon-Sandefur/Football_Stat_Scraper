source("pull_stats.R")

library(tidyverse)

# MountainWest ======================================================= ======================================================= =======================================================

MountainWest_teams <- c("Air_Force",  # Vector of Conference Teams
               "Boise_State",
               "Colorado_State",
               "Fresno_State",
               "Hawaii",
               "Nevada",
               "New_Mexico",
               "San_Diego_State",
               "San_Jose_State",
               "UNLV",
               "Utah_State",
               "Wyoming")

MountainWest_list_home <- list() # Home List For Loop
MountainWest_list_away <- list() # Away List For Loop

for (i in 1:length(MountainWest_teams)) {
  
  MountainWest_list_home[[i]] <- pull_stats(paste("Games/MountainWest/",paste(MountainWest_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                   away = FALSE, 
                                   row_names = FALSE)$`Game Differentials` 
  
  MountainWest_list_away[[i]] <- pull_stats(paste("Games/MountainWest/",paste(MountainWest_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                   away = TRUE,
                                   row_names = FALSE)$`Game Differentials`
  
  MountainWest_list_home[[i]] <- MountainWest_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  MountainWest_list_away[[i]] <- MountainWest_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(MountainWest_list_home[[i]], MountainWest_list_away[[i]]), 
              file = (paste("Games/MountainWest/",paste(MountainWest_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(MountainWest_list_home[[i]], MountainWest_list_away[[i]])), digits = 3)), 
              file = (paste("Games/MountainWest/",paste(MountainWest_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}