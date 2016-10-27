
# coding: utf-8

# In[1]:

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

lats = np.stack((lats2, lats3, lats4, lats5, lats6, lats7, lats8))
lons = np.stack((lons2, lons3, lons4, lons5, lons6, lons7, lons8))

# get areas of blocks
a = [None]*len(lons)
n = [None]*len(lons)
N = 125

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






# In[83]:

import matplotlib.pyplot as plt

plt.plot([lon_unif], [lat_unif], 'ro')
plt.axis([-88.012172, -87.453415, 41.604806 ,42.063202])
plt.show()




# In[ ]:




# In[ ]:




# In[32]:

a = os.listdir('/Users/Nandana/Dropbox/ChicagoImages')


# In[33]:

a.pop(0)


# In[ ]:




# In[52]:

b = [0]*len(a)
for i in range(len(a)):
    b[i] = int(a[i].rstrip('.jpg'))


# In[ ]:




# In[75]:

latset1 = [0]*len(a)
lonset1 = [0]*len(a)

for i in range(len(b)):
    latset1[i] = lat_unif[b[i]]
    lonset1[i] = lon_unif[b[i]]


# In[84]:

plt.plot([lonset1], [latset1], 'ro')
plt.axis([-88.012172, -87.453415, 41.604806 ,42.063202])
plt.show()


# In[85]:



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

lats = np.stack((lats2, lats3, lats4, lats5, lats6, lats7, lats8))
lons = np.stack((lons2, lons3, lons4, lons5, lons6, lons7, lons8))

# get areas of blocks
a = [None]*len(lons)
n = [None]*len(lons)
N = 30

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

myloc = r"/Users/Nandana/Dropbox/ChicagoImages1" #replace with your own location
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






# In[90]:

a = os.listdir('/Users/Nandana/Dropbox/ChicagoImages1')
a.pop(0)
b = [0]*len(a)
for i in range(len(a)):
    b[i] = int(a[i].rstrip('.jpg'))


# In[91]:

latset2 = [0]*len(a)
lonset2 = [0]*len(a)

for i in range(len(b)):
    latset2[i] = lat_unif[b[i]]
    lonset2[i] = lon_unif[b[i]]


# In[96]:

latset = latset1+latset2
lonset = lonset1 + lonset2


# In[106]:

plt.plot([lonset], [latset], 'ro')
plt.axis([-88.012172, -87.453415, 41.604806 ,42.063202])
plt.show()


# In[101]:


myloc = r"/Users/Nandana/Dropbox/ChicagoImages100" #replace with your own location
key = "&key=" + "AIzaSyBPSFpToUWl4XANSrXDGdRI0Kxsq-hm9qk" #got banned after ~100 requests with no key
heading = "&heading=" + "150" 
pitch = "&pitch= 0" + "" 

def GetStreet(lat,lon,SaveLoc, j):
  base = "https://maps.googleapis.com/maps/api/streetview?size=1200x800&location="
  MyUrl = base + str(lat) + "," +  str(lon) + heading + pitch + key
  fi = str(j) + ".jpg"
  urllib.urlretrieve(MyUrl, os.path.join(SaveLoc,fi))

for i in range(len(latset)):
        GetStreet(lat=latset[i], lon= lonset[i], SaveLoc=myloc, j = i)


# In[102]:

np.save('lattitudes.npy', latset)


# In[103]:

np.save('longitudes.npy', lonset)


# In[105]:

np.savetxt('lats100.txt', latset)
np.savetxt('lons100.txt', lonset)


# In[ ]:



