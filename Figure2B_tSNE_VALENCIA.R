#Import Relative Abundance Excel Sheet
ra2_0S = read_excel("SampleAbundance.xlsx")
ra2_0S = as.data.frame(ra2_0S)
rownames(ra2_0S) = ra2_0S$Sample

#Import Metadata Excel Sheet
hh = read_excel("Metadata_Evvy.xlsx")
hh = as.data.frame(hh)

#Combine Relative Abundance & Metadata into One Table
hhra0 = left_join(ra2_0S, hh, by = "Sample")

#Load Packages
library(Rtsne)
set.seed(123) #consistent results/reproducibility, not stochastic

#tSNE values
tsne0 = Rtsne(ra2_0, dims = 2, perplexity = 50, max_iter = 1000, verbose = TRUE)
tsne_0 = as.data.frame(tsne0$Y)
colnames(tsne_0) <- c("tSNE1","tSNE2")
tsne_0$Valencia <- anno$"Valencia Type"

#tSNE Plot
ggplot(tsne_0, aes(x = tSNE1, y = tSNE2, color = Valencia)) +
  geom_point(size = 1) +
  theme_minimal() + theme(plot.title = element_text(size=24)) +
  scale_color_manual(values = c("#4F81BD", "#95B3D7", "#8064A2", "#9BBB59", "#C4D79B", "#632523", "#963634","#C0504D", "#DA9694", "#E6B8B7", "#F2DCDB", "#F2F2F2", "#4BACC6")) +
  labs(title = "t-SNE by Valencia Type", x = "t-SNE 1", y = "t-SNE 2")
