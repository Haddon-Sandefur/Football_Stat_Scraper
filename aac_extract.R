# Sourcing Function
source("pull_stats.R")

library(tidyverse)

# AAC ======================================================= ======================================================= =======================================================

aac_teams <- c("Cincinnati",  # Vector of Conference Teams
               "East_Carolina",
               "Houston",
               "Memphis",
               "Navy",
               "SMU",
               "South_Florida",
               "Temple",
               "Tulane",
               "Tulsa",
               "UCF")

aac_list_home <- list() # Home List For Loop
aac_list_away <- list() # Away List For Loop

for (i in 1:length(aac_teams)) {
  
  aac_list_home[[i]] <- pull_stats(paste("Games/AAC/",paste(aac_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                   away = FALSE, 
                                   row_names = FALSE)$`Game Differentials` 
  
  aac_list_away[[i]] <- pull_stats(paste("Games/AAC/",paste(aac_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                   away = TRUE,
                                   row_names = FALSE)$`Game Differentials`
  
  aac_list_home[[i]] <- aac_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  aac_list_away[[i]] <- aac_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(aac_list_home[[i]], aac_list_away[[i]]), 
              file = (paste("Games/AAC/",paste(aac_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(aac_list_home[[i]], aac_list_away[[i]])), digits = 3)), 
              file = (paste("Games/AAC/",paste(aac_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}