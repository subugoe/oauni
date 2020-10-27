#' validate DOIs, do they resolve and if so, which agency maintains these DOIs
library(tidyverse)
library(rcrossref)
#' lood DOIs that were not in Unpaywall, but indexed in the Web of Science
kb_dois <- readr::read_csv("data/unmatched_wos_dois.csv") %>%
  select(doi = DOI)
doi_agencies <- purrr::map(kb_dois$doi, purrr::safely(rcrossref::cr_agency))
doi_agencies_list <- purrr::map(doi_agencies, "result") %>%
  purrr::compact()
# tibble with dois where the resource was found
cr_agency_df <- tibble(doi = cr_agency_df$doi, 
                       doi_agency_id = cr_agency_df$agency$id, 
                       doi_agency_label = cr_agency_df$agency$label)
result_df <- left_join(kb_dois, cr_agency_df, by = "doi")
#' export
write_csv(result_df, "data/unmatched_dois_agency.csv")
