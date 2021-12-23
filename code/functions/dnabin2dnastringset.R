# Convert ape::DNAbin format to Biostrings::DNAStringSet format,
# optionally removing gaps
DNAbin_to_DNAstringset <- function (seqs, remove_gaps = F) {
  if(isTRUE(remove_gaps)) {
    seqs %>% as.list() %>% as.character %>% 
      lapply(.,paste0,collapse="") %>% 
      lapply( function (x) gsub("-", "", x)) %>% 
      unlist %>% Biostrings::DNAStringSet()
  } else {
    seqs %>% as.list() %>% as.character %>% 
      lapply(.,paste0,collapse="") %>% 
      unlist %>% Biostrings::DNAStringSet()
  }
}