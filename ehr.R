library(readr);
library(dplyr);
library(sqldf);
library(omopcept);
library(arrow);


cond_concepts = condition_occurrence %>%
                select(condition_concept_id) %>% 
                mutate(
    condition_concept_id = as.integer(condition_concept_id)
  ) %>%
                unique() %>%
                collect() %>%
                na.omit())


test <- omopcept::omop_concept() %>%
  filter(concept_id %in% cond_concepts$condition_concept_id) %>%
  collect()


# R can read directly from zip files
person <- read_csv(unz("synthea_sample_data_csv_latest.zip", "patients.csv"))

condition_occurrence <- read_csv(unz("synthea_sample_data_csv_latest.zip", "conditions.csv"))

visit_occurrence <- read_csv(unz("synthea_sample_data_csv_latest.zip", "encounters.csv"))

drug_exposure <- read_csv(unz("synthea_sample_data_csv_latest.zip", "medications.csv"))

observation <- read_csv(unz("synthea_sample_data_csv_latest.zip", "observations.csv"))

procedure_occurrence <- read_csv(unz("synthea_sample_data_csv_latest.zip", "procedures.csv"))


# Or extract all files first
#unzip("data.zip", exdir = "data/")
#df <- read_csv("data/data.csv")

# Extract all files from zip
unzip('mimic_IV_omop_data_csv.zip')


#read all csv's into dataframes together in a list

dir_path <- "mimic_IV_omop_data_csv"

# List all CSV files in the directory
csv_files <- list.files(dir_path, full.names = TRUE)

# Read each CSV and store in a named list
dfs <- setNames(
  lapply(csv_files, read.csv),
  tools::file_path_sans_ext(basename(csv_files))
)

#extract specific dataframs from list into global environment
concept=dfs[["2b_concept"]]
