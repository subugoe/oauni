# Import summary statistics from supplement S2
library(dplyr)
library(readxl)

# all
s2_all <- readxl::read_xlsx("data-raw/S2.xlsx", sheet = 1, n_max = 6) %>%
  arrange(desc(`Total articles`))
usethis::use_data(s2_all, overwrite = TRUE)
# unis
s2_uni <- readxl::read_xlsx("data-raw/S2.xlsx", sheet = 2)
usethis::use_data(s2_uni, overwrite = TRUE)
# helmholtz
s2_helmholtz <- readxl::read_xlsx("data-raw/S2.xlsx", sheet = 3)
usethis::use_data(s2_helmholtz, overwrite = TRUE)
# mpg
s2_mpg <- readxl::read_xlsx("data-raw/S2.xlsx", sheet = 4)
usethis::use_data(s2_mpg, overwrite = TRUE)
# leibniz
s2_leibniz <- readxl::read_xlsx("data-raw/S2.xlsx", sheet = 5)
usethis::use_data(s2_leibniz, overwrite = TRUE)
# gra
s2_gra <- readxl::read_xlsx("data-raw/S2.xlsx", sheet = 6)
usethis::use_data(s2_gra, overwrite = TRUE)
# fraunhofer
s2_fraunhofer <- readxl::read_xlsx("data-raw/S2.xlsx", sheet = 7)
usethis::use_data(s2_fraunhofer, overwrite = TRUE)



make_color_pal <- function(colors, bias = 1) {
  get_color <- colorRamp(colors, bias = bias)
  function(x) rgb(get_color(x), maxColorValue = 255)
}

# palette color
pct_color <- make_color_pal(c("#ffffff", "#f2fbd2", "#c9ecb4", "#93d3ab", "#35b0ab"), bias = 1)

library(reactable)
reactable(s2,
  searchable = TRUE,
  columns = list(
    `Name of Institution` = colDef("Institution"),
    `Total articles` = colDef(
      "Total Articles",
      cell = function(value) {
        value = format(value, big.mark = ",")
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
               }})),
    columnGroups = list(
      colGroup(name = "OA Journal", columns = c("Proportion of OA in fully OA journals (full_oa_journal)", "Proportion of OA in non-fully OA journals (other_oa_journal)")),
      colGroup(name = "Repositories in OpenDOAR", 
               columns = c("Proportion of OA in repositories listed as 'institutional' in OpenDOAR (opendoar_inst)",
                           "Proportion of OA in repositories listed as 'disciplinary' in OpenDOAR (opendoar_subject)",
                           "Proportion of OA in other repositories listed in OpenDOAR (opendoar_other)"))))
      
