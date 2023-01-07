# Football_Stat_Scraper

Hey There!

This is my college football web crawler + scraper. The intent is to use this data for prediction models.

- Update 01/06 VERSION 2 ROLL OUT ===========================================================================================

I've gone ahead and streamlined the data collection process, which was previously tedious (having to manually grab links to be scraped yourself). Now we have a webcrawler to obtain these links for us. Not only that, but generating the master data set (the data set containing all matchups through weeks 1-15) has become much more simple. Further, the computation time and code has been chewed from the original script that calculated season average statistics.

Here are the current v2 files:

"pull_stats_v2.R" - This is the Web Scraper. This has now been adjusted to include a text file parser, which allows for choosing which links you want to be read by line.

"web_crawl_v2.R" - This is the Web Crawler that grabs relevant links to scrape using the above file's functionality.

"full_data_generator_v2" - Sources "pull_states_v2.R" to scrape and write "master_set_v2.txt" a dataset containing all team's games and performance. Also creates "master_avg_v2.txt", which contains each teams' season average performance.

"links.txt" - This does not have the naming convention the other v2 files have for simplicity. This file contains all of the links collecet by "web_crawl_v2.R"

"Conference_power.txt" - my subjective conference power rankings to be used later

Up Next:

Better Models and a Web App.

***Note

The "spreads.txt" and "spread_model.py" in the v1 folder were built with the old version, and the random forest model has some different training data applied to it. The name is misleading, as this model does not accurately predict spreads, but has so far done well in the 2022-2023 bowl season with respect to game outcome. You're still welcome to check it out.



- Legacy Version + Files ======================================================================================================

Below you will find the old ReadMe file for the legacy code and data.

Hey there.

So far, this repository contains scripts which pull college football data from ESPN's website. 

Each team must have a a "Home" and "Away" text file with links to their respective game matchups.
These links are then read, scraped, stored as data, transformed, and saved as datasets. The process is fully automated and written in R.
The "master_set.txt" datafile contains each team's difference in statistical categories per game for each game they've played.

The "pull_stats.R" script is the function that scrapes and transforms data and saves them as dataframes within R lists.

The "extract_conference_data.R" script writes data files for game and average season statistics for each team, by conference.

The "full_data_generator.R" script pulls game stats for all teams and is what created "master_set.txt". There are a few hiccups here as I spotted
one error in the resultant data set: for one game, the scraper and this extraction script seemed to have mistook Oregon for UGA when Oregon played
Eastern Washington. I'll take a deep dive into this problem in the near future to find a solution, as I'm sure this isn't the only instance. However,
cursory checks of other teams have thus far looked accurate.


Thanks!

- Update 12/24

Fixed the UGA/Oregon screw up and added a simple logistic model in a jupyter notebook file to predict some bowl games. Happy Holidays! 


- Update 12/26 

Updating text files and transferring out depreciated files. Jupyter Notebook code switched to Random Forest model and transferred to a single script file to obtain a spread-based outcome rather than a binary W/L outcome.