
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
