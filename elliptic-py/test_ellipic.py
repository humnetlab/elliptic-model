import the_elliptic_model as el 
import numpy as np

file=np.genfromtxt("sampledata.csv",delimiter=",")
lat=file[1:,1]
lng=file[1:,2]
n=file[1:,3]

result = el.elliptic_model(lat,lng,n, 0)
file2=np.genfromtxt("sample_output_R.csv",delimiter=",")
expected = file2[1:,1:]
pearson = np.corrcoef(np.reshape(result,(96*96)), np.reshape(expected,(96*96)))[0,1]

if pearson > 0.99:
   print "OK"
