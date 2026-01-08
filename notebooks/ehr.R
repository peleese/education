library(readr)
library(dplyr)
library(sqldf)


##set root working directory

setwd("/home/jovyan")


##load csvs as dataframes 
person = as.data.frame(read.csv("OMOP/person.csv"))

condition_occurrence = as.data.frame(read.csv("OMOP/condition_occurrence.csv"))

visit_occurrence = as.data.frame(read.csv("OMOP/visit_occurrence.csv"))

drug_exposure = as.data.frame(read.csv("OMOP/drug_exposure.csv"))

observations = as.data.frame(read.csv("OMOP/observation.csv"))

procedure_occurrence = as.data.frame(read.csv("OMOP/procedure_occurrence.csv"))

measurement = as.data.frame(read.csv("OMOP/measurement.csv"))

concept = as.data.frame(read.csv("OMOP/concepts.csv"))


#lets look at those dataframes
person %>%
  select(person_id, gender_concept_id, gender_source_value) %>%
  head()


condition_occurrence %>%
  select(condition_occurrence_id, condition_concept_id, condition_source_value) %>%
  head()


#join conditions to concept to pick up the concept names
sqldf("select 
        condition_occurrence_id,
        condition_concept_id,
        condition_source_value,
        concept_name
       from condition_occurrence a LEFT JOIN concept b on a.condition_concept_id = b.concept_id
       limit 10"
)
