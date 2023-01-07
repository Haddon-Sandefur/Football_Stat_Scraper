library(tidyverse)

source("pull_stats_v2.R")

# We're going to collect all of the data from EVERY college football game during the regular season.

# This is rather annoying to the nice people at ESPN, so we're going to do this operation bit by bit.
# As such, we'll partition the links read into chunks, then tell R to sleep for 3 seconds, then do the next chunk.

nrow(read.table("links.txt"))

skip_me <- seq(from = 0, to = nrow(read.table("links.txt"))-50, by = 50)

read.this.many.lines <- c(rep(50, 16), nrow(read.table("links.txt")) - max(skip_me))

# Initialize:

home <- list()

# Get Home Game Data
for (i in 1:length(read.this.many.lines)){
  
home[[i]] <- pull_stats("links.txt", away = FALSE, 
                        row_names = FALSE, 
                        nrows = read.this.many.lines[i], 
                        skip = skip_me[i])$`Game Differentials`

Sys.sleep(3)

}


# Initialize:

away <- list()

# Get away Game Data
for (i in 1:length(read.this.many.lines)){
  
  away[[i]] <- pull_stats("links.txt", away = TRUE, 
                          row_names = FALSE, 
                          nrows = read.this.many.lines[i], 
                          skip = skip_me[i])$`Game Differentials`
  
  Sys.sleep(3)
  
}


# Combine Scraped Data Into Master File

master_set_home <- do.call(rbind, home)
master_set_away <- do.call(rbind, away)

master_set <- rbind(master_set_home,master_set_away)

# Write Dataset

write.table(master_set, file = "master_set_v2.txt", sep = " ")

# Get Season Averages for Each Team and save as Dataframe:

master_avg <- master_set %>% group_by(Team) %>% summarise(across(where(is.numeric), mean))

# Round all of the results to three decimal places:

master_avg <- cbind(ssn_avg["Team"],round(ssn_avg[2:ncol(ssn_avg)], digits = 3))

# Write File

write.table(master_avg, "master_avg_v2.txt")

