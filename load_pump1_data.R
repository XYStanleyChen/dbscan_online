# load data and normalization
pump1 <- read_csv("data/1.csv", col_names=TRUE, col_types = list(col_datetime(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double()))
pump2 <- read_csv("data/2.csv", col_names=TRUE, col_types = list(col_datetime(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double()))
pump3 <- read_csv("data/3.csv", col_names=TRUE, col_types = list(col_datetime(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double()))
pump4 <- read_csv("data/4.csv", col_names=TRUE, col_types = list(col_datetime(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double()))
pump5 <- read_csv("data/5.csv", col_names=TRUE, col_types = list(col_datetime(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double()))
pump6 <- read_csv("data/6.csv", col_names=TRUE, col_types = list(col_datetime(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double()))
# pump7 does not have instantFlow feature
pump7 <- read_csv("data/7.csv", col_names=TRUE, col_types = list(col_datetime(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double(), col_double()))

colnames(pump1) <- c("Date", "backT", "frontT", "moduleT", "I", "V", "instantFlow", "openDegree", "vacuumDegree")
colnames(pump2) <- c("Date", "backT", "frontT", "moduleT", "I", "V", "instantFlow", "openDegree", "vacuumDegree")
colnames(pump3) <- c("Date", "backT", "frontT", "moduleT", "I", "V", "instantFlow", "openDegree", "vacuumDegree")
colnames(pump4) <- c("Date", "backT", "frontT", "moduleT", "I", "V", "instantFlow", "openDegree", "vacuumDegree")
colnames(pump5) <- c("Date", "backT", "frontT", "moduleT", "I", "V", "instantFlow", "openDegree", "vacuumDegree")
colnames(pump6) <- c("Date", "backT", "frontT", "moduleT", "I", "V", "instantFlow", "openDegree", "vacuumDegree")
colnames(pump7) <- c("Date", "backT", "frontT", "moduleT", "I", "V", "openDegree", "vacuumDegree")

########################## z-score normalization ##########################
d1 <- scale(pump1[,-1], center = T, scale = T)
d2 <- scale(pump2[,-1], center = T, scale = T)
d3 <- scale(pump3[,-1], center = T, scale = T)
d4 <- scale(pump4[,-1], center = T, scale = T)
d5 <- scale(pump5[,-1], center = T, scale = T)
d6 <- scale(pump6[,-1], center = T, scale = T)
d7 <- scale(pump7[,-1], center = T, scale = T)