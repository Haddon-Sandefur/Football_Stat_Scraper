# Football_Stat_Scraper
Hey there.

So far, this repository contains scripts which pull college football data from ESPN's website. 

Each team must have a a "Home" and "Away" text file with links to their respective game matchups.
These links are then read, pulled, stored as data, transformed, and saved as datasets. The process is fully automated and written in R.
The "master_set.txt" datafile contains each team's difference in statistical categories per game for each game they've played.

As of now, no Machine Learning or Statistical methods have been employed for predictive modelling, but will be implemented in the near future.

Thanks!

- Update 12/24

Fixed the UGA/Oregon screw up and added a simple logistic model in a jupyter notebook file to predict some bowl games. Happy Holidays! 
Refer to "quick_predictions.txt" for game predictions.
