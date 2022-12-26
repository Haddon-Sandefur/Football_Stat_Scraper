import pandas as pd
import numpy as np
import matplotlib as plot
import os 

from sklearn import model_selection
from sklearn.linear_model import LogisticRegression
from sklearn import metrics
from sklearn import ensemble
from sklearn import model_selection

# Set Directory
os.chdir("OneDrive/Documents/GitHub/Football_Stat_Scraper")

# Random Forest (Regression)
rfr = ensemble.RandomForestRegressor(random_state=0)

# Function that takes Season Averages and takes difference. (Order Sensitive)
# You need the conference for each team. Team names must be written as expressed in their text file name.
def team_diffs(conference1, team1, conference2, team2):
    my_string1 = ["Games/", conference1, "/", team1,"_22_season_diffs_mean.txt"] # Team One File Path
    my_string2 = ["Games/", conference2, "/", team2,"_22_season_diffs_mean.txt"] # Team Two File Path
    team1_avg = pd.read_table("".join(my_string1), sep=" ") # Read Team 1 Data
    team2_avg = pd.read_table("".join(my_string2), sep=" ") # Read Team 2 Data
    diff_df = team1_avg.subtract(team2_avg) # Subtract Team Averages
    return(diff_df)

# Read Dataset (Conference Power Rankings to be added later)

df = pd.read_table("master_set.txt", sep=" ").drop(columns=["Result", "Result_num", "Opponent", "Team", "Power"])

# 75/25 split
x_train, x_test, y_train, y_test = model_selection.train_test_split(df.drop(columns=["diff_Score"]), df["diff_Score"], test_size=0.25, random_state=0)

# Random Forest Specification

## Params for Random Forest
param_grid = {
    'n_estimators': [100],
    'max_depth': [9],
    
}

# Create Model
model = model_selection.GridSearchCV(rfr, param_grid, cv=10)


# Fit Model

fit = model.fit(x_train, y_train)

# Games (There is a more efficient way of doing this but the x-mas meals have made me full and subsequently lazy...for now):
BGSUvNMS = team_diffs("MAC", "Bowling_Green", "Independent", "New_Mexico_State" ).drop(columns="diff_Score")
WAKEvMIZZ = team_diffs("ACC", "Wake_Forest", "SEC", "Missouri" ).drop(columns="diff_Score")
UGAvOSU = team_diffs("SEC", "Georgia", "Big10", "Ohio_State" ).drop(columns="diff_Score")
GSvBUFF = team_diffs("Sun Belt", "Georgia_Southern", "MAC", "Buffalo" ).drop(columns="diff_Score")
DUKEvUCF = team_diffs("ACC", "Duke", "AAC", "UCF" ).drop(columns="diff_Score")
MICHvTCU = team_diffs("Big10", "Michigan", "Big12", "TCU" ).drop(columns="diff_Score")
MTvSDSU = team_diffs("CUSA", "Middle_Tennessee", "MountainWest", "San_Diego_State" ).drop(columns="diff_Score")
MEMPvUTST = team_diffs("AAC", "Memphis", "MountainWest", "Utah_State" ).drop(columns="diff_Score")
CCUvECU = team_diffs("Sun Belt", "Coastal_Carolina", "AAC", "East_Carolina" ).drop(columns="diff_Score")
WISCvOKST = team_diffs("Big10", "Wisconsin", "Big12", "Oklahoma_State" ).drop(columns="diff_Score")
KANvARK = team_diffs("Big12", "Kansas", "SEC", "Arkansas" ).drop(columns="diff_Score")
OREvUNC = team_diffs("PAC12", "Oregon", "ACC", "North_Carolina" ).drop(columns="diff_Score")
TTvOLEM = team_diffs("Big12", "Texas_Tech", "SEC", "Ole_Miss" ).drop(columns="diff_Score")
OKLvFSU = team_diffs("Big12", "Oklahoma", "ACC", "Florida_State" ).drop(columns="diff_Score")
TEXvWASH = team_diffs("Big12", "Texas", "PAC12", "Washington" ).drop(columns="diff_Score")
TENNvCLEM = team_diffs("SEC", "Tennessee", "ACC", "Clemson" ).drop(columns="diff_Score")
BAMAvKSTATE = team_diffs("SEC", "Alabama", "Big12", "Kansas_State" ).drop(columns="diff_Score")
IOWAvKEN = team_diffs("Big10", "Iowa", "SEC", "Kentucky" ).drop(columns="diff_Score")
PURDvLSU = team_diffs("Big10", "Purdue", "SEC", "LSU" ).drop(columns="diff_Score")
UGAvMICH = team_diffs("SEC", "Georgia", "Big10", "Michigan" ).drop(columns="diff_Score")

# Store the above block of games:
games = [BGSUvNMS,
        WAKEvMIZZ,
        UGAvOSU, 
        GSvBUFF, 
        DUKEvUCF,
        MICHvTCU,
        MTvSDSU, 
        MEMPvUTST,
        CCUvECU, 
        WISCvOKST, 
        KANvARK,
        OREvUNC, 
        TTvOLEM, 
        OKLvFSU,
        TEXvWASH, 
        TENNvCLEM, 
        BAMAvKSTATE,
        IOWAvKEN, 
        PURDvLSU, 
        UGAvMICH]


# Predict Games:
for index, game in enumerate(games):
  print(index, ":", model.predict(game))


# Print General Accuracy:
print(np.sqrt(metrics.mean_squared_error(y_test, model.predict(x_test))))