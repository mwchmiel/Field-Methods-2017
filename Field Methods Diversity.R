#these first two lines will install packages from the main R repository of packages, as well as a package called SpadeR from github
install.packages(c('devtools', 'vegan'))
install_github('AnneChao/SpadeR')

#these load the various packages, allowing access to their various functions
library(vegan)
library(devtools)
library(SpadeR)

#here we load the dataset, letting the function know that the first row and column have labels in them
shannondata<-read.csv("FMinsectdata.csv", header = TRUE, row.names = 1)
#now we can look and see the beginning few rows of our dataset
head(shannondata)

#now calculate the shannon diversity
diversity(shannondata, base = 10)

#transpose the data frame, as the next function requires it to be in this format
shannon2<-t(shannondata)

#here we process the data for community similarity in a pairwise fashion and assing the output to "arthrosim"
arthrosim<-SimilarityMult(shannon2, datatype="abundance", q=1, goal="relative", nboot=200)

#can pull out the Horn values for similarity and assign them to a table
similaritytable<-arthrosim$similarity.matrix$Horn

#here we just pull out the names for the sites to label our table
sitesvector<-colnames(shannon2)

#and now assign those names to the rows and columns
rownames(similaritytable)<-sitesvector
colnames(similaritytable)<-sitesvector

#now the table is complete
similaritytable

#this will write the table to a csv file in the folder we are working in
write.csv(similaritytable, "similarity.csv")

#create a non-metric multi-dimensional scaling plot (a very cursory one), with text labels (type="t")
arthromds<-metaMDS(shannondata, distance="bray")
plot(arthromds, type="t")

