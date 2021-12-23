###.............................................................................
# (c) Miguel Camacho Sánchez
# miguelcamachosanchez@gmail.com // miguelcamachosanchez.weebly.com
# https://scholar.google.co.uk/citations?user=1M02-S4AAAAJ&hl=en
# March 2021
###.............................................................................
#GOAL: DNA alignments
#PROJECT: characterization-macrophomina
###.............................................................................
library(tidyverse)
library(bioseq)
library(phangorn)
library(ips)

#load dnabin 2 dnastringset conversion
source("code/functions/dnabin2dnastringset.R")

d <- readRDS("data/intermediate/tidy_seqs.rds")

dna_alignments <-
  levels(d$locus) %>%
  lapply(function(x) {
    d1 <- dplyr::filter(d, locus == x)
    aligned_seqs1 <-
      d1$dnaseq %>%
      stringr::str_replace_all("\\?", "N") %>%
      Biostrings::DNAStringSet() %>%
      DECIPHER::AlignSeqs() %>%
       ape::as.DNAbin() %>%
      as.matrix() %>%
      ips::trimEnds(.7)
    dimnames(aligned_seqs1) <-
      list(
        paste(d1$species, d1$isolate, sep = "_") %>%
          gsub(" ", "", .) %>%
          gsub(";", "-", .),
        NULL)
    aligned_seqs2 <-
      aligned_seqs1 %>%
      ips::gblocks(exec = "/Applications/Gblocks") %>%
      DNAbin_to_DNAstringset()

    aligned_seqs2 %>%
      Biostrings::DNAMultipleAlignment() %>%
      phangorn::as.phyDat() %>%
      phangorn::write.phyDat(file = paste0(
          file.path("data/intermediate", x), "_ind.phy"),
                             format = "phylip")
    aligned_seqs2
    }) %>%
  setNames(levels(d$locus))
