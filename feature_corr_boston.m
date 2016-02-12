clear all;
close all;

cd('/Users/Nandana/Dropbox/Place_Pulse_Opt_Code')

% safety votes data 
load('Cold.mat')

ids = readtable('image_id_by_city.csv');

nyc = table2array(ids((1:height(ids)), 1));

bos = table2array(ids((1: 1237), 2));

linz = table2array(ids((1: 650), 3));

salz = table2array(ids((1:544), 4));



Cnyc = C(nyc, nyc);

Cbos = C(bos, bos);

Clinz = C(linz, linz);

Csalz = C(salz, salz);

%(within-city accounts for 50 percent of the comparisons)





% Now to get the physical and feature distances

features10 = readtable('streetscore_withfeatures10.csv');
featuresids = table2array(features10(:,1));
features10 = features10(ismember(featuresids, bos), :);

% sanity check

hist(table2array(features10(:, 8)))
hist(table2array(features10(:, 9)))


C = Cbos;

T = zeros(size(C)); 
P = zeros(size(C)); 


for i = 1: length(C)
        
    for j = 1: length(C)

        [i,j] 
        
        T(i,j) = C(i,j) + C(j,i);
        
        T(j,i) =  T(j,i);
        
        if T(i,j) == 0
            P(i,j) = -1;
            P(j,i) = -1;
        else P(i,j) = C(i,j)/T(i,j);
             P(j,i) = 1-P(i,j);
        end
        
       
        
    end
end

T(logical(eye(size(T)))) = -1; 
P(logical(eye(size(P)))) = -1; 

% Borda Score 
bs = NaN*ones(length(P),1);

for i = 1: length(P) 
    bs(i) = sum(P(i, P(i,:) >0))/length(P(i, P(i,:) >0));
end



% features distance and physical distance

D = zeros(height(features10), height(features10)); 
F1 = zeros(height(features10), height(features10)); 
F2 = zeros(height(features10), height(features10)); 
F3 = zeros(height(features10), height(features10)); 
F4 = zeros(height(features10), height(features10)); 
F5 = zeros(height(features10), height(features10)); 
F6 = zeros(height(features10), height(features10)); 
F7 = zeros(height(features10), height(features10)); 
F8 = zeros(height(features10), height(features10)); 
F9 = zeros(height(features10), height(features10)); 
F10 = zeros(height(features10), height(features10)); 

BS = zeros(height(features10), height(features10)); 
YAV = zeros(height(features10), height(features10)); 
YTOT = zeros(height(features10), height(features10)); 




lat = table2array(features10(:,8));
lon = table2array(features10(:,9));
f1 = table2array(features10(:,12));
f2 = table2array(features10(:,13));
f3 = table2array(features10(:,14));
f4 = table2array(features10(:,15));
f5 = table2array(features10(:,16));
f6 = table2array(features10(:,17));
f7 = table2array(features10(:,18));
f8 = table2array(features10(:,19));
f9 = table2array(features10(:,20));
f10 = table2array(features10(:,21));






for i = 1: height(features10)
    
    for j = 1: height(features10)
       
        
        [i,j] 
        
        % physical distance
        
       
        dlon = degtorad(lon(j)) - degtorad(lon(i)) ;
        dlat = degtorad(lat(j)) - degtorad(lat(i)) ;
        a = (sin(dlat/2))^2 + cos(degtorad(lat(i))) * cos(degtorad(lat(j))) * (sin(dlon/2))^2; 
        D(i,j) = 3961*2 * atan2( sqrt(a), sqrt(1-a) ) ;
        
        
         % feature distance 
        
        F1(i,j) = f1(i) - f1(j);       
        F2(i,j) = f2(i) - f2(j);
        F3(i,j) = f3(i) - f3(j);       
        F4(i,j) = f4(i) - f4(j);
        F5(i,j) = f5(i) - f5(j);       
        F6(i,j) = f6(i) - f6(j);
        F7(i,j) = f7(i) - f7(j);       
        F8(i,j) = f8(i) - f8(j);
        F9(i,j) = f9(i) - f9(j);       
        F10(i,j) = f10(i) - f10(j);
       
        
        % borda score diff
        
        BS(i,j) = bs(i) - bs(j) ;
        
        
        % votes diff 
        YTOT(i,j) = C(i,j) - C(j,i);
        YAV(i,j) = YTOT(i,j)/T(i,j);
        
        
    end
end


% Post processing 

% convert matrices to arrays  (lower triangular)

%%%%% b = a(a ==tril(a, -1))


yav_vec = [];
ytot_vec = [];
d_vec = [];
p_vec = [];
bs_vec = [];
f1_vec = [];
f2_vec = [];
f3_vec = [];
f4_vec = [];
f5_vec = [];
f6_vec = [];
f7_vec = [];
f8_vec = [];
f9_vec = [];
f10_vec = [];

for i = 2: length(C) 
      i
        yav_vec = [yav_vec, YAV(i,1:i-1)];
        ytot_vec = [ytot_vec, YTOT(i, 1:i-1)];
        bs_vec = [bs_vec, BS(i,1:i-1)];
        d_vec = [d_vec, D(i,1:i-1)];
        p_vec = [p_vec, P(i,1:i-1)];
        f1_vec = [f1_vec, F1(i,1:i-1)];
        f2_vec = [f2_vec, F2(i,1:i-1)];
        f3_vec = [f3_vec, F3(i,1:i-1)];
        f4_vec = [f4_vec, F4(i,1:i-1)];
        f5_vec = [f5_vec, F5(i,1:i-1)];
        f6_vec = [f6_vec, F6(i,1:i-1)];
        f7_vec = [f7_vec, F7(i,1:i-1)];
        f8_vec = [f8_vec, F8(i,1:i-1)];
        f9_vec = [f9_vec, F9(i,1:i-1)];
        f10_vec = [f10_vec, F10(i,1:i-1)];

        

end


%%% save everything!

%save('corr_streetscore.mat', 'f1_vec', 'f2_vec', 'f3_vec', 'f4_vec', 'f5_vec', ...
  %  'f6_vec', 'f7_vec', 'f8_vec', 'f9_vec', 'f10_vec', 'yav_vec', 'ytot_vec', 'bs_vec', 'p_vec', 'd_vec')


%save('matrices_streetscore.mat', 'F1', 'F2', 'F3', 'F4', 'F5', ...
   % 'F6', 'F7', 'F8', 'F9', 'F10', 'YAV', 'YTOT', 'BS', 'P', 'D')


% correlation coefficients for different features with borda scores and
% total and average votes

b1 = regress(bs_vec', f1_vec');
b2 = regress(bs_vec', f2_vec');
b3 = regress(bs_vec', f3_vec');
b4 = regress(bs_vec', f4_vec');
b5 = regress(bs_vec', f5_vec');
b6 = regress(bs_vec', f6_vec');
b7 = regress(bs_vec', f7_vec');
b8 = regress(bs_vec', f8_vec');
b9 = regress(bs_vec', f9_vec');
b10 = regress(bs_vec', f10_vec');

b = [b1, b2, b3, b4, b5, b6, b7, b8, b9, b10]


figure(1) 

subplot(2,3,1) 
scatter(bs_vec(1:25000), f1_vec(1:25000))
xlabel('borda score diff')
ylabel('Feature F1 difference')

subplot(2,3,2) 
scatter(bs_vec(1:25000), f2_vec(1:25000))
xlabel('borda score diff')
ylabel('Feature F2 difference')

subplot(2,3,3) 
scatter(bs_vec(1:25000), f3_vec(1:25000))
xlabel('borda score diff')
ylabel('Feature F3 difference')

subplot(2,3,4) 
scatter(bs_vec(1:25000), f4_vec(1:25000))
xlabel('borda score diff')
ylabel('Feature F4 difference')

subplot(2,3,5) 
scatter(bs_vec(1:25000), f5_vec(1:25000))
xlabel('borda score diff')
ylabel('Feature F5difference')

subplot(2,3,6) 
scatter(bs_vec(1:25000), f6_vec(1:25000))
xlabel('borda score diff')
ylabel('Feature F6 difference')

plothandle2 = figure(2);
subplot(2,2,1) 
scatter(bs_vec(1:25000), f7_vec(1:25000))
subplot(2,2,2) 
scatter(bs_vec(1:25000), f8_vec(1:25000))
subplot(2,2,3) 
scatter(bs_vec(1:25000), f9_vec(1:25000))
subplot(2,2,4) 
scatter(bs_vec(1:25000), f10_vec(1:25000))





y1 = regress(yav_vec', f1_vec');
y2 = regress(yav_vec', f2_vec');
y3 = regress(yav_vec', f3_vec');
y4 = regress(yav_vec', f4_vec');
y5 = regress(yav_vec', f5_vec');
y6 = regress(yav_vec', f6_vec');
y7 = regress(yav_vec', f7_vec');
y8 = regress(yav_vec', f8_vec');
y9 = regress(yav_vec', f9_vec');
y10 = regress(yav_vec', f10_vec');

y = [y1, y2, y3, y4, y5, y6, y7, y8, y9, y10]




figure(3) 

subplot(2,3,1) 
scatter(yav_vec(1:25000), f1_vec(1:25000))
xlabel('average wins')
ylabel('Feature F1 difference')

subplot(2,3,2) 
scatter(yav_vec(1:25000), f2_vec(1:25000))
xlabel('average wins')
ylabel('Feature F2 difference')


subplot(2,3,3) 
scatter(yav_vec(1:25000), f3_vec(1:25000))
xlabel('average wins')
ylabel('Feature F3 difference')

subplot(2,3,4) 
scatter(yav_vec(1:25000), f4_vec(1:25000))
xlabel('average wins')
ylabel('Feature F4 difference')

subplot(2,3,5) 
scatter(yav_vec(1:25000), f5_vec(1:25000))
xlabel('average wins')
ylabel('Feature F5 difference')

subplot(2,3,6) 
scatter(yav_vec(1:25000), f6_vec(1:25000))
xlabel('average wins')
ylabel('Feature F6 difference')

plothandle4 = figure(4);
subplot(2,2,1) 
scatter(yav_vec(1:25000), f7_vec(1:25000))
xlabel('average wins')
ylabel('Feature F7 difference')
subplot(2,2,2) 
scatter(yav_vec(1:25000), f8_vec(1:25000))
xlabel('average wins')
ylabel('Feature F8 difference')

subplot(2,2,3) 
scatter(yav_vec(1:25000), f9_vec(1:25000))
xlabel('average wins')
ylabel('Feature F9 difference')

subplot(2,2,4) 
scatter(yav_vec(1:25000), f10_vec(1:25000))
xlabel('average wins')
ylabel('Feature F10 difference')




plothandle5= figure(5) ;

subplot(2,3,1) 
scatter(ytot_vec(1:25000), f1_vec(1:25000))
subplot(2,3,2) 
scatter(ytot_vec(1:25000), f2_vec(1:25000))
subplot(2,3,3) 
scatter(ytot_vec(1:25000), f3_vec(1:25000))
subplot(2,3,4) 
scatter(ytot_vec(1:25000), f4_vec(1:25000))
subplot(2,3,5) 
scatter(ytot_vec(1:25000), f5_vec(1:25000))
subplot(2,3,6) 
scatter(ytot_vec(1:25000), f6_vec(1:25000))

plothandle6 = figure(6);
subplot(2,2,1) 
scatter(ytot_vec(1:25000), f7_vec(1:25000))
subplot(2,2,2) 
scatter(ytot_vec(1:25000), f8_vec(1:25000))
subplot(2,2,3) 
scatter(ytot_vec(1:25000), f9_vec(1:25000))
subplot(2,2,4) 
scatter(ytot_vec(1:25000), f10_vec(1:25000))




% distance -- remove all whose distance is greater than 80 miles, 40 miles,
% 20 miles, 10 miles and plot ze graphs

close all; 

hist(d_vec)

close all; 

figure(1)
subplot(2,2,1)
scatter( p_vec(d_vec<5 & p_vec>-1), d_vec(d_vec<5 & p_vec>-1))
xlabel('Pij values')
ylabel('Distance between i and j in miles ')
title('5 miles')

subplot(2,2,2)
scatter( p_vec(d_vec<2 & p_vec>-1), d_vec(d_vec<2 & p_vec>-1))
xlabel('Pij values')
ylabel('Distance between i and j in miles ')
title('2 miles')

subplot(2,2,3)
scatter( p_vec(d_vec<1 & p_vec>-1), d_vec(d_vec<1 & p_vec>-1))
xlabel('Pij values')
ylabel('Distance between i and j in miles ')
title('1 miles')


subplot(2,2,4)
scatter( p_vec(d_vec<0.5 & p_vec>-1), d_vec(d_vec<0.5 & p_vec>-1))
xlabel('Pij values')
ylabel('Distance between i and j in miles ')
title('0.5 miles')



regress( p_vec(d_vec<10 & p_vec>0 & p_vec<1)', d_vec(d_vec<10 & p_vec>0 & p_vec <1)')

scatter( p_vec(d_vec<10 & p_vec>0 & p_vec<1)', d_vec(d_vec<10 & p_vec>0 & p_vec <1)')





