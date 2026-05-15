# Introduction to EHR Data


## Core Aspects of Electronic Health Records & Associated Data
---
### EHR Data is ***longitudinal***
- Electronic Health Record (EHR) data is digital information collected during healthcare delivery.
- Healthcare systems record many kinds of information about patients over time, including:

  - demographics
  - diagnoses
  - medications
  - procedures
  - laboratory measurements
  - vital signs
  - clinical observations
  - hospital visits

- EHR data is ***longitudinal***, meaning each patient accumulates medical events across time.

For example, a single patient may have multiple care delivery encounters over time:

| Date | Event |
|---|---|
| Jan 2020 | Primary care visit |
| Feb 2020 | Diabetes diagnosis |
| Mar 2020 | Prescribed metformin |
| Apr 2020 | Hemoglobin A1c lab |

This longitudinal structure is central to clinical research using EHR data.

---
### EHR data is ***hierarchical*** and we talk about this as data granularity.
- A single patient may have multiple care delivery encounters, and each of those encounters may have multiple labs, orders, and diagnoses.  
- In a tabular data view, this can be represented as:

Patient | Date | Event | Dx
|---|---|---|---|
123A| Jan 2020 | Primary care visit |I93.00
123A| Feb 2020 | Diabetes diagnosis |E23.00
123A| Mar 2020 | Prescribed metformin |I93.00
123A| Mar 2020 | Prescribed metformin |E23.00
123A| Apr 2020 | Hemoglobin A1c lab |G93.00
123A| Apr 2020 | Hemoglobin A1c lab |I93.00
123A| Apr 2020 | Hemoglobin A1c lab |E23.00

- Even from this simple table it becomes obvious that EHR data can have 1:1 relationships, 1:many, and many:1 relationships
- It may also be apparent that some concepts, such as diagnoses are frequently represented as codes rather than natural text
  - Healthcare employs standardized, controlled terminologies for many domains of data which we'll begin to identify and discuss in detail further in
  - Also, EHR data is overwhelmingly stored and utilized via relational databases and those databases give us many tools for working with EHR data and aspects more easily

- EHR data is ***hierarchical*** with the patient typically at the highest level of the hierarchy and large amounts of more granular data tied to each patient at more detailed levels
