###.............................................................................
# (c) Miguel Camacho Sánchez
# miguelcamachosanchez@gmail.com // miguelcamachosanchez.weebly.com
# https://scholar.google.co.uk/citations?user=1M02-S4AAAAJ&hl=en
# March 2021
###.............................................................................
#GOAL: scrap GenBank data from Poudel et al 2021
#PROJECT: characterization-macrophomina
###.............................................................................
library(tabulizer)
library(tidyverse)
library(magrittr)

#scratch table
h <- tabulizer::extract_tables("etc/Poudel_2021_Macrophomina.pdf")
#The table spans multiple pages. It works quite well for pages 2:4, but not for p1. I will scratch data from p1 manually in a text editor and append it later to p2:4
#names of table
namestable <- c("species", "isolate", "host", "locality",
                "year", "collector", "act", "cmd",
                "its", "ef", "tub")
h <- h[2:4]
h1[[1]] <- cbind(rep("M. phaseolina", nrow(h1[[1]])), h1[[1]])
hdf <- do.call(rbind, h1) %>%
  as.data.frame() %>%
  setNames(namestable)

#paste p1 edited in a text editor
t1 <- tibble::tribble(
                 ~V1,                      ~V2,                       ~V3,                   ~V4,   ~V5,                                      ~V6,        ~V7,        ~V8,        ~V9,       ~V10,       ~V11,
  "M. euphorbiicola",  "CMM4045;CCMF-CNPA 278",   "Jatropha gossypifolia",              "Brazil", 2010L,                              "DJ Soares", "MF457654", "MF457660", "KU058928", "KU058898", "MF457657",
                  NA, "CMM4134;CCMF-CNPA 288T",        "Ricinus communis",              "Brazil", 2010L,                              "DJ Soares", "MF457655", "MF457661", "KU058936", "KU058906", "MF457658",
                  NA,  "CMM4145;CCMF-CNPA 289",        "Ricinus communis",              "Brazil", 2010L,                              "DJ Soares", "MF457656", "MF457662", "KU058937", "KU058907", "MF457659",
     "M. phaseolina",             "BRIP 15497",           "Cajanus cajan",          "Lawes, Qld", 1986L,                             "AH Wearing", "MW592038", "MW592118", "MW591610", "MW592199", "MW592279",
                  NA,             "BRIP 22784",  "Melaleuca alternifolia",       "Dimbulah, Qld", 1995L,                             "JE Drinnan", "MW592039", "MW592119", "MW591611", "MW592200", "MW592280",
                  NA,             "BRIP 25702",  "Chamelaucium uncinatum",         "Gatton, Qld",    NA,                                "PR Beal", "MW592040", "MW592120", "MW591612", "MW592201", "MW592281",
                  NA,             "BRIP 25715",         "Capsicum annuum",          "Gumlu, Qld", 1999L,                              "HL Martin", "MW592041", "MW592121", "MW591613", "MW592202", "MW592282",
                  NA,             "BRIP 39354",         "Cannabis sativa",        "Mondure, Qld", 2003L,                            "MJ Fuhlbohm", "MW592044", "MW592124", "MW591616", "MW592205", "MW592285",
                  NA,             "BRIP 39282",   "Sisymbrium thellungii",       "Kingaroy, Qld",    NA,                            "MJ Fuhlbohm", "MW592042", "MW592122", "MW591614", "MW592203", "MW592283",
                  NA,             "BRIP 39285",       "Citrullus lanatus",       "Walkamin, Qld", 2003L,                           "PR Trevorrow", "MW592043", "MW592123", "MW591615", "MW592204", "MW592284",
                  NA,             "BRIP 52124",           "Gossypium sp.",        "Emerald, Qld", 2008L,                                "S Allen", "MW592045", "MW592125", "MW591617", "MW592206", "MW592286",
                  NA,             "BRIP 52343",        "Persea americana",       "Pemberton, WA", 2008L,                                "JR Dean", "MW592046", "MW592126", "MW591618", "MW592207", "MW592287",
                  NA,              "BRIP 5297",             "Allium cepa",         "Kalbar, Qld", 1969L,                              "IK Hughes", "MW592037", "MW592117", "MW591609", "MW592198", "MW592278",
                  NA,             "BRIP 55168",           "Vigna radiata",         "Bioela, Qld", 1996L,                            "MJ Fuhlbohm", "MW592048", "MW592128", "MW591620", "MW592209", "MW592289",
                  NA,             "BRIP 61469",            "Cucumis melo",          "Clare, Qld", 2014L, "S Subramaniam, PR Trevorrow, KRE Grice", "MW592049", "MW592129", "MW591621", "MW592210", "MW592290",
                  NA,             "BRIP 64556",         "Sorghum bicolor",              "Qld SM",    NA,                               "Thompson", "MW592050", "MW592130",        "-", "MW592211", "MW592291",
                  NA,             "BRIP 64557",              "S. Bicolor",              "Qld SM",    NA,                               "Thompson", "MW592051", "MW592131", "MW591622", "MW592212", "MW592292",
                  NA,             "BRIP 64764",      "Cucurbita moschata",          "Bowen, Qld", 2016L,                               "D Abbott", "MW592052", "MW592132", "MW591623", "MW592213", "MW592293",
                  NA,             "BRIP 68352",     "Fragaria × ananassa",        "Wamuran, Qld", 2007L,                            "SM Thompson", "MW592053", "MW592133", "MW591624", "MW592214", "MW592294",
                  NA,             "BRIP 69721",       "Crotalaria juncea", "Lakeland Downs, Qld", 2019L,         "M Arnold, A Myrteza, KRE Grice", "MW592054", "MW592134", "MW591625", "MW592215", "MW592295",
                  NA,             "BRIP 70703", "Cyamopsis tetragonoloba",       "Dimbulah, Qld", 2018L,                             "T Matchett", "MW592107", "MW592135", "MW591683", "MW592216", "MW592296",
                  NA,             "BRIP 70724",              "V. radiata",     "Brookstead, Qld", 2019L,                             "DL Adorada", "MW592056", "MW592189", "MW591682", "MW592266", "MW592353",
                  NA,             "BRIP 70726",             "Glycine max",                 "Qld", 2019L,                             "DL Adorada", "MW592057", "MW592137", "MW591628", "MW592217", "MW592299",
                  NA,             "BRIP 70730",      "Helianuthus annuus",       "Jondaryn, Qld", 2019L,                             "DL Adorada", "MW592109", "MW592191", "MW591630", "MW592268", "MW592355",
                  NA,             "BRIP 70780",              "S. bicolor",       "Inverell, NSW", 2019L,                  "DL Adorada, N Vaghefi", "MW592111", "MW592188", "MW591681", "MW592265", "MW592352",
                  NA,             "BRIP 71602",              "S. bicolor",       "Inverell, NSW", 2019L,                  "DL Adorada, N Vaghefi", "MW592115", "MW592196", "MW591686", "MW592276", "MW592358",
                  NA,             "BRIP 71606",        "Arachis hypogaea",      "Bundaberg, Qld", 2018L,                                "L Kelly", "MW592112", "MW592142", "MW591634", "MW592273", "MW592304"
  ) %>% setNames(namestable)

#create final table
t2 <-
  rbind(t1, hdf) %>% 
  {
    .[apply(., 1, function(x) {
  (x == "") %>% sum(na.rm = T) < 8 #remove rows with missing data
}), ]} %>%
  apply(2, function(x) gsub("^$|–", NA, x)) %>% #replace empty cells by NA
  as.data.frame() %>%
  tidyr::fill(species) #autocomplete species name with top names.

#write to csv
write.csv(t2, "data/intermediate/t1-Poudel2021.csv")
