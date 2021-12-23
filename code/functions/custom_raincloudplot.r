# custom raincloudplots function.
# Edited from raincloudplots::raincloudplots::raincloud_1x1
custom_raincloudplot <- function(dat = NULL, #data frame with data
                                 plot_var = NULL, #variable to plot
                                 size = 2,
                                 alpha = 0.5,
                                 col_violin = "grey80",
                                 col_box = "grey80",
                                 col_host = NULL,
                                 shape_host = NULL,
                                 ylab2 = NULL,
                                 y_lim = c(0, 5)) {
  strw0 <- dat %>% dplyr::filter(strawberry == 0)
  strw1 <- dat %>% dplyr::filter(strawberry == 1)
  ggplot(data = dat) +
  # plots kernel density
  raincloudplots:::geom_flat_violin(data = strw0,
                                    aes(x = 1, y = get(plot_var)),
                                    fill = col_violin, color = col_violin,
                                    position = position_nudge(x = 0.35),
                                    alpha = alpha, show.legend = FALSE) +
  raincloudplots:::geom_flat_violin(data = strw1,
                                    aes(x = 2, y = get(plot_var)),
                                    fill = col_violin, color = col_violin,
                                    position = position_nudge(x = 0.35),
                                    alpha = alpha, show.legend = FALSE) +
  gghalves::geom_half_boxplot(data = strw0,
                              aes(x = 1, y = get(plot_var)),
                              fill = col_box, color = col_box,
                              position = position_nudge(x = 0.22),
                              side = "r", outlier.shape = NA, center = TRUE,
                              errorbar.draw = FALSE, width = 0.2,
                              alpha = alpha, show.legend = FALSE) +
  #plots quantiles 0, 25, 50, 75, 100
  gghalves::geom_half_boxplot(data = strw1,
                              aes(x = 2, y = get(plot_var)),
                              fill = col_box, color = col_box,
                              position = position_nudge(x = 0.22),
                              side = "r", outlier.shape = NA, center = TRUE,
                              errorbar.draw = FALSE, width = 0.2, alpha = alpha,
                              show.legend = FALSE) +
  geom_point(data = strw0,
             aes(x = jitter(rep(1, nrow(strw0)), amount = 0.09),
                 y = get(plot_var)),
                 color = col_host,
             shape = shape_host,
             fill = col_violin,
             alpha = alpha,
             show.legend = T,
             position = position_nudge(x = 0.1),
             size = size) +
  geom_point(data = strw1,
             aes(x = jitter(rep(2, nrow(strw1)), amount = 0.09),
                 y = get(plot_var)),
                 color = col_host,
             shape = shape_host,
             fill = col_violin,
             alpha = alpha,
             show.legend = FALSE,
             position = position_nudge(x = 0.1),
             size = size) +
  scale_x_continuous(breaks = c(1.3, 2.3),
                     labels = c("non-strawberry", "strawberry"),
                     limits = c(0.9, 3)) +
  xlab("Host") +
  ylab(ylab2) +
  ylim(y_lim) +
  theme_classic()
  }
