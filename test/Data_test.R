setwd("D:/Project/GRF")

source("Data.R")


Data<-new("data" ,datas=c(1,2,3,4), num_rows=1, num_cols=4)


Data@num_rows

getdata(Data,1,1)

is_failure(Data,1)
