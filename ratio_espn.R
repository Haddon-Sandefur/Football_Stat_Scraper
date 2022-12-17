ratio_ESPN <- function(list){
  
  col_position <- c(2,3,6)
  require(tidyverse)
  require(stringr)
  
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