###.............................................................................
# (c) Miguel Camacho Sánchez
# miguelcamachosanchez@gmail.com // miguelcamachosanchez.weebly.com
# https://scholar.google.co.uk/citations?user=1M02-S4AAAAJ&hl=en
# March 2021
#GOAL: Mann Whitney U test
#PROJECT: characterization-macrophomina
###.............................................................................
library(dplyr)

h <-
  readRDS("data/intermediate/tidy_data_virulence.rds")
d1 <- dplyr::filter(h, cultivar == "Candonga")
d2 <- dplyr::filter(h, cultivar == "Pajaro")

t1 <-
  wilcox.test(
    dplyr::filter(d1, strawberry == 0) %>%
      dplyr::pull(severity),
    dplyr::filter(d1, strawberry == 1) %>%
      dplyr::pull(severity),
    paired = F,
    alt = "two.sided",
    conf.int = T,
    conf.level = 0.95,
    exact = F,
    mu = 0
  )

t2 <-
  wilcox.test(
    dplyr::filter(d2, strawberry == 0) %>%
      dplyr::pull(severity),
    dplyr::filter(d2, strawberry == 1) %>%
      dplyr::pull(severity),
    paired = F,
    alt = "two.sided",
    conf.int = T,
    conf.level = 0.95,
    exact = F,
    mu = 0
  )

#differences in average
diff_d1 <-
  dplyr::filter(d1, strawberry == 1) %>%
  dplyr::pull(severity) %>% mean() -
  dplyr::filter(d1, strawberry == 0) %>%
  dplyr::pull(severity) %>% mean()

diff_d2 <-
  dplyr::filter(d2, strawberry == 1) %>%
dplyr::pull(severity) %>% mean() -
  dplyr::filter(d2, strawberry == 0) %>%
dplyr::pull(severity) %>% mean()
