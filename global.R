library(shiny)
library(shinyjs)
library(shinydashboard)

library(stats)
library(cluster)
library(dbscan)
library(readr)
library(pROC)
library(ggplot2)
library(ggpubr)

distance1 <- stats::dist(d1) #This will normally take a few sec

my_predict <- function(actual_clu_orig, orig_data, new_data){
  
  # center of cluster 0&1
  center0 <- colMeans(orig_data[actual_clu_orig == 0, ])
  center1 <- colMeans(orig_data[actual_clu_orig == 1, ])
  
  # distance matrix
  # dist_matrix0 <- dist(rbind(center0, new_data))
  # dist_matrix1 <- dist(rbind(center1, new_data))
  
  # now compare and allocate
  return(as.numeric(apply(new_data, 1, function(x){
    # if TRUE is returned, then x is closer to center1
    dist(rbind(center1, x)) < dist(rbind(center0, x))
  })))
}

verify_dbmodel <- function(db_model){ # return true if only two clusters
  check <- sum(unique(db_model$cluster))
  if (check == 1)
    return(TRUE)
  else
    return(FALSE)
}