import numpy as np
from math import radians, sin, cos, asin, sqrt, pi, atan2

EARTH_RADIUS=6378.1

def spDistN1(ptlat,ptlng,lat,lng):
   dlon = np.radians(lng) - radians(ptlng)
   dlat = np.radians(lat) - radians(ptlat)
   a = np.square(np.sin(dlat/2.0)) + cos(radians(ptlat)) * np.cos(np.radians(lat)) * np.square(np.sin(dlon/2.0))
   great_circle_distance = 2 * np.arcsin(np.minimum(np.sqrt(a), np.repeat(1, len(a))))
   d = EARTH_RADIUS * great_circle_distance
   return d

 

def r_distance(lat,lng):
   r=np.zeros((len(lat),len(lng)))
   for i in xrange(len(lat)):
      r[i]=spDistN1(lat[i],lng[i],lat,lng)
   return r
      
def elliptic_model(lat,lng,pop,FLEX=0,option="ellipse",totalSum=1):
   r=r_distance(lat,lng)
   d=np.zeros((len(lat),len(lat)))
   np.fill_diagonal(r,np.inf)
   for i in xrange(len(r)):
      m = np.copy(r[i])
      mf = np.copy(r[i]) + FLEX
      a = np.repeat([m], len(m), axis=0)
      b = np.copy(r)
      if option=="ellipse":
         c = [(3 * m + 2 * FLEX)]
         l = (a+b) < np.transpose(c)
         d[i] = np.dot(l, pop)
      else: 
         s1 = a < np.transpose([mf])
	 s2 = b < np.transpose([mf])
      	 s1us2 = np.logical_or(s1, s2)
         d[i] = np.dot(s1us2, pop)
   np.fill_diagonal(d, 0)
   prodpop = pop * np.transpose([pop]) 
   sumpop = np.repeat([pop], len(pop), axis=0)
   sumpop += np.transpose(sumpop)
   t = prodpop/(d+sumpop)
   np.fill_diagonal(t, 0)
   t = t/np.sum(t)*totalSum
   return t

