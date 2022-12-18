source("pull_stats.R")

library(tidyverse)

# PAC12 ======================================================= ======================================================= =======================================================

PAC12_teams <- c("Arizona",  # Vector of Conference Teams
                        "Arizona_State",
                        "California",
                        "Colorado",
                        "Oregon",
                        "Oregon_State",
                        "Stanford",
                        "UCLA",
                        "USC",
                        "Utah",
                        "Washington",
                        "Washington_State")

PAC12_list_home <- list() # Home List For Loop
PAC12_list_away <- list() # Away List For Loop

for (i in 1:length(PAC12_teams)) {
  
  PAC12_list_home[[i]] <- pull_stats(paste("Games/PAC12/",paste(PAC12_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                            away = FALSE, 
                                            row_names = FALSE)$`Game Differentials` 
  
  PAC12_list_away[[i]] <- pull_stats(paste("Games/PAC12/",paste(PAC12_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                            away = TRUE,
                                            row_names = FALSE)$`Game Differentials`
  
  PAC12_list_home[[i]] <- PAC12_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  PAC12_list_away[[i]] <- PAC12_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(PAC12_list_home[[i]], PAC12_list_away[[i]]), 
              file = (paste("Games/PAC12/",paste(PAC12_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(PAC12_list_home[[i]], PAC12_list_away[[i]])), digits = 3)), 
              file = (paste("Games/PAC12/",paste(PAC12_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}