#' Interactive tables for S2 summary data
#'
#' @param data the data
#' @importFrom reactable reactable colDef colGroup colFormat
#' @export
s2_react_table <- function(data, all = FALSE) {
 my_cols <- list(
    `Name of Institution` = colDef("Institution", minWidth = 150),
    `Total articles` = colDef(
      "Total Articles",
      cell = function(value) {
        value <- format(value, big.mark = ",")
      }
    ),
    `OA proportion` = colDef("OA(%)", format = colFormat(percent = TRUE,
                                                         digit = 0),
                             style = function(value) {
                               # Lighter color for <1%
                               if (value < 0.01) {
                                 list(color = "#aaa")
                               } else {
                                 list(color = "#111", background = pct_color(value))
                               }}),
    `Proportion of Journal OA` = colDef("OA Journal", format = colFormat(percent = TRUE,
                                                                      digit = 0),
                                        style = function(value) {
                                          # Lighter color for <1%
                                          if (value < 0.01) {
                                            list(color = "#aaa")
                                          } else {
                                            list(color = "#111", background = pct_color(value))
                                          }}
    ),
    `Proportion of Repository OA` = colDef("OA Repository", format = colFormat(percent = TRUE,
                                                                          digit = 0),
                                           style = function(value) {
                                             # Lighter color for <1%
                                             if (value < 0.01) {
                                               list(color = "#aaa")
                                             } else {
                                               list(color = "#111", background = pct_color(value))
                                             }}),
    `Proportion of OA in fully OA journals (full_oa_journal)` = colDef("Full", format = colFormat(percent = TRUE, digit = 0),
                                                                       style = function(value) {
                                                                         # Lighter color for <1%
                                                                         if (value < 0.01) {
                                                                           list(color = "#aaa")
                                                                         } else {
                                                                           list(color = "#111", background = pct_color(value))
                                                                         }}),
    `Proportion of OA in non-fully OA journals (other_oa_journal)` = colDef("Other", format = colFormat(percent = TRUE, digit = 0),
                                                                            style = function(value) {
                                                                              # Lighter color for <1%
                                                                              if (value < 0.01) {
                                                                                list(color = "#aaa")
                                                                              } else {
                                                                                list(color = "#111", background = pct_color(value))
                                                                              }}),
    `Proportion of OA in repositories listed as 'institutional' in OpenDOAR (opendoar_inst)` = colDef("Institutional", format = colFormat(percent = TRUE, digit = 0),
                                                                                                      style = function(value) {
                                                                                                        # Lighter color for <1%
                                                                                                        if (value < 0.01) {
                                                                                                          list(color = "#aaa")
                                                                                                        } else {
                                                                                                          list(color = "#111", background = pct_color(value))
                                                                                                        }}),
    `Proportion of OA in repositories listed as 'disciplinary' in OpenDOAR (opendoar_subject)` = colDef("Disciplinary", format = colFormat(percent = TRUE, digit = 0),
                                                                                                        style = function(value) {
                                                                                                          # Lighter color for <1%
                                                                                                          if (value < 0.01) {
                                                                                                            list(color = "#aaa")
                                                                                                          } else {
                                                                                                            list(color = "#111", background = pct_color(value))
                                                                                                          }}),
    `Proportion of OA in other repositories listed in OpenDOAR (opendoar_other)` =
      colDef("Other", format = colFormat(percent = TRUE, digit = 0),
             style = function(value) {
               # Lighter color for <1%
               if (value < 0.01) {
                 list(color = "#aaa")
               } else {
                 list(color = "#111", background = pct_color(value))
               }}),
    `Proportion of OA in repositories not listed in OpenDOAR (other_repo)` = 
      colDef("Other Repo", format = colFormat(percent = TRUE, digit = 0),
             style = function(value) {
               # Lighter color for <1%
               if (value < 0.01) {
                 list(color = "#aaa")
               } else {
                 list(color = "#111", background = pct_color(value))
               }}))
 # exception for the sector overview
 if(isTRUE(all)) {
   my_cols[1] <- NULL
   my_cols <- append(list(`Sector` = colDef("Sector")), my_cols)
 }
  
  reactable::reactable(data,
            searchable = TRUE,
            columns = my_cols,
            columnGroups = list(
              colGroup(name = "OA Journal", columns = c("Proportion of OA in fully OA journals (full_oa_journal)", "Proportion of OA in non-fully OA journals (other_oa_journal)")),
              colGroup(name = "Repositories in OpenDOAR", 
                       columns = c("Proportion of OA in repositories listed as 'institutional' in OpenDOAR (opendoar_inst)",
                                   "Proportion of OA in repositories listed as 'disciplinary' in OpenDOAR (opendoar_subject)",
                                   "Proportion of OA in other repositories listed in OpenDOAR (opendoar_other)"))),
            style = list(fontSize = "12px"),
            defaultPageSize = 6)
  
}

#' Create color pal
#'
#' @param colors the colors
#' @param bias the bias
#'
#' @importFrom grDevices colorRamp rgb
#' @export
#'
make_color_pal <- function(colors, bias = 1) {
  get_color <- colorRamp(colors, bias = bias)
  function(x) rgb(get_color(x), maxColorValue = 255)
}

#' palette color
pct_color <- make_color_pal(c("#ffffff", "#f2fbd2", "#c9ecb4", "#93d3ab", "#35b0ab"), bias = 1)
