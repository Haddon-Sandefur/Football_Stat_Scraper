# Football_Stat_Scraper

Hey There!

This is my college football web crawler + scraper. The intent is to use this data for prediction models.

- Update 01/06 VERSION 2 ROLL OUT ===============================================================================

I've gone ahead and streamlined the data collection process, which was previously tedious (having to manually grab links to be scraped yourself). Now we have a webcrawler to obtain these links for us. Not only that, but generating the master data set (the data set containing all matchups through weeks 1-15) has become much more simple. Further, the computation time and code has been chewed from the original script that calculated season average statistics.

### Here are the current v2 files:

* [`pull_stats_v2.R`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/pull_stats_v2.R) - This is the Web Scraper. This has now been adjusted to include a text file parser, which allows for choosing which links you want to be read by line.

* [`web_crawl_v2.R`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/web_crawl_v2.R) - This is the Web Crawler that grabs relevant links to scrape using the above file's functionality.

* [`full_data_generator_v2.R`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/full_data_generator_v2.R) - Sources [`pull_stats_v2.R`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/pull_stats_v2.R), to scrape and write [`master_set_v2.txt`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/master_set_v2.txt) a dataset containing all team's games and performance. Also creates [`master_avg_v2.txt`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/master_avg_v2.txt), which contains each teams' season average performance.

* [`links.txt`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/links.txt) - This file contains all of the links collected by [`web_crawl_v2.R`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/web_crawl_v2.R).

* [`Conference_power.txt`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/Conference_power.txt) - my subjective conference power rankings to be used later.

### Version 2.1

* Added a script ([`master_set_edit_v21.R`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/master_set_edit_v21.R)) that edits the master sets and adds conference information to the teams. These new datasets, the ones used for the below model, are found in [`master_set_v21.txt`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/master_set_v21.txt) and the averages in [`master_avg_v21.txt`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/master_avg_v21.txt). 

* Added Random Forest Model in [`rf.rda`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/rf.rda) and [`model_gen_v21.R`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/model_gen_v21.R). There is a classifier model in this repo as well that is currently unused, but is kept for future experimentation. 

* Updating [`Conference_power.txt`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/Conference_power.txt) to better describe parity between P5 and G5 schools.

Up Next:

Better Models and a Web App.

***Note***

The [`spreads.txt`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/v1/spreads.txt) and [`spread_model.py`](https://github.com/Haddon-Sandefur/Football_Stat_Scraper/blob/main/v1/spread_model.py) in the v1 folder were built with the old version, and the random forest model has some different training data applied to it. The name is misleading, as this model does not accurately predict spreads, but has so far done well in the 2022-2023 bowl season with respect to game outcome. You're still welcome to check it out.

 ======================================================================================

### Legacy Version + Files

Can be found in the v1 Folder
