#' Categorise OpenDOAR Unapywall results
#'
#' Script works from the top-level of this project
library(tidyverse)
opendoar_update_df <-
  readr::read_csv("data/repo_matching_results.csv")
#' remove duplicate matches of same type for each full text location
opendoar_unique_repo <- opendoar_update_df %>%
  distinct(id, repo_type)
#' classification
opendoar_classes <- opendoar_unique_repo %>%
  mutate(
    green_cat = case_when(
      repo_type == "institutional" ~ "opendoar_inst",
      repo_type == "disciplinary" ~ "opendoar_subject"
    )
  ) %>%
  mutate(green_cat = ifelse(is.na(green_cat), "opendoar_other", green_cat))
#' Some repositores of different type share the same domain,
#' we will map them to opendoar_other
dups_cat_ids <- opendoar_unique_repo %>%
  group_by(id) %>%
  filter(n() > 1) %>%
  distinct(id)
opendoar_upw <- opendoar_classes %>%
  mutate(green_cat = ifelse(id %in% dups_cat_ids$id, "opendoar_other", green_cat)) %>% distinct(id, green_cat)
#' export
write_csv(opendoar_upw, "data/opendoar_upw_match.csv")
