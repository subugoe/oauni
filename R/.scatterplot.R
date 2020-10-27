#' Create OA / Overall Scatterplot
#'
#' @param x dataset
#' @param insts institutions that you want to highlight
#'
#' @import ggplot2
#' @importFrom forcats fct_rev fct_reorder
#' @importFrom scales percent_format number_format
#' @importFrom cowplot theme_minimal_grid
#' @export
#'
scatterplot_oa <- function(x, insts = NULL) {
  ggplot(x, aes(x = n_total, y = oa_share)) +
    geom_smooth(formula = y ~ x, color = "#999999a0", method = "lm") +
    geom_point(color = "grey80", alpha = .7, size = 2, aes(text = paste("<b>", INST_NAME, "</b>\n OA percentage:", round(oa_share * 100, 2), "%\n Publications:", n_total)))  +
    geom_point(data = insts, color = "#56b4e9", size = 3) +
   # geom_smooth(formula = y ~ x, color = "#999999a0", method = "lm") +
    scale_x_log10(labels = scales::number_format(big.mark = ","),
                  expand = expansion(mult = c(0.05, 0.1))) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 5L),
                       expand = expansion(mult = c(0, 0.05)),
                       limits = c(0,1)) +
     geom_hline(aes(yintercept = median(oa_share)),
                colour = "#d55e00", linetype ="dashed", size = 1) +
     geom_vline(aes(xintercept = median(n_total)),
                colour = "#E69F00", linetype ="dashed", size = 1) +
    labs(x = "Total articles (logarithmic scale)", y = "OA percentage") +
    theme_minimal_grid() +
    theme(legend.position = "none") +
    # bold facet labels
    theme(strip.text = element_text(face = "bold"))+
    theme(axis.text=element_text(size=10))
}
