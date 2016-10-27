#block1:
lats1= [ 41.868174, 41.993839]
lons1 = [ -87.772018, -87.745925]


#block 2:
lats2= [41.738164, 41.993839]
lons2 = [-87.745925, -87.656661]


#block 3:
lats3= [41.890158, 41.929505]
lons3 = [-87.656661, -87.630569]


#block 4:
lats4= [41.738164, 41.890158]
lons4 = [-87.656661, -87.615119]


#block 5:
lats5= [41.738164, 41.836336]
lons5 = [ -87.615119,  -87.601558]


#block 6: 
lats6= [41.738164, 41.775428]
lons6 = [-87.601558, -87.568599]

#block 7: 
lats7= [41.738164,  41.748795]
lons7 = [-87.568599,  -87.531520]


#block 8:
lats8= [41.678004, 41.748795 ]
lons8 = [ -87.676162, -87.531520]


#block 9:
lats9= [41.645129, 41.678004]
lons9 = [ -87.615039, -87.538282]


#block 10: 
lats10= [ 41.998071, 42.017487,]
lons10 = [ -87.708128, -87.663217]



import numpy as np

lats = np.stack((lats1, lats2, lats3, lats4, lats5, lats6, lats7, lats8, lats9, lats10))
lons = np.stack((lons1, lons2, lons3, lons4, lons5, lons6, lons7, lons8, lons9, lons10))

# get areas of blocks
a = [None]*len(lons)
n = [None]*len(lons)
N = 1000

for i in range(len(lats)):
	a[i] = (lats[i,1]- lats[i,0])*(lons[i,1]- lons[i,0])


area = sum(a)

prop = a/area

lat_unif = []
lon_unif = []

for i in range(len(lats)):
	n[i] = round(N*prop[i])
	lat_unif.extend(np.random.uniform(lats[i, 0], lats[i,1],  int(n[i])))
	lon_unif.extend(np.random.uniform(lons[i, 0], lons[i,1],  int(n[i])))


import urllib, os

myloc = r"/Users/Nandana/Dropbox/ChicagoImages" #replace with your own location
key = "&key=" + "AIzaSyBPSFpToUWl4XANSrXDGdRI0Kxsq-hm9qk" #got banned after ~100 requests with no key
heading = "&heading=" + "150" 
pitch = "&pitch= 0" + "" 

def GetStreet(lat,lon,SaveLoc, j):
  base = "https://maps.googleapis.com/maps/api/streetview?size=1200x800&location="
  MyUrl = base + str(lat) + "," +  str(lon) + heading + pitch + key
  fi = str(j) + ".jpg"
  urllib.urlretrieve(MyUrl, os.path.join(SaveLoc,fi))

for i in range(len(lat_unif)):
        GetStreet(lat=lat_unif[i], lon= lon_unif[i], SaveLoc=myloc, j = i)





import matplotlib.pyplot as plt

plt.plot([lon_unif], [lat_unif], 'ro')
plt.axis([-88.012172, -87.453415, 41.604806 ,42.063202])
plt.show()







































