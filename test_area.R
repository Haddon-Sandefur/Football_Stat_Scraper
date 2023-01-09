source("predict_matchups_v21.R")
load("rf.rda")
load("rfclass.rda")

matchup("UGA", "TCU", data = df_avg)[1]
