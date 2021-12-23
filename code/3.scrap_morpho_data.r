###.............................................................................
# (c) Miguel Camacho Sánchez
# miguelcamachosanchez@gmail.com // miguelcamachosanchez.weebly.com
# https://scholar.google.co.uk/citations?user=1M02-S4AAAAJ&hl=en
# June 2021
###.............................................................................
#GOAL: scrap morphological data from tables, tidy and write R object
#PROJECT: characterization-macrophomina
###..........................................................................

library(officer)
library(dplyr)

sample_data <- read_docx("manuscript/20210325/Table 3.docx")

content <- docx_summary(sample_data)
morph_data <-
  content %>%
  dplyr::filter(content_type == "table cell") %>%
  dplyr::select(row_id, text) %>%
  split(content$row_id) %>%
  lapply(function(x) c(x$text, unique(x$row_id))) %>%
  do.call(what=rbind) %>%
  as.data.frame() %>%
  {.[1:nrow(.)-1, 1:ncol(.)-1]} %>%
  setNames(c("isolate", "host", "shape", "color", "type", "chl_ph", "clh_sens", "microsclerotia")) %>%
  dplyr::mutate(microsclerotia =
                  stringr::str_extract(microsclerotia,
                                       pattern = "[[:digit:]]+.[[:digit:]]+") %>% as.numeric()) %>%
  dplyr::as_tibble()

#save data
saveRDS(morph_data, "data/intermediate/morphological_data.rds")
