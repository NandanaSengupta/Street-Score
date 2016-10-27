import urllib, os

myloc = r"/Users/Nandana/Dropbox/ChicagoImages100copy" #replace with your own location
key = "&key=" + "" #got banned after ~100 requests with no key
heading = "&heading=" + "90" 
pitch = "&pitch= 0" + "" 

def GetStreet(lat,lon,SaveLoc, j):
  base = "https://maps.googleapis.com/maps/api/streetview?size=1200x800&location="
  MyUrl = base + str(lat) + "," +  str(lon) + heading + pitch + key
  fi = str(j) + ".jpg"
  urllib.urlretrieve(MyUrl, os.path.join(SaveLoc,fi))

lat1 = [41.886506,41.884093, 41.883291, 41.884511, 41.653919, 41.656997, 41.645748, 41.655851]

lon1 = [-87.616442, -87.627837, -87.624551, -87.630957, -87.615052, -87.606211, -87.614061, -87.596901]

index = [0, 33, 43, 48, 70, 71, 85, 93]


for i in range(len(lat1)):
        GetStreet(lat=lat1[i], lon= lon1[i], SaveLoc=myloc, j = index[i])