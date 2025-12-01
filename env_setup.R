library(readr)
library(dplyr)
library(sqldf)
library(arrow)
library(omopcept)

# ============================
# 1. Unzip only needed files
# ============================

zipfile <- "mimic_IV_omop_data_csv.zip"
unzip(zipfile, exdir = "raw")

# Paths inside the unzipped folder
data_dir <- "raw/mimic_IV_omop_data_csv"

# ============================
# 2. Read required CSVs
# ============================

person               <- read_csv(file.path(data_dir, "person.csv"))
condition_occurrence <- read_csv(file.path(data_dir, "condition_occurrence.csv"))
procedure_occurrence <- read_csv(file.path(data_dir, "procedure_occurrence.csv"))
measurement          <- read_csv(file.path(data_dir, "measurement.csv"))
visit_occurrence     <- read_csv(file.path(data_dir, "visit_occurrence.csv"))
drug_exposure        <- read_csv(file.path(data_dir, "drug_exposure.csv"))
observation          <- read_csv(file.path(data_dir, "observation.csv"))
concept              <- read_csv(file.path(data_dir, "2b_concept.csv"))
concept_relationship <- read_csv(file.path(data_dir, "2b_concept_relationship.csv"))

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

# ============================
# 4. Write everything back to CSV
# ============================

dir.create("processed", showWarnings = FALSE)

write_csv(person,               "processed/person.csv")
write_csv(condition_occurrence, "processed/condition_occurrence.csv")
write_csv(procedure_occurrence, "processed/procedure_occurrence.csv")
write_csv(measurement,          "processed/measurement.csv")
write_csv(visit_occurrence,     "processed/visit_occurrence.csv")
write_csv(drug_exposure,        "processed/drug_exposure.csv")
write_csv(observation,          "processed/observation.csv")
write_csv(concept,              "processed/concept.csv")
write_csv(concept_relationship, "processed/concept_relationship.csv")

write_csv(cond_concepts,        "processed/cond_concepts.csv")
write_csv(concept_conditions,   "processed/concept_conditions.csv")

cat("All processed CSVs written to /processed\n")
## this program creates the foundational environment in binder
