source("the-elliptic-model.R")
points<-read.csv('sampledata.csv')
oo<-elliptic_model(points)
res<-as.matrix(read.csv('sample_output_R.csv')[,-1])
if(cor(as.numeric(res),as.numeric(oo))>0.99){
  print("OK")
}