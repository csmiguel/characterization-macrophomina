###.............................................................................
# (c) Miguel Camacho Sánchez
# miguelcamachosanchez@gmail.com // miguelcamachosanchez.weebly.com
# https://scholar.google.co.uk/citations?user=1M02-S4AAAAJ&hl=en
# March 2021
###.............................................................................
#GOAL: create R tidy seq object
#PROJECT: characterization-macrophomina
###.............................................................................
library(tidyverse)
library(rentrez)
library(reshape2)
#function to retrieve dna sequence from accession number in GenBank
getseq <- function(accession = NULL) {
  if(is.na(accession)) NA
  else if (!is.na(accession)) {
    h <- rentrez::entrez_search("nuccore",
                                term = accession)
    if(length(h$ids) != 1) "error"
    else if(length(h$ids) == 1) {
    h1 <- rentrez::entrez_fetch("nuccore",
                               id = h$ids,
                               rettype = "fasta")
    h1 %>% stringr::str_replace("^.*\n", "") %>% stringr::str_replace_all("\n", "")
    }
  }
}
#read data from Pouldel et al 2021
t1 <-
  read.csv("data/intermediate/t1-Poudel2021.csv") %>%
  as_tibble() %>%
  dplyr::select(species, isolate, act, cmd, its, ef, tub) %>%
  reshape2::melt(id = c("species", "isolate"),
                 variable.name = "locus",
                 value.name = "gb") %>%
  as_tibble() %>%
  dplyr::filter(!is.na(gb)) %>%
  rowwise %>%
  dplyr::mutate(dnaseq = getseq(accession = gb)) %>%
  dplyr::filter(dnaseq != "error") %>%
  dplyr::filter(locus != "act")

#read data from our study
d1 <-
  ape::read.nexus.data("genetic_matrices/phylogenetic_dna-matrix.nex") %>%
  sapply(function(x) paste(x, collapse = "")) %>% 
  {data.frame(sequence = ., row.names = names(.))} %>%
  tibble::rownames_to_column(var = "names") %>%
  rowwise() %>%
  mutate(species = stringr::str_split(names, "_")[[1]][1:2] %>% paste(collapse = " "),
         isolate = stringr::str_split(names, "_")[[1]][-c(1, 2)] %>% paste(collapse = "") %>% tolower(),
         sequence = toupper(sequence)) %>%
  dplyr::mutate(ef = stringr::str_sub(sequence, 1, 226),
                cmd = stringr::str_sub(sequence, 227, 723),
                its = stringr::str_sub(sequence, 724, 1264),
                tub =  stringr::str_sub(sequence, 1265, 2275)) %>%
  dplyr::select(-names, -sequence) %>%
  reshape2::melt(id = c("species", "isolate"),
                 variable.name = "locus",
                 value.name = "dnaseq") %>%
  dplyr::filter(!grepl("^cpc", isolate)) %>%
  as_tibble()
d1[d1$species == "Lasiodiplodia pseudotheobromae", 2] <- "outgroup1"
#read genbank numbers from our data
d2 <-
  read.csv("data/intermediate/gb_ourstudy.csv") %>%
  dplyr::mutate(isolate = tolower(gsub(" ", "", isolate)) %>%
                  gsub("tor-", "tor",.)) %>%
  dplyr::select(-X) %>%
  dplyr::filter(!grepl("^cpc", isolate)) %>%
  reshape2::melt(id = c("species", "isolate"),
                 variable.name = "locus",
                 value.name = "gb")
d2[d2$species == "L. pseudotheobromae", 2] <- "outgroup1"

# add genbank accession to tidy data of sequences
t2 <-
  left_join(d1, dplyr::select(d2, -species),
          by = c("isolate", "locus"))
#combine our data with data from Poudel et al 2021
tidy_seqs <-
  rbind(t1, t2) %>%
  rowwise %>%
  dplyr::mutate(locus = droplevels(locus),
                species = stringr::str_replace(species, "^Macrophomina", "M."))

# write data
saveRDS(tidy_seqs, "data/intermediate/tidy_seqs.rds")
