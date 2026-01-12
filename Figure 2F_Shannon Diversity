library(vegan)
ra2_0S$ShannonD = vegan::diversity(ra2_0, index = "shannon")

library(ggplot2)
library(ggbeeswarm)
library(ggpubr)

ggplot(ra2_0S, aes(Groups,ShannonD)) + 
  geom_boxplot(aes(fill = Groups), lwd = 0.5, outlier.shape = NA, alpha = 0.5) + 
  labs(title = "Shannon Diversity", x = NULL) + 
  stat_compare_means(stat_compare_means(label = "p.format", size = 9), comparisons = list(c("ND", "UTI"), c("ND", "BV"), c("ND", "BV&UTI"), c("UTI", "BV&UTI"))) + 
stat_compare_means(label.y = 6.5, size = 6) +
theme(panel.grid = element_blank(),
   panel.background = element_rect(fill="white"), 
   panel.border = element_rect(color = "gray", fill = NA, size = 0.5), 
   plot.title = element_text(hjust = 0.5, size = 24),
   axis.title = element_text(size = 20),
   axis.text.x = element_text(hjust = 0.5, size = 16),
   axis.text.y = element_text(size = 13),
   legend.key = element_blank(),
   legend.title = element_text(size = 13),
   legend.text = element_text(size = 11)) + 
  scale_y_continuous(name = "Shannon Index", limits = c(0, 1.7*max(ra2_0S$ShannonD))) + scale_fill_manual(
    values = c("ND" = "#00BFC4", "UTI" = "#C77CFF", "BV" = "#F8766D", "BV&UTI" = "#7CAE00"))
