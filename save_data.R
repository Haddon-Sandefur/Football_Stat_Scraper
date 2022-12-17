source("pull_espn.R")

sunbelt_teams <- c("Appalachian_State",
                   "Arkansas_State",
                   "Coastal_Carolina",
                   "Georgia_Southern")

sunbelt_list_home <- list()
sunbelt_list_away <- list()

for (i in 1:length(sunbelt_teams)) {
  
  sunbelt_list_home[[i]] <- pull_stats(paste("Games/Sun Belt/",paste(sunbelt_teams[i],"22","Home.txt", sep = "_"), sep = ""), 
                                       away = FALSE, 
                                       row_names = FALSE)$`Game Differentials`
  
  sunbelt_list_away[[i]] <- pull_stats(paste("Games/Sun Belt/",paste(sunbelt_teams[i],"22","Away.txt", sep = "_"), sep = ""), 
                                       away = TRUE,
                                       row_names = FALSE)$`Game Differentials`
  
  write.table(rbind(sb_away, sb_home))
  
}


sb_away <- do.call(rbind, sunbelt_list_away)
sb_home <- do.call(rbind, sunbelt_list_home)

sb <- rbind(sb_away, sb_home)

sb$Power <- 4

write.table(sb, file = "Games/Sun Belt/sbc_diffs.txt")


