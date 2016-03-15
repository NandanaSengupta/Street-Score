


clear all;
close all;

cd('/Users/Nandana/Dropbox/Place_Pulse_Opt_Code')

load('Cbos.mat')

ids = readtable('image_id_by_city.csv');

idsbos = table2array(ids((1: 1237), 2));

features10 = readtable('streetscore_withfeatures10.csv');

featuresids = table2array(features10(:,1));

featuresbos= features10(ismember(featuresids, idsbos), :);

latbos = table2array(featuresbos(:,8));
lonbos = table2array(featuresbos(:,9));

clusters = sort(randsample(idsbos, 100));

lat_cl = table2array(features10(ismember(featuresids, clusters), 8));
lon_cl = table2array(features10(ismember(featuresids, clusters),9));


check = zeros(length(clusters),3);



for i = 1: (length(lat_cl)-1)
    
 check(i, 1) = clusters(i)
 
    for j = i+1: length(lat_cl)
    
       if( lat_cl(i) == lat_cl(j) && lon_cl(i) == lon_cl(j))
           check(i, 2) = clusters(j);
           check(i,3) = check(i,3) + 1;
       end
        
    end    
        
    
end

tabulate(check(:,3))

check(find(check(:,3) >0), :) 

clusters(find(check(:,3) >0)) = [];


lat_cl = table2array(features10(ismember(featuresids, clusters), 8));
lon_cl = table2array(features10(ismember(featuresids, clusters),9));


check = zeros(length(clusters),3);

for i = 1: (length(lat_cl)-1)
    
 check(i, 1) = clusters(i)
 
    for j = i+1: length(lat_cl)
    
       if( lat_cl(i) == lat_cl(j) && lon_cl(i) == lon_cl(j))
           check(i, 2) = clusters(j);
           check(i,3) = check(i,3) + 1;
       end
        
    end    
        
    
end

tabulate(check(:,3))





scatter(latbos, lonbos)
hold on
scatter(lat_cl, lon_cl)
hold on 


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


[M, I] = min(D_clust, [], 2); %
histogram(I, 25)
tabulate(I)
min(tabulate(I))
max(tabulate(I))


l = [];

for c = 1: length(clusters)
eval(sprintf('img_cl%d =  idsbos(find(I == c));', c))
eval(sprintf('imgind_cl%d =  find(I == c);', c))
eval(sprintf('l = [l, length(img_cl%d)];' ,c)) 
end





scatter(latbos, lonbos)
hold on
scatter(lat_cl, lon_cl)
hold on 
scatter(latbos(imgind_cl75), lonbos(imgind_cl75), 'filled')
hold on 
scatter(lat_cl(75), lon_cl(75), '*')
hold on 
scatter(latbos(imgind_cl77), lonbos(imgind_cl77), 'filled')
hold on 
scatter(lat_cl(77), lon_cl(77), '*')
hold on 
scatter(latbos(imgind_cl82), lonbos(imgind_cl82), 'filled')
hold on 
scatter(lat_cl(82), lon_cl(82), '*')
hold on 
scatter(latbos(imgind_cl95), lonbos(imgind_cl95), 'filled')
hold on 
scatter(lat_cl(95), lon_cl(95), '*')
hold on 
scatter(latbos(imgind_cl19), lonbos(imgind_cl19), 'filled')
hold on 
scatter(lat_cl(19), lon_cl(19), '*')
hold on 
scatter(latbos(imgind_cl56), lonbos(imgind_cl56), 'filled')
hold on 
scatter(lat_cl(56), lon_cl(56), '*')
hold on 
scatter(latbos(imgind_cl78), lonbos(imgind_cl78), 'filled')
hold on 
scatter(lat_cl(78), lon_cl(78), '*')
hold on 
scatter(latbos(imgind_cl11), lonbos(imgind_cl11), 'filled')
hold on 
scatter(lat_cl(11), lon_cl(11), '*')
hold on 
scatter(latbos(imgind_cl59), lonbos(imgind_cl59), 'filled')
hold on 
scatter(lat_cl(59), lon_cl(59), '*')
hold on 
scatter(latbos(imgind_cl13), lonbos(imgind_cl13), 'filled')
hold on 
scatter(lat_cl(13), lon_cl(13), '*')
title('Boston top 10 clusters by memebership')
xlabel('Latitude')
ylabel('Longitude')





%%% PART 2: GENERATING NEW COUNT MATRICES (C, T)

C_cl = NaN*zeros(length(clusters), length(clusters));

for i = 1:length(clusters)

    for j = 1:length(clusters)
       
        [i,j]
        
       eval(sprintf('C_cl(%d,%d) = sum(sum(Cbos(imgind_cl%d, imgind_cl%d)));', i,j, i, j))
       
        
    end
    
end



C_clbos = C_cl ;
%diag(C_cl) = zeros(length(clusters), 1);  % why doesn't this work???


C_cl(logical(eye(size(C_cl)))) = 0; 


C_clust = C_cl; 

save('C_clust.mat', 'C_clust')


T_cl = zeros(size(C_cl));

for i = 1:length(clusters)

    for j = 1:length(clusters)
       
        [i,j]
       T_cl(i,j) = C_cl(i,j) + C_cl(j,i);
       
    end
    
end

Tbos = zeros(size(Cbos));

for i = 1:length(Cbos)

    for j = 1:length(Cbos)
       
        [i,j]
       Tbos(i,j) = Cbos(i,j) + Cbos(j,i);
       
    end
    
end


%%% PART 3: WEIGHTED AVERAGED FEATURES

% (total times an image is compared)/(total times its cluster is compared)

Wbos = zeros(length(idsbos), length(clusters));

for i = 1:length(idsbos)
    
    for j = 1:length(clusters)
        
        if  eval(sprintf('(ismember(idsbos(i), img_cl%d)', j) )
            
            Wbos(i,j) = sum(Tbos(i,:))/ sum(T_cl(j,:)); 
            
        end
        
    end
    
end



