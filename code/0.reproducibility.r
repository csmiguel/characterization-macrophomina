###.............................................................................
# (c) Miguel Camacho Sánchez
# miguelcamachosanchez@gmail.com // miguelcamachosanchez.weebly.com
# https://scholar.google.co.uk/citations?user=1M02-S4AAAAJ&hl=en
# March 2021
#GOAL: reproducibility info
#PROJECT: characterization-macrophomina
###.............................................................................
library(dplyr)
library(grateful)

#cite cite_packages
grateful::cite_packages(out.format = "md")
file.remove("pkg-refs.bib")

#load all packages used across scrips
grateful::scan_packages() %>%
  sapply(require, character.only = TRUE)

#print sessionInfo to file
sink("sessionInfo")
sessionInfo()
sink()
