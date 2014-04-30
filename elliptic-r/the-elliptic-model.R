library(sp)

elliptic_model<-function(points,FLEX=0,option="ellipse",totalSum=1){ 
  # Computes the elliptic model 
  #
  # Args:
  #   points: Data frame containing "lat", "lng" (coordinates) and "n"(poulation at each point)
  #   FLEX: Correction term, make it similar to your location estimation error. Default 0
  #   option: interveining oportunites taking into account either "ellipse" or "unionset", default "ellipse"
  #   totalSum: sum of all terms in the returned matrix. Default 1s
  #
  # Returns:
  #   A matrix with nrow(points)*nrow(points) elements containing fluxes between locations
  #
  # Author:
  # Carlos Herrera-Yagüe (carlos@hyague.es)

  
  r<-spDists(as.matrix(points[,c('lng','lat')]),longlat=T)
  pop<-points$n
  d<-matrix(nrow=nrow(r),ncol=ncol(r))
  diag(r)<-Inf
  
  for(i in 1:nrow(r)){
    m<-r[i,]
    mf<-r[i,]+FLEX
    a<-matrix(rep(m,length(m)),byrow=T,nrow=length(m))
    b<-matrix(r,nrow=length(m))
    xx<-(a<mf)%*%pop
    if(option=='ellipse'){
      l<-(a+b)<3*m+2*FLEX
      d[i,]<-l%*%pop

    }else{
      d[i,]<-(a<mf|b<mf)%*%pop
    }
    #print(i)
  }
  diag(d)<-0
  prodpop<-pop %*% t(pop)
  sumpop<-matrix(rep(pop,nrow(r)),byrow=T,nrow=nrow(r))+matrix(rep(pop,nrow(r)),byrow=F,nrow=nrow(r))

  t<-as.matrix(prodpop/(d+sumpop))
  diag(t)<-0
  t<-t/sum(t)*totalSum
  colnames(t)<-rownames(points)
  rownames(t)<-rownames(points)
  print(t[1:4,1:4])
  return(t)
}

