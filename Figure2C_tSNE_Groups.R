#Import Relative Abundance Excel Sheet
ra2_0S = read_excel("SampleAbundance.xlsx") #Combined "SampleAbundance1.xlsx" and "SampleAbundance2.xlsx" into one table "SampleAbundance.xlsx"
ra2_0S = as.data.frame(ra2_0S)
rownames(ra2_0S) = ra2_0S$Sample

#Import Metadata Excel Sheet
hh = read_excel("Metadata_Evvy.xlsx")
hh = as.data.frame(hh)

#Combine Relative Abundance & Metadata into One Table
hhra0 = left_join(ra2_0S, hh, by = "Sample")

#tSNE Values
library(Rtsne)
set.seed(123) 

tsne0 = Rtsne(ra2_0, dims = 2, perplexity = 50, max_iter = 1000, verbose = TRUE)
tsne_0 = as.data.frame(tsne0$Y)
colnames(tsne_0) <- c("tSNE1","tSNE2")
tsne_0$CST <- anno$CST

#tSNE Plot
ggplot(tsne_0, aes(x = tSNE1, y = tSNE2, color = Groups)) +
  geom_point(size = 1) + theme_minimal() + theme(plot.title = element_text(size=24)) +
 scale_color_manual(values = c(ND = "#00BFC4", UTI = "#C77CFF", BV = "#F8766D", "BV&UTI" = "#7CAE00"))  +
  labs(title = "t-SNE by Groups", x = "t-SNE 1", y = "t-SNE 2")
