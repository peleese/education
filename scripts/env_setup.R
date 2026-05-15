library(readr)
library(dplyr)
library(sqldf)
##library(arrow)
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

# ============================
# 3. Create usable concept tables
# ============================


# Unique concept IDs
cond_concepts <- condition_occurrence %>%
  select(condition_concept_id) %>%
  mutate(condition_concept_id = as.integer(condition_concept_id)) %>%
  rename(concept_id = condition_concept_id) %>%
  distinct() %>%
  tidyr::drop_na()

rm(condition_occurrence)

proc_concepts <- procedure_occurrence %>%
  select(procedure_concept_id) %>%
  mutate(procedure_concept_id = as.integer(procedure_concept_id)) %>%
  rename(concept_id = procedure_concept_id) %>%
  distinct() %>%
  tidyr::drop_na()

rm(procedure_occurrence)

drug_concepts <- drug_exposure %>%
  select(drug_concept_id) %>%
  mutate(drug_concept_id = as.integer(drug_concept_id)) %>%
  rename(concept_id = drug_concept_id) %>%
  distinct() %>%
  tidyr::drop_na()

rm(drug_exposure)

observation_concepts <- observation %>%
  select(observation_concept_id) %>%
  mutate(observation_concept_id = as.integer(observation_concept_id)) %>%
  rename(concept_id = observation_concept_id) %>%
  distinct() %>%
  tidyr::drop_na()

rm(observation)

measurement_concepts <- measurement %>%
  select(measurement_concept_id) %>%
  mutate(measurement_concept_id = as.integer(measurement_concept_id)) %>%
  rename(concept_id = measurement_concept_id) %>%
  distinct() %>%
  tidyr::drop_na()

visit_concepts <- visit_occurrence %>%
  select(visit_concept_id) %>%
  mutate(visit_concept_id = as.integer(visit_concept_id)) %>%
  rename(concept_id = visit_concept_id) %>%
  distinct() %>%
  tidyr::drop_na()

all_concepts = rbind(cond_concepts,
                     proc_concepts,
                     drug_concepts,
                     observation_concepts,
                     measurement_concepts,
                     visit_concepts)


# Pull matching concepts from omopcept
concepts <- omopcept::omop_concept() %>%
  filter(concept_id %in% all_concepts$concept_id) %>%
  collect()



# ============================
# 4. Clean-up directories
# ============================

library(fs)

dir_create("OMOP")

files <- dir_ls("raw/mimic_IV_omop_data_csv", type = "file") 

# Move them
file_move(files, "OMOP")

# Write better concepts table
write_csv(concepts,               "OMOP/concepts.csv")

#delete raw directory
dir_delete("raw")



cat("All processed CSVs written to /processed\n")
## this program creates the foundational environment in binder
