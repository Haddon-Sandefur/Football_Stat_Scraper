library(tidyverse)
library(reticulate)
library(stringr)
library(rvest)
library(data.table)



# Scrape: ============================

links <- read.table("Game_Links_Home.txt", sep = "")

table_store <- list()
page <- list()
df_stats <- list()
df_scoreboard <- list()


for(i in 1:nrow(links)){
  page[[i]] <- read_html(as.character(links[i,1]))
  table_store[[i]] <- html_table(page[[i]])
  
}


for(i in 1:length(page)){
  
  #Transposing Data
  df_stats[[i]] <- transpose(data.frame(table_store[[i]][2]), make.names =  1)
  
  #Getting Score For Each Game
  df_scoreboard[[i]] <- table_store[[i]][1]
  
  #Adding Team Names to the Rows
  rownames(df_stats[[i]]) <- data.frame(df_scoreboard[[i]])$Var.1
  
  #Adding Final Score
  df_stats[[i]]$Score <- data.frame(df_scoreboard[[i]])$T
}

# Rename ==================================================
master_list <- df_stats

# Ratio Function ===========================================
ratio_ESPN <- function(list){
  col_position <- c(2,3,6)
  
  for(i in 1:length(list)){
    
    
    # Getting Total Passing Attempts:
    
    list[[i]]$Pass_Att <- as.numeric(word(list[[i]][,6], start = 1, sep = "-"))
    
    # Getting Total Penalty Yards
    
    list[[i]]$Penalty_yrds <- as.numeric(word(list[[i]][,12], start = -1, sep = "-"))
    
    # Renaming Comp-Att to "Completion Percentage".
    colnames(list[[i]])[6] <- "Completion Percentage"
    
    # Getting Proportions for variables: 3rd Down Eff, 4th Down Eff, Completion.
    for(k in col_position){
      
      if(as.numeric(word(list[[i]][1,k], start = 1, sep = "-")[1]) == 0){
        list[[i]][1,k] <- 0
      }else{
        list[[i]][1,k] <- as.numeric(word(list[[i]][1,k], start = 1, sep = "-"))/
          as.numeric(word(list[[i]][1,k], start = -1, sep = "-"))
      }
      
      
      
      if(as.numeric(as.numeric(word(list[[i]][1,k], start = 1, sep = "-"))[1]) == 0){
        list[[i]][2,k] <- 0
      }else{
        list[[i]][2,k] <- as.numeric(word(list[[i]][2,k], start = 1, sep = "-"))/
          as.numeric(word(list[[i]][2,k], start = -1, sep = "-"))
      }
    } 
    
    # Changing Time of Possession to a Numeric Variable (in minutes):
    
    #Row 1
    list[[i]][1, 16] <- as.numeric(word(list[[i]][1,16], start = 1, sep = ":"))+
      (as.numeric(word(list[[i]][1,16], start = -1, sep = ":"))/60)
    #Row 2
    list[[i]][2, 16] <- as.numeric(word(list[[i]][2,16], start = 1, sep = ":"))+
      (as.numeric(word(list[[i]][2,16], start = -1, sep = ":"))/60)
    
  }
  return(list)
}

# Apply Ratio function to  Master List
master_list <- ratio_ESPN(master_list)


# Change Strings to Numerics ===========================================

for(i in 1:length(master_list)){
  master_list[[i]][,-12] <- as.numeric(unlist(master_list[[i]][,-12]))
}

for(i in 1:length(master_list)){
  master_list[[i]][-12] <- round(master_list[[i]][-12], digits = 4)
}

# Get Dataset ===========================================================


smush_ESPN <- function(list){
  
  Team_Stats <- matrix(NA, nrow = length(master_list), ncol = length(master_list[[1]]))
  
  
  for (i in 1:length(master_list)) {
    
    master_list[[i]][1,] <- -master_list[[i]][1,]
    
    Team_Stats[i,] <- matrix(colSums(master_list[[i]]), nrow = 1)
    
    Team_Stats <- data.frame(Team_Stats)
    
    colnames(Team_Stats) <- paste("diff", colnames(master_list[[i]]), sep = "\n")
    
  }
  
  return(Team_Stats)
  
}

smush_ESPN(master_list)

