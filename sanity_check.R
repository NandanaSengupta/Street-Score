setwd('/Users/Nandana/Dropbox/0_Research/Uchicago CI/2_Intelligent Survey/placepulse_1.0_data_shared/feature data')


# reading data 

a = read.csv("streetscore_withfeatures_43.csv")


# sorting by most popular features

b = apply(a[14:dim(a)[2]], 2, sum)
feat.srt = sort(b, index = TRUE)


# generating Lat Long vectors for each city 

cities = unique(a[,11])

bos.lat = a[,9][a[,11] == "Boston"]
bos.lon = a[,10][a[,11] == "Boston"]

nyc.lat = a[,9][a[,11] == "New York City"]
nyc.lon = a[,10][a[,11] == "New York City"]

linz.lat = a[,9][a[,11] == "Linz"]
linz.lon = a[,10][a[,11] == "Linz"]

salz.lat = a[,9][a[,11] == "Salzburg"]
salz.lon = a[,10][a[,11] == "Salzburg"]


# generating Lat Long scatter plot for each city 

par(mfrow = c(2,2))
plot(bos.lat, bos.lon, main = "Boston")

plot(nyc.lat, nyc.lon, main = "NYC")

plot(linz.lat, linz.lon, main = "Linz")

plot(salz.lat, salz.lon, main = "Salzburg")


########## TASK ##############

# For each city create vectors corresponding to feature nos:
# 151 (residential_neighborhood), 92 (highway), 60 (crosswalk), 135 (parking lot),
# 13 (apartment_building), 130 (office_building), 79 (forest_road), 2 (alley) 


# plot each of these vectors in scatterplots like the ones above, with color intensity varying with vector value (for eg: for high value of residential_neighborhood feature is represented by dark green, lower values with lighter green and so on)

# In the end we need 8 figures (corresponding to each feature) containing 4 scatterplots (corresponding to the cities)

