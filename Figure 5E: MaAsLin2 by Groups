getwd()
setwd("/Users/nicolegilbert/Downloads/maslin2")   # adjust path as needed
list.files()
input_metadata$Cohort <- factor(
  input_metadata$Cohort,
  levels = c("Never diagnosed", "Diagnosed <50", "Diagnosed ≥50") # example
)

# Start fresh
rm(list = ls())

# Read feature data
input_data <- read.csv(
  "GilbertCohorts_10003_SAGEv2.2_MarkerGene_Abundance_0.1Threshold2.csv",
  row.names   = 1,
  check.names = FALSE
)

# Read metadata
meta_raw <- read.csv(
  "EvvyMaaslin.csv",
  check.names = FALSE
)

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
meta_raw <- read.csv(
  "EvvyMaaslin.csv",
  check.names = FALSE
)

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
# Example: make sure these columns exist; rename if needed
str(input_metadata[, c("Cohort", "AGE", "BMI", "RACE", "HORMONAL_MENOPAUSE")])

input_metadata$Cohort <- factor(input_metadata$Cohort)
input_metadata$Cohort <- relevel(input_metadata$Cohort, ref = "Never diagnosed")

input_metadata$AGE <- as.numeric(input_metadata$AGE)
input_metadata$BMI <- as.numeric(input_metadata$BMI)

input_metadata$RACE               <- factor(input_metadata$RACE)
input_metadata$HORMONAL_MENOPAUSE <- factor(input_metadata$HORMONAL_MENOPAUSE)
library(Maaslin2)
fit_data <- Maaslin2(
  input_data     = input_data,
  input_metadata = input_metadata,
  output         = "/Users/nicolegilbert/Downloads/maslin2/Maaslin/050526_Adjusted_newmaxsig_abundance_prevalence",
  fixed_effects  = c("Cohort", "RACE", "AGE", "BMI", "HORMONAL_MENOPAUSE"),
  reference      = c("Cohort,Never diagnosed"),
  normalization  = "TSS",
  transform      = "LOG",
  min_prevalence = 0.1,
  min_abundance  = 0.0001,
  analysis_method  = "LM",
  max_significance = 0.25,
  standardize      = TRUE
)
# Make a heat map
library(dplyr)
library(tidyr)
library(pheatmap)
library(tidyverse)

setwd("/Users/nicolegilbert/Downloads/maslin2/Maaslin/050526_Adjusted_newmaxsig_abundance_prevalence")

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
  group_by(feature, value) %>%
  slice_max(order_by = abs(signed_logq), n = 1, with_ties = FALSE) %>%
  ungroup()

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
  select(feature, value, signed_logq)

heat_mat <- top_mat_long %>%
  pivot_wider(
    names_from = value,
    values_from = signed_logq
  ) %>%
  column_to_rownames("feature") %>%
  as.matrix()

library(pheatmap)

# Check current columns:
colnames(heat_mat)

# Specify desired order (edit this to your liking, matching colnames exactly)
new_col_order <- c("UTI only","BV only","BV&UTI")

heat_mat_reordered <- heat_mat[, new_col_order, drop = FALSE]

pheatmap(
  heat_mat_reordered,
  color  = colorRampPalette(c("blue", "white", "red"))(50),
  breaks = seq(-20, 20, length.out = 51),
  cluster_rows = FALSE,    # <- disable, avoids hclust error
  cluster_cols = FALSE,    # keep your specified column order
  scale = "none",
  border_color = NA,
  filename = "_Cohort_heatmap_custom_order.pdf",
  width = 4, height = 10
)

