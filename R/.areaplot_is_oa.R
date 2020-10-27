#' areaplot number of oa/not_oa articles
#'
#' @param data dataset
#' @param rel_numbers whether absolute or relative figures should be shown
#'
#' @import ggplot2
#' @importFrom forcats fct_rev
#' @importFrom scales number_format extended_breaks
#'
#' @export
areaplot_is_oa <- function(data = NULL, rel_numbers = FALSE) {

  if (rel_numbers){
    pp <- ggplot(data, aes(x = PUBYEAR,
                           y = prop,
                           text = paste(
                             "<b> Publication year:",
                             PUBYEAR,
                             "</b>\n Proportion in %:",
                             round(prop * 100, 2))
    )) +
      geom_area(aes(fill = fct_rev(oa_cat),
                    group = fct_rev(oa_cat)),  alpha = 0.8, colour = "white") +
      scale_fill_manual(
        values = c("Closed" = "#cccccca0", "Open Access" = "#56b4e9"),
        name = NULL
      ) +
      scale_y_continuous(
        labels = scales::percent_format(accuracy = 5L),
        expand = expansion(mult = c(0, 0.05)),
        limits = c(0, 1)
      )  +
      labs(x = "Publication year", y = "Proportion") +
      theme_minimal_hgrid()
  } else {
    pp <- ggplot(data, aes(x = PUBYEAR,
                           y = n_cat_year,
                           text = paste(
                              "<b> Publication year:",
                              PUBYEAR,
                              "</b>\n Number of articles:",
                              n_cat_year),
                           fill = fct_rev(oa_cat),
                           group = fct_rev(oa_cat)
                           )) +
      geom_area(alpha = 0.8, colour = "white") +
      scale_fill_manual(
        values = c("Closed" = "#cccccca0", "Open Access" = "#56b4e9"),
        name = NULL
      ) +
      scale_y_continuous(
        labels = scales::number_format(big.mark = ","),
        expand = expansion(mult = c(0, 0.05)),
        breaks =  scales::extended_breaks()(0:110000)
      ) +
      labs(x = "Publication year", y = "Total articles") +
      theme_minimal_hgrid()
  }
  return(pp)
}
