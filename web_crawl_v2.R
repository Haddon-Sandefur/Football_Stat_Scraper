library(tidyverse)
library(rvest)
library(Rcrawler)
library(stringr)


# Specify No. Weeks (Up to 15, Bowls are afterwards)
weeks <- 15
links <- list()

for (i in 1:weeks){
  
  # Read Links on ESPN Scoreboard Webpages by Week (represented as "i" in this loop)
  links[[i]] <- LinkExtractor(url = paste("https://www.espn.com/college-football/scoreboard/_/week/", i, "/year/2022/seasontype/2/group/80", sep = ""), ExternalLInks = FALSE) 
  
  # Filter by links that point to the game matchup.
  links[[i]]$InternalLinks <- links[[i]]$InternalLinks[str_detect(links[[i]]$InternalLinks, pattern = "/game/_/gameId") == TRUE]
  
  # Replace "game/" with "matchup/" which is where the stats are stored
  links[[i]] <- links[[i]]$InternalLinks %>% str_replace(pattern = "game/", replacement = "matchup/")
  
}

# Combining all Weeks
links <- do.call(c, links)

# Save as a text file:
write.table(links, file = "links.txt", row.names = FALSE, quote = FALSE, col.names = FALSE)




