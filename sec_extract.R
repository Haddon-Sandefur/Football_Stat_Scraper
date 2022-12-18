source("pull_stats.R")

library(tidyverse)

# SEC ======================================================= ======================================================= =======================================================

SEC_teams <- c("Alabama",  # Vector of Conference Teams
                 "Arkansas",
                 "Auburn",
                 "Florida",
                 "Georgia",
                 "Kentucky",
                 "LSU",
                 "Mississippi_State",
                 "Missouri",
                 "Ole_Miss",
                 "South_Carolina",
                 "Tennessee",
               "Texas_A&M",
               "Vanderbilt")

SEC_list_home <- list() # Home List For Loop
SEC_list_away <- list() # Away List For Loop

for (i in 1:length(SEC_teams)) {
  
  SEC_list_home[[i]] <- pull_stats(paste("Games/SEC/",paste(SEC_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                     away = FALSE, 
                                     row_names = FALSE)$`Game Differentials` 
  
  SEC_list_away[[i]] <- pull_stats(paste("Games/SEC/",paste(SEC_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                     away = TRUE,
                                     row_names = FALSE)$`Game Differentials`
  
  SEC_list_home[[i]] <- SEC_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  SEC_list_away[[i]] <- SEC_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(SEC_list_home[[i]], SEC_list_away[[i]]), 
              file = (paste("Games/SEC/",paste(SEC_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(SEC_list_home[[i]], SEC_list_away[[i]])), digits = 3)), 
              file = (paste("Games/SEC/",paste(SEC_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}