#Import Relative Abundance Excel Sheet
ra2_0S = read_excel("SampleAbundance.xlsx") #Combined "SampleAbundance1.xlsx" & "SampleAbundance2.xlsx" into one table "SampleAbundance.xlsx"
ra2_0S = as.data.frame(ra2_0S)
rownames(ra2_0S) = ra2_0S$Sample

#Import Metadata Excel Sheet
hh = read_excel("Metadata_Evvy.xlsx")
hh = as.data.frame(hh)

#Combine Relative Abundance & Metadata into One Table
hhra0 = left_join(ra2_0S, hh, by = "Sample")

#Aitchison CLR Values
library(compositions)
ra0_pseudo = ra2_0 + 1
ra2_0clr = clr(ra0_pseudo)
pca_clr = prcomp(ra2_0clr, center=TRUE, scale. = FALSE)

clr = as.data.frame(pca_clr$x)
clr$groups = anno$Groups

#Aitchison PCA
ggplot(clr, aes(PC1, PC2, color = groups, fill = groups)) +
  geom_point(size = 1) +
  stat_ellipse(geom = "polygon", alpha = 0.05) +
  theme_minimal() + 
  theme(title = element_text(size = 16), 
        axis.text = element_text(size = 11), 
        axis.title = element_text(size = 16), 
        plot.title = element_text(size = 24), 
        legend.text = element_text(size = 12)) + 
  labs(title = "Aitchison PCA (CLR)", color = "Groups", fill = "Groups") + 
  scale_color_manual(values = c("#00BFC4","#C77CFF","#F8766D","#7CAE00")) + 
  scale_fill_manual(values = c("#00BFC4","#C77CFF","#F8766D","#7CAE00"))
