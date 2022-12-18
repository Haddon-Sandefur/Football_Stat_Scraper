# Sourcing Function
source("pull_stats.R")

library(tidyverse)

# CUSA ======================================================= ======================================================= =======================================================

CUSA_teams <- c("Charlotte",  # Vector of Conference Teams
                 "Florida_Atlantic",
                 "Florida_International",
                 "Louisiana_Tech",
                 "Middle_Tennessee",
                 "North_Texas",
                 "Rice",
                 "UAB",
                 "UTEP",
                 "UTSA",
                "Western_Kentucky")

CUSA_list_home <- list() # Home List For Loop
CUSA_list_away <- list() # Away List For Loop

for (i in 1:length(CUSA_teams)) {
  
  CUSA_list_home[[i]] <- pull_stats(paste("Games/CUSA/",paste(CUSA_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                     away = FALSE, 
                                     row_names = FALSE)$`Game Differentials` 
  
  CUSA_list_away[[i]] <- pull_stats(paste("Games/CUSA/",paste(CUSA_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                     away = TRUE,
                                     row_names = FALSE)$`Game Differentials`
  
  CUSA_list_home[[i]] <- CUSA_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  CUSA_list_away[[i]] <- CUSA_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(CUSA_list_home[[i]], CUSA_list_away[[i]]), 
              file = (paste("Games/CUSA/",paste(CUSA_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(CUSA_list_home[[i]], CUSA_list_away[[i]])), digits = 3)), 
              file = (paste("Games/CUSA/",paste(CUSA_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}