
#======================== Sun Belt ==========================================================
# Sun Belt Getting Season game stat diffs for Sun Belt Teams

source("pull_espn.R")

sunbelt_teams <- c("Appalachian_State",
                   "Arkansas_State",
                   "Coastal_Carolina",
                   "Georgia_Southern",
                   "James_Madison")

sunbelt_list_home <- list()
sunbelt_list_away <- list()

for (i in 1:length(sunbelt_teams)) {
  
  sunbelt_list_home[[i]] <- pull_stats(paste("Games/Sun Belt/",paste(sunbelt_teams[i],"22","Home.txt", sep = "_"), sep = ""), 
                                       away = FALSE, 
                                       row_names = FALSE)$`Game Differentials`
  
  sunbelt_list_away[[i]] <- pull_stats(paste("Games/Sun Belt/",paste(sunbelt_teams[i],"22","Away.txt", sep = "_"), sep = ""), 
                                       away = TRUE,
                                       row_names = FALSE)$`Game Differentials`
  
}


sb_away <- do.call(rbind, sunbelt_list_away)
sb_home <- do.call(rbind, sunbelt_list_home)

sb <- rbind(sb_away, sb_home)

sb$Power <- 4

# ======================================ACC====================================================

# Vector of Names to get text file names from
acc_teams <- c("Boston_College",
                   "Clemson",
                   "Duke",
                   "Florida_State",
                   "Georgia_Tech")

# Storing
acc_list_home <- list()
acc_list_away <- list()

# Pull Season Game Differentials for each team 

for (i in 1:length(acc_teams)) {
  
  acc_list_home[[i]] <- pull_stats(paste("Games/ACC/",paste(acc_teams[i],"22","Home.txt", sep = "_"), sep = ""), 
                                       away = FALSE, 
                                       row_names = FALSE)$`Game Differentials`
  
  acc_list_away[[i]] <- pull_stats(paste("Games/ACC/",paste(acc_teams[i],"22","Away.txt", sep = "_"), sep = ""), 
                                       away = TRUE,
                                       row_names = FALSE)$`Game Differentials`
  
  
}

# Unpacking and Binding
acc_away <- do.call(rbind, acc_list_away)
acc_home <- do.call(rbind, acc_list_home)

# Binding Home and Away Differential Games
acc <- rbind(acc_away, acc_home)

# Assigning Power Level
acc$Power <- 7




