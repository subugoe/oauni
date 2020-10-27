#' Box plot
#'
#' @param oa_shares_inst_sec_boxplot dataset
#' @param insts institutions that you want to highlight
#'
#' @import ggplot2
#' @importFrom forcats fct_rev fct_reorder
#' @importFrom scales percent_format number_format
#' @importFrom cowplot theme_minimal_hgrid
#'
#' @export
boxplot_oa <- function(data = NULL, insts = NULL) {
  pp <- ggplot(data,
               aes(
                 x = sec_abbr,
                 y = prop,
                 color = sector_cat,
                 text = paste(
                   "<b>",
                   INST_NAME,
                   "</b>\n OA percentage:",
                   round(prop * 100, 2),
                   "%\n Publications:",
                   articles)
               )) +
    geom_boxplot() +
    scale_color_manual(values = c("#684747", "#f68f46ff", "#a65c85ff", "#051461")) +
    labs(x = "",
         y = "OA percentage",
         color = "")
  if (is.null(insts)) {
    pp <- pp +
      geom_point(
        alpha = 0.1,
        pch = 21,
        position = position_jitterdodge(dodge.width = 0.2)
        )
  } else {
    pp <- pp + geom_point(
      data = insts,
      size = 3,
      alpha = 0.5,
      position = position_jitterdodge(dodge.width = 0.2)
      )
  }
  pp +
    scale_y_continuous(
      labels = scales::percent_format(accuracy = 5L),
      expand = expansion(mult = c(0, 0.05)),
      limits = c(0, 1)
    )  +
    theme_minimal_hgrid()
}
