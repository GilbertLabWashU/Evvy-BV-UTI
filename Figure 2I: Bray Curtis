library(vegan)
library(FD)
library(ade4)
library(ecodist)
library(ggplot2)

BrayCurtis0 = vegdist(ra2_0, method="bray")
BrayMatrix0 = as.matrix(BrayCurtis0)

#Create PCoA 
BrayPCA.0 = ecodist::pco(BrayCurtis0) #takes ~10-15 min
Bray0 = data.frame(pcoa1 = BrayPCA.0$vectors[,1],pcoa2=BrayPCA.0$vectors[,2])

#Scatterplot Bray-Curtis
ggplot(data = Bray0, aes(x=pcoa1, y=pcoa2, color = anno$Group)) + 
  geom_point() + 
  labs(x = "PC1", y = "PC2", title = "Bray-Curtis", color = "Groups") + theme(title = element_text(size=16), axis.text = element_text(size = 11), axis.title = element_text(size = 16), plot.title = element_text(size=24), legend.text = element_text(size = 12)) + stat_ellipse() + scale_color_manual(values = c("#00BFC4","#C77CFF","#F8766D","#7CAE00"))
