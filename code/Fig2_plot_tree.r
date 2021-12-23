###.............................................................................
# (c) Miguel Camacho Sánchez
# miguelcamachosanchez@gmail.com // miguelcamachosanchez.weebly.com
# March 2021
###.............................................................................
#GOAL: plot maximum likelihood and Bayesian trees
#PROJECT: characterization-macrophomina
###.............................................................................
library(ggtree)
library(dplyr)
library(treeio)
library(cowplot)

# read maximum credibility BEAST tree
tr_beast <-
  treeio::read.beast("data/intermediate/beast/mcct.tree")
# plot Bayesian tree
p_beast <-
  (ggtree::ggtree(tr_beast, size = 0.2) +
     geom_text2(aes(label=round(posterior, 2), subset = posterior > .9), hjust = 1.1, vjust = 1.1, size = 1) +
     geom_tiplab(aes(label = gsub(pattern = "M.[a-z]+_", replacement = "", x = label)), size = 1) +
     xlim(0, .025)) %>%
  rotate(71) # rotate in node x

# read RAxML tree
tr_raxml <-
  treeio::read.newick("data/intermediate/raxml/RAxML_bipartitions.mp_nonDup.tree",
                      node.label = "support") %>%
  treeio::root(node = 78) %>% # reroot with outgroup
  treeio::drop.tip("Lasiodiplodia_pseudotheobromae") # drop outgroup to easen depiction

# plot maximum likelihood tree
p_raxml <-
  (ggtree::ggtree(tr_raxml, size = 0.2) +
  geom_text2(aes(label=round(support, 2), subset = support > 65), hjust = 1.1, vjust = 1.1, size = 1) +
  geom_tiplab(aes(label = gsub(pattern = "M.[a-z]+_", replacement = "", x = label)), size = 1) +
  xlim(c(0, .025)) +
  geom_treescale(fontsize = 1.2, linesize = .2)) %>%
  rotate(71)

# combine both trees in unique plot
combined_plot <- cowplot::plot_grid(p_raxml, p_beast, labels = c('A', 'B'), label_size = 7)
ggsave(filename = "output/combined_plot.pdf",
       plot = combined_plot,
       device = "pdf",
       height = 10, width = 8, units = "cm")
