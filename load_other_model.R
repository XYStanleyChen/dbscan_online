########################## model ##########################
#epsilon1=2 # 2 is the best
epsilon2=2 # 2 is the best
epsilon3=2 # 2 is the best
epsilon4=1 # 1 || 2 are both okay
epsilon5=2 # 2 is the best
epsilon6=2 # 2 is the best
epsilon7=1 # 1 is the best

#db1 <- dbscan(d1, eps = epsilon1, minPts = 2*ncol(d1))
#for prediction: db2 needs to combine 0&1 cluster as 0(it has 0,1,2)
db2 <- dbscan(d2, eps = epsilon2, minPts = 2*ncol(d2))
#for prediction: db3 needs to combine 0&2 cluster as 0(it has 0,1,2)
db3 <- dbscan(d3, eps = epsilon3, minPts = 2*ncol(d3))
db4 <- dbscan(d4, eps = epsilon4, minPts = 2*ncol(d4))
db5 <- dbscan(d5, eps = epsilon5, minPts = 2*ncol(d5))
db6 <- dbscan(d6, eps = epsilon6, minPts = 2*ncol(d6))
#for prediction: db7 needs to combine 0&5&6 cluster as 0, others as 1(it has 0,1,2,3,4,5,6)
db7 <- dbscan(d7, eps = epsilon7, minPts = 2*ncol(d7))

#actual_clu1 <- db1$cluster #(containing 0,1)
actual_clu2 <- db2$cluster #(containing 0,1,2)
actual_clu2[actual_clu2==1] <- 0
actual_clu2[actual_clu2==2] <- 1
actual_clu3 <- db3$cluster #(containing 0,1,2)
actual_clu3[actual_clu3==2] <- 0
actual_clu4 <- db4$cluster #(containing 0,1)
actual_clu5 <- db5$cluster #(containing 0,1)
actual_clu6 <- db6$cluster #(containing 0,1)
actual_clu7 <- db7$cluster #(containing 0,1,2,3,4,5,6)
actual_clu7[actual_clu7==5] <- 0
actual_clu7[actual_clu7==6] <- 0
actual_clu7[actual_clu7==2] <- 1
actual_clu7[actual_clu7==3] <- 1
actual_clu7[actual_clu7==4] <- 1