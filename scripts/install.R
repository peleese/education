
# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Core tidyverse packages for data manipulation and visualization
install.packages("readr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("sqldf")
install.packages("remotes")
remotes::install_github("catalamarti/omopcept")
##install.packages("arrow")

