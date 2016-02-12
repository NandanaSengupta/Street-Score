


clear all;
close all;

cd('/Users/Nandana/Dropbox/Place_Pulse_Opt_Code')

load('Cbos.mat')

ids = readtable('image_id_by_city.csv');

bos = table2array(ids((1: 1237), 2));

features10 = readtable('streetscore_withfeatures10.csv');

featuresids = table2array(features10(:,1));

featuresbos= features10(ismember(featuresids, bos), :);

latbos = table2array(featuresbos(:,8));
lonbos = table2array(featuresbos(:,9));

clusters = randsample(bos, 100);

lat_cl = table2array(features10(ismember(featuresids, clusters), 8));
lon_cl = table2array(features10(ismember(featuresids, clusters),9));

scatter(latbos, lonbos)
hold on
scatter(lat_cl, lon_cl)


%%% PART 1: CLUSTERING

% remaining images check distance and cluster them to 100 images

D_clust = NaN*(zeros(length(latbos), length(lat_cl)));

for i = 1: length(latbos)
    
    lat1 = latbos(i);
    lon1 = lonbos(i);
    
    
    
       
    for j = 1: length(lat_cl) 
    
        [i,j]
        
     lat2 = lat_cl(j);
     lon2 = lon_cl(j);
    
    
    
     dlon = degtorad(lon2) - degtorad(lon1) ;
     dlat = degtorad(lat2) - degtorad(lat1) ;
     a = (sin(dlat/2))^2 + cos(degtorad(lat1)) * cos(degtorad(lat2)) * (sin(dlon/2))^2; 
     D_clust(i,j) = 3961*2 * atan2( sqrt(a), sqrt(1-a) ) ;
        
    
    
    
    
    
    end
    
    
end




%%% PART 2: GENERATING NEW COUNT MATRICES (C, T)

% summing subsets of the C matrix and the T matrix

% bunching up the subsets 


%%% PART 3: WEIGHTED AVERAGED FEATURES


