library(tidyverse)

test <- pull_stats("Duke_22_Home.txt", away = FALSE)

test$`Game Differentials`


row.names(test$`Game List`[[1]][1,])


marshall <- read.table("Games/Sun Belt/Marshall_22_season_diffs.txt")
gs <- read.table("Games/Sun Belt/Georgia_Southern_22_season_diffs.txt")


test_1 <- transpose(data.frame(colMeans(gs)-colMeans(marshall)))
colnames(test_1) <- colnames(gs)

test_1
