setwd('/Users/Nandana/Dropbox/0_Research/Uchicago CI/2_Intelligent Survey/placepulse_1.0_data_shared/feature data')


# reading data 

a = read.csv("streetscore_withfeatures_43.csv")


# generating image vectors for each city 

cities = unique(a[,11])

nyc_img = a[which(a[,11] == "New York City"), 2]
bos_img = a[which(a[,11] == "Boston"), 2]
linz_img = a[which(a[,11] == "Linz"), 2]
salz_img = a[which(a[,11] == "Salzburg"), 2]

city_img = matrix(0, length(nyc_img), 4)

city_img[(1:length(nyc_img)),1] = nyc_img
city_img[(1:length(bos_img)),2] = bos_img
city_img[(1:length(linz_img)),3] = linz_img
city_img[(1:length(salz_img)),4] = salz_img

colnames(city_img) = c('NYC', 'Boston', 'Linz', 'Salz')
write.csv(city_img, file = "image_id_by_city.csv", row.names = FALSE)

sum(1*is.element(city_img[,4], city_img[,2]))

(length(nyc_img) + length(bos_img)  + length(linz_img) + length(salz_img))
