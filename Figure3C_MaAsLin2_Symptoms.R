getwd()
setwd("/Users/nicolegilbert/Downloads/maslin2")   # adjust path as needed


# Start fresh
rm(list = ls())

# Read feature data
input_data <- read.csv(
  "GilbertCohorts_10003_SAGEv2.2_MarkerGene_Abundance_0.1Threshold2.csv",
  row.names   = 1,
  check.names = FALSE
)
# install.packages("readxl")  # run once if not installed
library(readxl)
# Read metadata
# Read the Excel file (first sheet by default)
meta_raw <- read_excel("EvvyMaaslin_Symptomupdate.xlsx")

# Set sample IDs as rownames for metadata
rownames(meta_raw) <- meta_raw$Sample
input_metadata <- meta_raw[, !(names(meta_raw) %in% "Sample"), drop = FALSE]
# Dimensions
dim(input_data)
dim(input_metadata)

# What do the sample IDs look like?
head(colnames(input_data))
head(rownames(input_metadata))

# Show a few more to be sure
head(colnames(input_data), 20)
head(rownames(input_metadata), 20)
common_samples <- intersect(colnames(input_data), rownames(input_metadata))
length(common_samples)
head(common_samples, 20)

rm(list = ls())

# Read feature data: samples as rownames, taxa as columns (current layout)
input_data_raw <- read.csv(
  "GilbertCohorts_10003_SAGEv2.2_MarkerGene_Abundance_0.1Threshold2.csv",
  check.names = FALSE
)

# Confirm what the first column is
head(input_data_raw[, 1, drop = FALSE])
colnames(input_data_raw)[1]
rownames(input_data_raw) <- input_data_raw[[1]]
input_data_raw <- input_data_raw[, -1, drop = FALSE]
input_data <- t(input_data_raw)

# Check: now colnames should be sample IDs
head(colnames(input_data), 10)
dim(input_data)
install.packages("readxl")  # only once
library(readxl)

meta_raw <- read_excel(
  "EvvyMaaslin_Symptomupdate.xlsx"
)
meta_raw <- readxl(
  "EvvyMaaslin_Symptomupdate.xlsx",
  check.names = FALSE
)
meta_raw <- as.data.frame(meta_raw, check.names = FALSE)
rownames(meta_raw) <- meta_raw$Sample
input_metadata <- meta_raw[, !(names(meta_raw) %in% "Sample"), drop = FALSE]

head(rownames(input_metadata), 10)
dim(input_metadata)
common_samples <- intersect(colnames(input_data), rownames(input_metadata))
length(common_samples)
head(common_samples, 20)
input_data     <- input_data[, common_samples, drop = FALSE]
input_metadata <- input_metadata[common_samples, , drop = FALSE]

dim(input_data)
dim(input_metadata)
# Check that sample IDs match and are in the same order
all(colnames(input_data) == rownames(input_metadata))
# Should return TRUE

library(Maaslin2)
fit_data <- Maaslin2(
  input_data     = input_data,
  input_metadata = input_metadata,
  output         = "/Users/nicolegilbert/Downloads/maslin2/Maaslin/020525_Evvy_Symptoms",
  fixed_effects  = c("VAGINA_PAIN","VULVA_PAIN","VULVA_REDNESS","VAGINAL_SWELLING","EXTERNAL_ITCHINESS","INTERNAL_ITCHINESS","DRYNESS","BURNING_SENSATION","PAIN_WITH_SEX","PAIN_WHILE_PEEING","EXCESSIVE_DISCHARGE","ODOROUS_DISCHARGE","VAGINAL_SMELL"),
  reference      = c("VAGINAL_SMELL,NO"),
  normalization  = "TSS",
  transform      = "LOG",
  min_prevalence = 0.1,
  min_abundance  = 0.000,
  analysis_method  = "LM",
  max_significance = 0.25,
  standardize      = TRUE
)
# Make a heatmap
library(dplyr)
library(tidyr)
library(pheatmap)
library(tidyverse)

setwd("/Users/nicolegilbert/Downloads/maslin2/Maaslin/020525_Evvy_Symptoms")

# 1. Read results
all_results <- read_tsv("all_results.tsv")

# 2. Compute signed -log10(q) and cap between -20 and 20
sig_res <- all_results %>%
  filter(qval < 0.25) %>%  # same threshold as MaAsLin heatmap
  mutate(
    signed_logq = -log10(qval) * sign(coef),
    signed_logq = pmax(pmin(signed_logq, 20), -20)
  )

# 3. Collapse duplicates: one value per (feature, metadata)
#    Use the value with largest absolute signed_logq (most "significant")
sig_res_unique <- sig_res %>%
  mutate(meta_level = paste(metadata, value, sep = "."))


# 4. Select top 50 features by max |signed_logq|
top_features <- sig_res_unique %>%
  group_by(feature) %>%
  summarise(max_abs = max(abs(signed_logq)), .groups = "drop") %>%
  arrange(desc(max_abs)) %>%
  slice(1:50) %>%
  pull(feature)

# 5. Long → wide: rows = feature, columns = metadata
top_mat_long <- sig_res_unique %>%
  filter(feature %in% top_features) %>%
  select(feature, meta_level, signed_logq)

heat_mat <- top_mat_long %>%
  pivot_wider(
    names_from = meta_level,
    values_from = signed_logq
  ) %>%
  column_to_rownames("feature") %>%
  as.matrix()

library(pheatmap)

# Check current columns:
colnames(heat_mat)

# Specify desired order (edit this to your liking, matching colnames exactly)
new_col_order <- c("ODOROUS_DISCHARGE.YES","VAGINAL_SMELL.FI","VAGINAL_SMELL.RO","EXCESSIVE_DISCHARGE.YES","EXTERNAL_ITCHINESS.YES","INTERNAL_ITCHINESS.YES","VULVA_REDNESS.YES","BURNING_SENSATION.YES","PAIN_WHILE_PEEING.YES")

heat_mat_reordered <- heat_mat[, new_col_order, drop = FALSE]

library(pheatmap)
# Replace NA with 0
heat_mat_no_na <- heat_mat_reordered
heat_mat_no_na[is.na(heat_mat_no_na)] <- 0
library(pheatmap)
pheatmap(
  heat_mat_no_na,
  color  = colorRampPalette(c("blue", "white", "red"))(50),
  breaks = seq(-20, 20, length.out = 51),
  cluster_rows = TRUE,
  cluster_cols = FALSE,
  scale = "none",
  border_color = NA,
  filename = "heatmap_custom_order_simplified_051325.pdf",
  width = 8, height = 10
)
getwd()

file.exists("heatmap_custom_order.pdf")

getwd()
list.files()
library(pheatmap)

pdf("heatmap_custom_order.pdf", width = 8, height = 10)

pheatmap(
  heat_mat_no_na,                         # or heat_mat_reordered if no NAs
  color  = colorRampPalette(c("blue", "white", "red"))(50),
  breaks = seq(-20, 20, length.out = 51),
  cluster_rows = TRUE,                   # or FALSE if you turned clustering off
  cluster_cols = FALSE,
  scale = "none",
  border_color = NA
)

dev.off()
file.exists("heatmap_custom_order.pdf")
list.files(pattern = "heatmap_custom_order")

library(pheatmap)

pheatmap(
  heat_mat_no_na,   # or heat_mat_reordered if you turned off clustering
  color  = colorRampPalette(c("blue", "white", "red"))(50),
  breaks = seq(-20, 20, length.out = 51),
  cluster_rows = TRUE,    # or FALSE if you prefer
  cluster_cols = FALSE,
  scale = "none",
  border_color = NA
)

library(pheatmap)

# 1. Make sure heat_mat_no_na exists and has no NA/Inf
#    (if you only have heat_mat_reordered, create heat_mat_no_na from it)
heat_mat_no_na <- heat_mat_reordered
heat_mat_no_na[is.na(heat_mat_no_na)] <- 0
heat_mat_no_na[is.infinite(heat_mat_no_na)] <- 0

summary(as.vector(heat_mat_no_na))
sum(is.na(heat_mat_no_na))
sum(is.infinite(heat_mat_no_na))
# both sums should be 0

# 2. Confirm where the file will be written
getwd()

# 3. Open PDF device
pdf("heatmap_custom_order.pdf", width = 8, height = 10)

# 4. Draw the heatmap (no clustering issues because NAs/Inf are gone)
pheatmap(
  heat_mat_no_na,
  color  = colorRampPalette(c("blue", "white", "red"))(50),
  breaks = seq(-20, 20, length.out = 51),
  cluster_rows = TRUE,      # set FALSE if you don't want clustering
  cluster_cols = FALSE,
  scale = "none",
  border_color = NA
)

# 5. Close the device
dev.off()
file.info("heatmap_custom_order.pdf")$size

