library(readr)
library(dplyr)
library(sqldf)
library(arrow)
library(omopcept)

# ============================
# 1. Unzip only needed files
# ============================

zipfile <- "mimic_IV_omop_data_csv.zip"
unzip(zipfile)

# ============================
# 3. Example transformation
# ============================

# Unique condition concept IDs
cond_concepts <- condition_occurrence %>%
  select(condition_concept_id) %>%
  mutate(condition_concept_id = as.integer(condition_concept_id)) %>%
  distinct() %>%
  tidyr::drop_na()

# Pull matching concepts from omopcept
concept_conditions <- omopcept::omop_concept() %>%
  filter(concept_id %in% cond_concepts$condition_concept_id) %>%
  collect()



write_csv(cond_concepts,        "processed/cond_concepts.csv")
write_csv(concept_conditions,   "processed/concept_conditions.csv")

cat("All processed CSVs written to /processed\n")
## this program creates the foundational environment in binder
