


clear all;
close all;

cd('/Users/Nandana/Dropbox/Place_Pulse_Opt_Code')

load('Cbos.mat')



k = 100; % number of clusters 


ids = readtable('image_id_by_city.csv');

idsbos = table2array(ids((1: 1237), 2));

features10 = readtable('streetscore_withfeatures10.csv');
featuresids = table2array(features10(:,1));
featuresbos= features10(ismember(featuresids, idsbos), :);

latbos = table2array(featuresbos(:,8));
lonbos = table2array(featuresbos(:,9));


data = [idsbos, latbos, lonbos];



%%% Other option: K means clutsering 

clustering_data = [latbos, lonbos];


[idx, cent] = kmeans(clustering_data, k)


clst = [];
for i = 1:100

    
    clst = [clst ,length(find(idx ==i))];


end


[cl1, rnk1] = sort(clst, 'descend')

% plotting top 30 k-means clusters


scatter(latbos, lonbos)
hold on
scatter(lat_cl, lon_cl)
hold on 


for i = 1:30

    scatter(latbos(find(idx==rnk1(i))), lonbos(find(idx ==rnk1(i))), 'filled')
    hold on 
    scatter(cent(rnk1(i), 1), cent(rnk1(i),2), '*')
    hold on
    
end



% image ids for members of cluster "k": idsbos(find(idx ==k))




%%% PART 2: GENERATING NEW COUNT MATRICES (C, T)




C_clust = NaN*zeros(k, k);

for i = 1:k

    for j = 1:k
       
        [i,j]
        
   C_clust(i,j) = sum(sum(Cbos(idsbos(find(idx ==i)), idsbos(find(idx ==j)))));
       
        
    end
    
end


C_clust(logical(eye(size(C_clust)))) = 0; 

save('C_clust.mat', 'C_clust')


T_cl = zeros(size(C_clust));

for i = 1:k

    for j = 1:k
       
        [i,j]
       T_cl(i,j) = C_clust(i,j) + C_clust(j,i);
       
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

Wbos = zeros(length(idsbos), k);

for i = 1:length(idsbos)
    
    for j = 1:k
        
        if  (ismember(idsbos(i),  idsbos(find(idx ==j))))        
            Wbos(i,j) = sum(Tbos(i,:))/ sum(T_cl(j,:)); 
            
        end
        
    end
    
end


%%% WEIGHTED FEATURE MATRICES 

% Suppose there are "p" features and "k" clusters, we want a "(k x p)"
% matrix of cluster features where the feature values are sum_{i in cluster K} w_{i,K}f_{i}










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% other stuff I tried 




[C,ia,ic] = unique(data(:,2:3),'rows'); % ia is the index of unique lat lon combinations


clusters = sort(randsample(ia, 100)); % random subsample of unique lat-lons indices

lat_cl = latbos(clusters); % lats corresponding to random subsample
lon_cl = lonbos(clusters); % lons corresponding to random subsample


check = zeros(length(clusters),3); % sanity check matrix -- col1: index, col2 &3: overlap measures



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






scatter(latbos, lonbos)
hold on
scatter(lat_cl, lon_cl)
hold on 


%%% PART 1: CLUSTERING

% remaining images check distance and cluster them to 100 images

D_clust = NaN*(zeros(length(latbos), length(lat_cl)));

 
% check how many images changed clusters and compare to some condition


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
tbl= tabulate(I)
min(tabulate(I))
max(tabulate(I))



for c = 1: length(clusters)
eval(sprintf('img_cl%d =  idsbos(find(I == c));', c))
eval(sprintf('imgind_cl%d =  find(I == c);', c))
end


[cl, rnk] = sort(tbl(:,2), 'descend')





subplot(2,2, 1)

scatter(latbos, lonbos)
hold on
scatter(lat_cl, lon_cl)
hold on 

for i = 1:100
   

eval(sprintf('scatter(latbos(imgind_cl%d), lonbos(imgind_cl%d), ''filled'')', rnk(i), rnk(i)))
hold on 
scatter(lat_cl(rnk(i)), lon_cl(rnk(i)), '*')
hold on 
    
end



subplot(2,2, 2)

scatter(latbos, lonbos)
hold on
scatter(lat_cl, lon_cl)
hold on 


for i = 1:100

    scatter(latbos(find(idx==i)), lonbos(find(idx ==i)), 'filled')
    hold on 
    scatter(cent(i, 1), cent(i,2), '*')
    hold on
    
end


C_cl = NaN*zeros(length(clusters), length(clusters));

for i = 1:length(clusters)

    for j = 1:length(clusters)
       
        [i,j]
        
       eval(sprintf('C_cl(%d,%d) = sum(sum(Cbos(imgind_cl%d, imgind_cl%d)));', i,j, i, j))
       
        
    end
    
end



C_clbos = C_cl ;
%diag(C_cl) = zeros(length(clusters), 1);  % why doesn't this work???




