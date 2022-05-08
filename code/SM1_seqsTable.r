###.............................................................................
# (c) Miguel Camacho Sánchez
# miguelcamachosanchez@gmail.com // miguelcamachosanchez.weebly.com
# https://scholar.google.co.uk/citations?user=1M02-S4AAAAJ&hl=en
# March 2021
#GOAL: Mann Whitney U test
#PROJECT: characterization-macrophomina
###.............................................................................
library(tidyverse)
library(reshape2)
library(officer)

seqs <- readRDS("data/intermediate/tidy_seqs.rds")

table1 <-
  dcast(seqs, species + isolate ~ locus, value.var = "gb")
doc_1 <-
  read_docx() %>%
  body_add_par("", style = "Normal") %>%
  body_add_table(table1, style = "table_template")

print(doc_1, target = "output/olineresource1.docx")
