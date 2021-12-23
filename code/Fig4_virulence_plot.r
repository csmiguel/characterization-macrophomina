library(tidyverse)
library(cowplot)
library(ggplot2)
library(ggpubr)
library(rstatix)

source("code/functions/R_rainclouds.R")

data <- 
    readRDS("data/intermediate/tidy_data_virulence.rds") %>%
  dplyr::select(isolate, cultivar, strawberry, severity)
levels(data$cultivar) <- c("assay 1", "assay 2")
levels(data$strawberry) <- c("non-strawberry", "strawberry")

p9 <- 
  ggplot(data,
         aes(x = strawberry, y = severity,
             fill = strawberry, colour = strawberry)) + 
  geom_flat_violin(position = position_nudge(x = .25, y = 0),
                   adjust = 2, trim = TRUE) +
  geom_point(position = position_jitter(width = .15, h = 0),
             size = 2, alpha = 0.3, colour = "black") +
  geom_boxplot(aes(x = as.numeric(strawberry) + 0.25, y = severity, fill = strawberry),
               outlier.shape = NA,
               width = .1, colour = "black") + 
  ylab("Severity (DSR)") +
  xlab("Host") +
  theme_cowplot() + 
  guides(fill = "none", colour = "none") +
  facet_wrap(~cultivar)+ 
  scale_colour_manual(values = c("grey50", "grey80"),
                      aesthetics = c("colour", "fill"))

ggsave(filename = "output/wilcoxon.pdf", plot = p9, width = 6, height = 3.5)
