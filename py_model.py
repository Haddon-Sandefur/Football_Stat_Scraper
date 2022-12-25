import pandas as pd
import numpy as np
import matplotlib as plot
import sklearn as sk
import os 

os.chdir("C:/Users/hadsa/OneDrive/Documents/GitHub/Football_Stat_Scraper")

df = pd.read_table("master_set.txt")

print(pd.DataFrame.head(df))