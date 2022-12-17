sunbelt_teams <- c("Appalachian_State",
                   "Arkansas_State",
                   "Coastal_Carolina",
                   "Georgia_Southern")

for (i in 1:length(sunbelt_teams)) {
  
  sunbelt_list_home[[i]] <- pull_stats(paste("Games/Sun Belt/",paste(sunbelt_teams[i],"22","Home.txt", sep = "_"), sep = ""), 
                                       away = FALSE, 
                                       row_names = TRUE)$`Game Differentials`
  
  sunbelt_list_away[[i]] <- pull_stats(paste("Games/Sun Belt/",paste(sunbelt_teams[i],"22","Away.txt", sep = "_"), sep = ""), 
                                       away = TRUE,
                                       row_names = TRUE)$`Game Differentials`
  
  write.table(rbind(sunbelt_list_home[[i]], sunbelt_list_away[[i]]), file = (paste("Games/Sun Belt/",paste(sunbelt_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
}
  