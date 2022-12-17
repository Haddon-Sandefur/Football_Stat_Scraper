pull_stats <- function(link_txt, away = c(TRUE, FALSE)){
  
  require(dplyr)
  require(rvest)
  require(data.table)
  
  links <- read.table(link_txt, sep = "")
  
  #Storage 
  table_store <- list()
  page <- list()
  df_stats <- list()
  df_scoreboard <- list()
  
  # Read HTML Objects and store them.
  for(i in 1:nrow(links)){
    page[[i]] <- read_html(as.character(links[i,1]))
    table_store[[i]] <- html_table(page[[i]])
    
  }
  
  
  for(i in 1:length(page)){
    
    #Transposing Data And Keeping Row Labels as Colnames
    df_stats[[i]] <- data.table::transpose(data.frame(table_store[[i]][2]), make.names =  1)
    
    #Getting Score For Each Game
    df_scoreboard[[i]] <- table_store[[i]][1]
    
    #Adding Team Names to the Rows
    rownames(df_stats[[i]]) <- data.frame(df_scoreboard[[i]])$Var.1
    
    #Adding Final Score
    df_stats[[i]]$Score <- data.frame(df_scoreboard[[i]])$T
    
    
    
    
  }
  
  #Removing Duplicate "Interceptions Thrown" column
  
  for (i in 1:nrow(links)) {
    
    df_stats[[i]] <- df_stats[[i]][-15]
    
  }
  
  #Switch Rows if AWAY game
  
  if(away){
    for(i in 1:nrow(links)){
      
      df_stats[[i]] <- df_stats[[i]][c(2,1),]  
      
    }
  }
  
  #Changing Data Types and Reformating (Requires DPLYR)
  
  for(i in 1:nrow(links)){
   df_stats[[i]] <- df_stats[[i]] %>% 
                        mutate(Penalties = as.numeric(word(Penalties, start = -1, sep = "-")),
                              `3rd down efficiency` = round(ifelse( # This Gives Us a 3rd Down Ratio
                                      as.numeric(
                                        word(`3rd down efficiency`, start = -1, sep = "-")) == 0,
                                      as.numeric(
                                        word(`3rd down efficiency`, start = 1, sep = "-")),
                                      as.numeric(
                                        word(`3rd down efficiency`, start = 1, sep = "-"))/
                                        as.numeric(
                                          word(`3rd down efficiency`, start = -1, sep = "-"))),
                                      digits = 3),
                              
                              `4th down efficiency` = round(ifelse( # This Gives Us a 4th Down Ratio
                                        as.numeric(
                                          word(`4th down efficiency`, start = -1, sep = "-")) == 0,
                                        as.numeric(
                                          word(`4th down efficiency`, start = 1, sep = "-")),
                                        as.numeric(
                                          word(`4th down efficiency`, start = 1, sep = "-"))/
                                          as.numeric(
                                            word(`4th down efficiency`, start = -1, sep = "-"))), 
                                        digits = 3),
                              
                              `Comp-Att` = round(ifelse(  # This Gives Us a Completion Ratio
                                        as.numeric(
                                          word(`Comp-Att`, start = -1, sep = "-")) == 0,
                                        as.numeric(
                                          word(`Comp-Att`, start = 1, sep = "-")),
                                        as.numeric(
                                          word(`Comp-Att`, start = 1, sep = "-"))/
                                          as.numeric(
                                            word(`Comp-Att`, start = -1, sep = "-"))), 
                                        digits = 3),
                              
                               Possession = round(as.numeric(word(Possession, start = 1, sep = ":"))+ # This Gives Us a minutes plus seconds as a fraction of a minute
                                                    as.numeric(word(Possession, start = -1, sep = ":"))/60, 
                                digits = 2)) %>% 
     mutate_all(as.numeric)
  }
  
  #==== This Section Makes a Dataframe of Metric Differentials for each game of a reference team=======
  
  game_differentials <- list()
  game_diffs <- matrix(NA, nrow = length(df_stats), ncol = length(df_stats[[1]]))
  opponent_names <- c()
  
  for(i in 1:nrow(links)){
    game_differentials[[i]] <- df_stats[[i]]
    
    #Negative Version of the opponent Row to be added to the Team of Interest Row
    game_differentials[[i]][1,] <- - game_differentials[[i]][1,]
    
    game_diffs[i,] <- matrix(colSums(game_differentials[[i]]), nrow = 1)
    
    game_diffs <- data.frame(game_diffs)
    
    colnames(game_diffs) <- paste("diff", colnames(game_differentials[[i]]), sep = "_")
    
    opponent_names[i] <- rownames(df_stats[[i]][1,])
    
    
  }
  
  # Adding Win/Loss Colum
  
  game_diffs <- game_diffs %>% 
    mutate(Result = ifelse(diff_Score >= 0, "W", "L"),
           Result_num = ifelse(diff_Score >= 0, 1, 0))
  
  # Adding Opponents to Game Diffs  Dataframes
  
  rownames(game_diffs) <- opponent_names
  
 return(list("Game List" = df_stats, "Game Differentials" = game_diffs))
}


