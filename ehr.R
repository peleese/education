library(readr)
library(dplyr)


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
