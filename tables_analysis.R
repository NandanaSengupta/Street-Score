setwd('/Users/Nandana/Dropbox/images')

a = read.csv("test_all_112.csv")

original = TRUE
analysis = FALSE

if (analysis){
max_ind = function(x){max_ind = which(x == max(x))}
b = apply(a[14:dim(a)[2]], 1, max_ind )

sort.int(table(b), index = TRUE)$ix

m = a[14:56]
l = vector()
for ( j in 1:dim(a)[1]){
	
	l = c(l, length(which(m[j, ]>0.05)))
	
}

check = 1

}

d = a[-13]
names(d)
write.csv(d, "street_score_withfeatures_112.csv")




if (original){
	
	f = read.csv("test_all.csv")
	g = which(apply(f, 1, sum) ==0)
	f_fin = f[-g,]
	f_fin = cbind(a[1:12], f_fin)
	
	write.csv(f_fin, "street_score_withfeatures.csv")
	
	
}