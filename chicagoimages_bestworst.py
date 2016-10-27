#### 5 "best"

# Near North Side

lats1 = [41.889221, 41.911133]
lons1 = [-87.641067, -87.625102]

# Near West Side

lats2 = [41.860052, 41.888684]
lons2= [-87.690518, -87.636273]

# Lincoln Park

lats3 = [41.911404, 41.932862]
lons3= [-87.656615, -87.635673]

 

# Lake View

lats4 = [41.933202, 41.954142]
lons4=[-87.673517, -87.640730]

# South Loop

lats5 = [41.848088, 41.875831]
lons5 =[-87.630591, -87.624583]


#### 5 "worst"

# Chatham

lats6 = [41.730155, 41.750906]
lons6 =[-87.633038, -87.600594]


# Chicago Lawn

lats7 = [41.758143, 41.786181]
lons7=[ -87.712715, -87.678383]


# West Garfield Park

lats8 = [41.868836, 41.887816]
lons8 =[-87.740541, -87.720543]


# Riverdale 

lats9 = [41.652059,41.659113]
lons9= [-87.617336, -87.595707]

# Grand Crossing

lats10 = [41.751874, 41.765832]
lons10=[ -87.605490, -87.585921]




import numpy as np

lats = np.stack((lats1, lats2, lats3, lats4, lats5, lats6, lats7, lats8, lats9, lats10))
lons = np.stack((lons1, lons2, lons3, lons4, lons5, lons6, lons7, lons8, lons9, lons10))


lat_unif = []
lon_unif = []
n = 13
for i in range(len(lats)):
	lat_unif.extend(np.random.uniform(lats[i, 0], lats[i,1],  n))
	lon_unif.extend(np.random.uniform(lons[i, 0], lons[i,1],  n))


import urllib, os

myloc = r"/Users/Nandana/Dropbox/ChicagoImages_Final" #replace with your own location
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

# AFTER REMOVING IMAGES WITH 






a = os.listdir('/Users/Nandana/Dropbox/ChicagoImages_Final')

a.pop(0)

b = [0]*len(a)
for i in range(len(a)):
    b[i] = int(a[i].rstrip('.jpg'))

lats100 = [0]*len(a)
lons100 = [0]*len(a)

for i in range(len(b)):
    lats100[i] = lat_unif[b[i]]
    lons100[i] = lon_unif[b[i]]

np.savetxt('lats100.txt', lats100)
np.savetxt('lons100.txt', lons100)

plt.plot([lons100], [lats100], 'ro')
plt.axis([-88.012172, -87.453415, 41.604806 ,42.063202])
plt.ylabel('Latitude')
plt.xlabel('Longitude')
plt.title('Best and Worst Chicago Neighborhoods')
plt.show()


