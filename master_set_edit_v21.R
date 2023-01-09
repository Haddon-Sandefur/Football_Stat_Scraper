df <- read.table("master_set_v2.txt")

library(dplyr)
library(tidyr)
# Removing rows where "TEAM" has an FCS team (sorry FCS fans, we'll eventually include y'all.)

# Just looking at the Team names:
sort(unique(df$Team))

# Getting the FCS team names by selecting ones which have less games than 5 (an FCS school will usually play AT MOST 2 FBS opponents)
FCS <- names(table(df$Team)[which(table(df$Team)<5)])

# Filtering these teams out.
df2 <- df %>% filter(!Team %in% FCS)

# Checking.... There are indeed 131 FBS teams so we know it worked.
length(sort(unique(df2$Team)))

# Adding Conference & Conference Power Rankings: =========================================================

aac_teams <-         c("CIN",  # Vector of Conference Teams
                       "ECU",
                       "HOU",
                       "MEM",
                       "NAVY",
                       "SMU",
                       "USF",
                       "TEM",
                       "TULN",
                       "TLSA",
                       "UCF")

ACC_teams <-         c("BC",  # Vector of Conference Teams
                       "CLEM",
                       "DUKE",
                       "FSU",
                       "GT",
                       "LOU",
                       "MIA",
                       "NCST",
                       "UNC",
                       "PITT",
                       "SYR",
                       "UVA",
                       "VT",
                       "WAKE")

Big10_teams <-       c("ILL",  # Vector of Conference Teams
                       "IU",
                       "IOWA",
                       "MD",
                       "MICH",
                       "MSU",
                       "MINN",
                       "NEB",
                       "NU",
                       "OSU",
                       "PSU",
                       "PUR",
                       "RUTG",
                       "WISC")

Big12_teams <-       c("BAY",  # Vector of Conference Teams
                       "ISU",
                       "KU",
                       "KSU",
                       "OU",
                       "OKST",
                       "TCU",
                       "TEX",
                       "TTU",
                       "WVU")

CUSA_teams <-        c("CLT",  # Vector of Conference Teams
                       "FAU",
                       "FIU",
                       "LT",
                       "MTSU",
                       "UNT",
                       "RICE",
                       "UAB",
                       "UTEP",
                       "UTSA",
                       "WKU")

Independent_low <-    c("ARMY",  # Vector of Conference Teams
                       "LIB",
                       "NMSU",
                       "CONN",
                       "MASS")

Independent_high <-   c("BYU",
                        "ND")
  


MAC_teams <-          c("AKR",  # Vector of Conference Teams
                        "BALL",
                        "BGSU",
                        "BUFF",
                        "CMU",
                        "EMU",
                        "KENT",
                        "M-OH",
                        "NIU",
                        "OHIO",
                        "TOL",
                        "WMU")

MountainWest_teams <- c("AFA",  # Vector of Conference Teams
                        "BOIS",
                        "CSU",
                        "FRES",
                        "HAW",
                        "NEV",
                        "UNM",
                        "SDSU",
                        "SJSU",
                        "UNLV",
                        "USU",
                        "WYO")

PAC12_teams <-        c("ARIZ",  # Vector of Conference Teams
                        "ASU",
                        "CAL",
                        "COLO",
                        "ORE",
                        "ORST",
                        "STAN",
                        "UCLA",
                        "USC",
                        "UTAH",
                        "WASH",
                        "WSU")

SEC_teams <-          c("ALA",  # Vector of Conference Teams
                        "ARK",
                        "AUB",
                        "FLA",
                        "UGA",
                        "UK",
                        "LSU",
                        "MSST",
                        "MIZ",
                        "MISS",
                        "SC",
                        "TENN",
                        "TA&M",
                        "VAN")

sunbelt_teams <-      c("APP",  # Vector of Conference Teams
                        "ARST",
                        "CCU",
                        "GASO",
                        "GAST",
                        "JMU",
                        "UL",
                        "ULM",
                        "MRSH",
                        "ODU",
                        "USA",
                        "USM",
                        "TXST",
                        "TROY")

# Adding Conference Variable:

df2 <- df2 %>%  mutate(Conference = case_when(Team %in% ACC_teams ~ "ACC",
                                              Team %in% aac_teams ~ "AAC",
                                              Team %in% Big10_teams ~ "BIG10",
                                              Team %in% Big12_teams ~ "BIG12",
                                              Team %in% CUSA_teams ~ "CUSA",
                                              Team %in% MountainWest_teams ~ "MW",
                                              Team %in% MAC_teams ~ "MAC",
                                              Team %in% PAC12_teams ~ "PAC12",
                                              Team %in% SEC_teams ~ "SEC",
                                              Team %in% sunbelt_teams ~ "SBC",
                                              Team %in% Independent_low ~ "Ind_Low",
                                              Team %in% Independent_high ~ "Ind_High"),
                       
                       Opp_Conference = case_when(Opponent %in% ACC_teams ~ "ACC",
                                                  Opponent %in% aac_teams ~ "AAC",
                                                  Opponent %in% Big10_teams ~ "BIG10",
                                                  Opponent %in% Big12_teams ~ "BIG12",
                                                  Opponent %in% CUSA_teams ~ "CUSA",
                                                  Opponent %in% MountainWest_teams ~ "MW",
                                                  Opponent %in% MAC_teams ~ "MAC",
                                                  Opponent %in% PAC12_teams ~ "PAC12",
                                                  Opponent %in% SEC_teams ~ "SEC",
                                                  Opponent %in% sunbelt_teams ~ "SBC",
                                                  Opponent %in% Independent_low ~ "Ind_Low",
                                                  Opponent %in% Independent_high ~ "Ind_High"),
                       
                       
                
                       CONF_PWR =  case_when(Conference == "SEC" ~ 22,
                                             Conference == "BIG10" ~ 21,
                                             Conference == "BIG12" ~ 20,
                                             Conference == "PAC12" ~ 19,
                                             Conference == "Ind_High" ~ 18,
                                             Conference == "ACC" ~ 17,
                                             Conference == "AAC" ~ 11,
                                             Conference == "SBC" ~ 5,
                                             Conference == "MW" ~ 4,
                                             Conference == "Ind_Low" ~ 3,
                                             Conference == "CUSA" ~ 2,
                                             Conference ==  "MAC" ~ 1),
                
                      OPP_CONF_PWR = case_when(Opp_Conference == "SEC" ~ 22,
                                               Opp_Conference == "BIG10" ~ 21,
                                               Opp_Conference == "BIG12" ~ 20,
                                               Opp_Conference == "PAC12" ~ 19,
                                               Opp_Conference == "Ind_High" ~ 18,
                                               Opp_Conference == "ACC" ~ 17,
                                               Opp_Conference == "AAC" ~ 11,
                                               Opp_Conference == "SBC" ~ 5,
                                               Opp_Conference == "MW" ~ 4,
                                               Opp_Conference == "Ind_Low" ~ 3,
                                               Opp_Conference == "CUSA" ~ 2,
                                               Opp_Conference ==  "MAC" ~ 1,
                                               Opp_Conference ==  NA ~ 0),
                      
                      Team_P5_G5 = case_when(Team %in% ACC_teams ~ "P5",
                                             Team %in% aac_teams ~ "G5",
                                             Team %in% Big10_teams ~ "P5",
                                             Team %in% Big12_teams ~ "P5",
                                             Team %in% CUSA_teams ~ "G5",
                                             Team %in% MountainWest_teams ~ "G5",
                                             Team %in% MAC_teams ~ "G5",
                                             Team %in% PAC12_teams ~ "P5",
                                             Team %in% SEC_teams ~ "P5",
                                             Team %in% sunbelt_teams ~ "G5",
                                             Team %in% Independent_low ~ "G5",
                                             Team %in% Independent_high ~ "P5"),
                      
                      Opp_P5_G5 = case_when( Opponent %in% ACC_teams ~ "P5",
                                             Opponent %in% aac_teams ~ "G5",
                                             Opponent %in% Big10_teams ~ "P5",
                                             Opponent %in% Big12_teams ~ "P5",
                                             Opponent %in% CUSA_teams ~ "G5",
                                             Opponent %in% MountainWest_teams ~ "G5",
                                             Opponent %in% MAC_teams ~ "G5",
                                             Opponent %in% PAC12_teams ~ "P5",
                                             Opponent %in% SEC_teams ~ "P5",
                                             Opponent %in% sunbelt_teams ~ "G5",
                                             Opponent %in% Independent_low ~ "G5",
                                             Opponent %in% Independent_high ~ "P5")
                
                
                )
# Adding FCS to those which are NA
 df2 <- df2 %>% replace_na(list(Opp_Conference = "FCS", OPP_CONF_PWR = 0, Opp_P5_G5 = "G5")) %>% 
   mutate(CONF_Matchup = CONF_PWR - OPP_CONF_PWR,
          P5vG5 = case_when(Team_P5_G5 == "P5" & Opp_P5_G5 == "G5" ~ "P5 vs G5",
                            Team_P5_G5 == "G5" & Opp_P5_G5 == "P5" ~ "G5 vs P5",
                            Team_P5_G5 == "P5" & Opp_P5_G5 == "P5" ~ "P5 vs P5",
                            Team_P5_G5 == "G5" & Opp_P5_G5 == "G5" ~ "G5 vs G5"))

# Done =====================================================================================

# Writing File
write.table(df2, "master_set_v21.txt")

# Update Season Averages Dataset With Conference Information ===============================

# Recreate Season Averages Dataset with "master_set_v21.txt" that we just wrote.

master_avg2 <- df2 %>% group_by(Team) %>% summarise(across(where(is.numeric), mean))

# Round all of the results to three decimal places, add the Team name column back into the set:
master_avg2 <- cbind(master_avg2["Team"], round(master_avg2[2:ncol(master_avg2)], digits = 3))

# Merge Conference Names and P5 Status into this new dataset using dfa_c
dfa_c <- df2 %>% group_by(Team) %>% 
  select(Team, Conference, Team_P5_G5) %>% unique()

master_avg2 <- merge(master_avg2, dfa_c, by = "Team")

# Write File:
write.table(master_avg2, "master_avg_v21.txt")

