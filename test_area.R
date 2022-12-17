library(tidyverse)


source("game_harvester.R")

test <- pull_stats("Game_Links_Away.txt", away = TRUE)

test[[1]] %>% 
  mutate(Penalties = as.numeric(word(Penalties, start = -1, sep = "-")),
         `3rd down efficiency` = round(ifelse(
                                 as.numeric(
                                 word(`3rd down efficiency`, start = -1, sep = "-")) == 0,
                                  as.numeric(
                                    word(`3rd down efficiency`, start = 1, sep = "-")),
                                  as.numeric(
                                   word(`3rd down efficiency`, start = 1, sep = "-"))/
                                   as.numeric(
                                   word(`3rd down efficiency`, start = -1, sep = "-"))),
                                 digits = 3),
         
         `4th down efficiency` = round(ifelse(
                                  as.numeric(
                                    word(`4th down efficiency`, start = -1, sep = "-")) == 0,
                                  as.numeric(
                                    word(`4th down efficiency`, start = 1, sep = "-")),
                                  as.numeric(
                                    word(`4th down efficiency`, start = 1, sep = "-"))/
                                    as.numeric(
                                      word(`4th down efficiency`, start = -1, sep = "-"))), 
                                  digits = 3),
         
                    `Comp-Att` = round(ifelse(
                                  as.numeric(
                                    word(`Comp-Att`, start = -1, sep = "-")) == 0,
                                  as.numeric(
                                    word(`Comp-Att`, start = 1, sep = "-")),
                                  as.numeric(
                                    word(`Comp-Att`, start = 1, sep = "-"))/
                                    as.numeric(
                                      word(`Comp-Att`, start = -1, sep = "-"))), 
                                  digits = 3),
         
         Possession = round(as.numeric(word(Possession, start = 1, sep = ":"))+
                            as.numeric(word(Possession, start = -1, sep = ":"))/60, 
                          digits = 2)
         )

glimpse(test[[1]])


test[[1]]$Penalties


word(test[[1]]$Penalties, start = -1, sep = "-")


