# Sourcing Function
source("pull_stats.R")

library(tidyverse)

# AAC ======================================================= ======================================================= =======================================================

aac_teams <- c("Cincinnati",  # Vector of Conference Teams
               "East_Carolina",
               "Houston",
               "Memphis",
               "Navy",
               "SMU",
               "South_Florida",
               "Temple",
               "Tulane",
               "Tulsa",
               "UCF")

aac_list_home <- list() # Home List For Loop
aac_list_away <- list() # Away List For Loop

for (i in 1:length(aac_teams)) {
  
  aac_list_home[[i]] <- pull_stats(paste("Games/AAC/",paste(aac_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                   away = FALSE, 
                                   row_names = FALSE)$`Game Differentials` 
  
  aac_list_away[[i]] <- pull_stats(paste("Games/AAC/",paste(aac_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                   away = TRUE,
                                   row_names = FALSE)$`Game Differentials`
  
  aac_list_home[[i]] <- aac_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  aac_list_away[[i]] <- aac_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(aac_list_home[[i]], aac_list_away[[i]]), 
              file = (paste("Games/AAC/",paste(aac_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(aac_list_home[[i]], aac_list_away[[i]])), digits = 3)), 
              file = (paste("Games/AAC/",paste(aac_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}

# ACC ======================================================= ======================================================= =======================================================

ACC_teams <- c("Boston_College",  # Vector of Conference Teams
               "Clemson",
               "Duke",
               "Florida_State",
               "Georgia_Tech",
               "Louisville",
               "Miami",
               "NC_State",
               "North_Carolina",
               "Pittsburgh",
               "Syracuse",
               "Virginia",
               "Virginia_Tech",
               "Wake_Forest")

ACC_list_home <- list() # Home List For Loop
ACC_list_away <- list() # Away List For Loop

for (i in 1:length(ACC_teams)) {
  
  ACC_list_home[[i]] <- pull_stats(paste("Games/ACC/",paste(ACC_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                   away = FALSE, 
                                   row_names = FALSE)$`Game Differentials` 
  
  ACC_list_away[[i]] <- pull_stats(paste("Games/ACC/",paste(ACC_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                   away = TRUE,
                                   row_names = FALSE)$`Game Differentials`
  
  ACC_list_home[[i]] <- ACC_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  ACC_list_away[[i]] <- ACC_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(ACC_list_home[[i]], ACC_list_away[[i]]), 
              file = (paste("Games/ACC/",paste(ACC_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(ACC_list_home[[i]], ACC_list_away[[i]])), digits = 3)), 
              file = (paste("Games/ACC/",paste(ACC_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}

# Big10 ======================================================= ======================================================= =======================================================

Big10_teams <- c("Illinois",  # Vector of Conference Teams
                 "Indiana",
                 "Iowa",
                 "Maryland",
                 "Michigan",
                 "Michigan_State",
                 "Minnesota",
                 "Nebraska",
                 "Northwestern",
                 "Ohio_State",
                 "Penn_State",
                 "Purdue",
                 "Rutgers",
                 "Wisconsin")

Big10_list_home <- list() # Home List For Loop
Big10_list_away <- list() # Away List For Loop

for (i in 1:length(Big10_teams)) {
  
  Big10_list_home[[i]] <- pull_stats(paste("Games/Big10/",paste(Big10_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                     away = FALSE, 
                                     row_names = FALSE)$`Game Differentials` 
  
  Big10_list_away[[i]] <- pull_stats(paste("Games/Big10/",paste(Big10_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                     away = TRUE,
                                     row_names = FALSE)$`Game Differentials`
  
  Big10_list_home[[i]] <- Big10_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  Big10_list_away[[i]] <- Big10_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(Big10_list_home[[i]], Big10_list_away[[i]]), 
              file = (paste("Games/Big10/",paste(Big10_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(Big10_list_home[[i]], Big10_list_away[[i]])), digits = 3)), 
              file = (paste("Games/Big10/",paste(Big10_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}

# Big12 ======================================================= ======================================================= =======================================================

Big12_teams <- c("Baylor",  # Vector of Conference Teams
                 "Iowa_State",
                 "Kansas",
                 "Kansas_State",
                 "Oklahoma",
                 "Oklahoma_State",
                 "TCU",
                 "Texas",
                 "Texas_Tech",
                 "West_Virginia")

Big12_list_home <- list() # Home List For Loop
Big12_list_away <- list() # Away List For Loop

for (i in 1:length(Big12_teams)) {
  
  Big12_list_home[[i]] <- pull_stats(paste("Games/Big12/",paste(Big12_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                     away = FALSE, 
                                     row_names = FALSE)$`Game Differentials` 
  
  Big12_list_away[[i]] <- pull_stats(paste("Games/Big12/",paste(Big12_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                     away = TRUE,
                                     row_names = FALSE)$`Game Differentials`
  
  Big12_list_home[[i]] <- Big12_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  Big12_list_away[[i]] <- Big12_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(Big12_list_home[[i]], Big12_list_away[[i]]), 
              file = (paste("Games/Big12/",paste(Big12_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(Big12_list_home[[i]], Big12_list_away[[i]])), digits = 3)), 
              file = (paste("Games/Big12/",paste(Big12_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}

# CUSA ======================================================= ======================================================= =======================================================

CUSA_teams <- c("Charlotte",  # Vector of Conference Teams
                "Florida_Atlantic",
                "Florida_International",
                "Louisiana_Tech",
                "Middle_Tennessee",
                "North_Texas",
                "Rice",
                "UAB",
                "UTEP",
                "UTSA",
                "Western_Kentucky")

CUSA_list_home <- list() # Home List For Loop
CUSA_list_away <- list() # Away List For Loop

for (i in 1:length(CUSA_teams)) {
  
  CUSA_list_home[[i]] <- pull_stats(paste("Games/CUSA/",paste(CUSA_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                    away = FALSE, 
                                    row_names = FALSE)$`Game Differentials` 
  
  CUSA_list_away[[i]] <- pull_stats(paste("Games/CUSA/",paste(CUSA_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                    away = TRUE,
                                    row_names = FALSE)$`Game Differentials`
  
  CUSA_list_home[[i]] <- CUSA_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  CUSA_list_away[[i]] <- CUSA_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(CUSA_list_home[[i]], CUSA_list_away[[i]]), 
              file = (paste("Games/CUSA/",paste(CUSA_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(CUSA_list_home[[i]], CUSA_list_away[[i]])), digits = 3)), 
              file = (paste("Games/CUSA/",paste(CUSA_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}

# Independent ======================================================= ======================================================= =======================================================

Independent_teams <- c("Army",  # Vector of Conference Teams
                       "BYU",
                       "Liberty",
                       "New_Mexico_State",
                       "Notre_Dame",
                       "UConn",
                       "UMass")

Independent_list_home <- list() # Home List For Loop
Independent_list_away <- list() # Away List For Loop

for (i in 1:length(Independent_teams)) {
  
  Independent_list_home[[i]] <- pull_stats(paste("Games/Independent/",paste(Independent_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                           away = FALSE, 
                                           row_names = FALSE)$`Game Differentials` 
  
  Independent_list_away[[i]] <- pull_stats(paste("Games/Independent/",paste(Independent_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                           away = TRUE,
                                           row_names = FALSE)$`Game Differentials`
  
  Independent_list_home[[i]] <- Independent_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  Independent_list_away[[i]] <- Independent_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(Independent_list_home[[i]], Independent_list_away[[i]]), 
              file = (paste("Games/Independent/",paste(Independent_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(Independent_list_home[[i]], Independent_list_away[[i]])), digits = 3)), 
              file = (paste("Games/Independent/",paste(Independent_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}


# MAC ======================================================= ======================================================= =======================================================

MAC_teams <- c("Akron",  # Vector of Conference Teams
               "Ball_State",
               "Bowling_Green",
               "Buffalo",
               "Central_Michigan",
               "Eastern_Michigan",
               "Kent_State",
               "Miami_OH",
               "Northern_Illinois",
               "Ohio",
               "Toledo",
               "Western_Michigan")

MAC_list_home <- list() # Home List For Loop
MAC_list_away <- list() # Away List For Loop

for (i in 1:length(MAC_teams)) {
  
  MAC_list_home[[i]] <- pull_stats(paste("Games/MAC/",paste(MAC_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                   away = FALSE, 
                                   row_names = FALSE)$`Game Differentials` 
  
  MAC_list_away[[i]] <- pull_stats(paste("Games/MAC/",paste(MAC_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                   away = TRUE,
                                   row_names = FALSE)$`Game Differentials`
  
  MAC_list_home[[i]] <- MAC_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  MAC_list_away[[i]] <- MAC_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(MAC_list_home[[i]], MAC_list_away[[i]]), 
              file = (paste("Games/MAC/",paste(MAC_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(MAC_list_home[[i]], MAC_list_away[[i]])), digits = 3)), 
              file = (paste("Games/MAC/",paste(MAC_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}

# MountainWest ======================================================= ======================================================= =======================================================

MountainWest_teams <- c("Air_Force",  # Vector of Conference Teams
                        "Boise_State",
                        "Colorado_State",
                        "Fresno_State",
                        "Hawaii",
                        "Nevada",
                        "New_Mexico",
                        "San_Diego_State",
                        "San_Jose_State",
                        "UNLV",
                        "Utah_State",
                        "Wyoming")

MountainWest_list_home <- list() # Home List For Loop
MountainWest_list_away <- list() # Away List For Loop

for (i in 1:length(MountainWest_teams)) {
  
  MountainWest_list_home[[i]] <- pull_stats(paste("Games/MountainWest/",paste(MountainWest_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                            away = FALSE, 
                                            row_names = FALSE)$`Game Differentials` 
  
  MountainWest_list_away[[i]] <- pull_stats(paste("Games/MountainWest/",paste(MountainWest_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                            away = TRUE,
                                            row_names = FALSE)$`Game Differentials`
  
  MountainWest_list_home[[i]] <- MountainWest_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  MountainWest_list_away[[i]] <- MountainWest_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(MountainWest_list_home[[i]], MountainWest_list_away[[i]]), 
              file = (paste("Games/MountainWest/",paste(MountainWest_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(MountainWest_list_home[[i]], MountainWest_list_away[[i]])), digits = 3)), 
              file = (paste("Games/MountainWest/",paste(MountainWest_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}


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

# Sun Belt ======================================================= ======================================================= =======================================================

sunbelt_teams <- c("Appalachian_State",  # Vector of Conference Teams
                   "Arkansas_State",
                   "Coastal_Carolina",
                   "Georgia_Southern",
                   "James_Madison",
                   "Louisiana",
                   "Louisiana_Monroe",
                   "Marshall",
                   "Old_Dominion",
                   "South_Alabama",
                   "Southern_Miss",
                   "Texas_State",
                   "Troy")

sunbelt_list_home <- list() # Home List For Loop
sunbelt_list_away <- list() # Away List For Loop

for (i in 1:length(sunbelt_teams)) {
  
  sunbelt_list_home[[i]] <- pull_stats(paste("Games/Sun Belt/",paste(sunbelt_teams[i],"22","Home.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Home)
                                       away = FALSE, 
                                       row_names = FALSE)$`Game Differentials` 
  
  sunbelt_list_away[[i]] <- pull_stats(paste("Games/Sun Belt/",paste(sunbelt_teams[i],"22","Away.txt", sep = "_"), sep = ""), #Get Differentials for Each game for Each Team (Away)
                                       away = TRUE,
                                       row_names = FALSE)$`Game Differentials`
  
  sunbelt_list_home[[i]] <- sunbelt_list_home[[i]][-c(17:20)] # Remove Character Vectors (Home)
  
  
  sunbelt_list_away[[i]] <- sunbelt_list_away[[i]][-c(17:20)] # Remove Character Vectors (Away)
  
  write.table(rbind(sunbelt_list_home[[i]], sunbelt_list_away[[i]]), 
              file = (paste("Games/Sun Belt/",paste(sunbelt_teams[i],"22","season","diffs.txt", sep = "_"), sep = "")))
  
  # Getting Col Means of the Season Differentials by team and Transposing it (colmeans tranpsoses it, so I have to transpose it back)
  write.table(t(round(colMeans(rbind(sunbelt_list_home[[i]], sunbelt_list_away[[i]])), digits = 3)), 
              file = (paste("Games/Sun Belt/",paste(sunbelt_teams[i],"22","season","diffs","mean.txt", sep = "_"), sep = "")))
}