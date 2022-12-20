# Football_Stat_Scraper
Hey there.

So far, this repository contains scripts which pull college football data from ESPN's website. 

Each team must have a a "Home" and "Away" text file with links to their respective game matchups.
These links are then read, scraped, stored as data, transformed, and saved as datasets. The process is fully automated and written in R.
The "master_set.txt" datafile contains each team's difference in statistical categories per game for each game they've played.

The "pull_stats.R" script is the function that scrapes and transforms data and saves them as dataframes within R lists.

The "extract_conference_data.R" script writes data files for game and average season statistics for each team, by conference.

The "full_data_generator.R" script pulls game stats for all teams and is what created "master_set.txt". There are a few hiccups here as I spotted
one error in the resultant data set: for one game, the scraper and this extraction script seemed to have mistook UGA for Oregon when Oregon played
Eastern Washington. I'll take a deep dive into this problem in the near future to find a solution, as I'm sure this isn't the only instance. However,
cursory checks of other teams have thus far looked accurate.

As of now, no Machine Learning or Statistical methods have been employed for predictive modelling, but will be implemented in the near future.

Thansk!
