#' Improve Open DOAR matching using Unpaywall repository names
#'
#' Script works from the top-level of this project
#'
library(tidyverse)
library(urltools)
#' load evidence file
my_df <- readr::read_csv("data/pubs_cat_details.csv") %>%
  # create ids for each full-text observation
  group_by(PK_ITEMS) %>%
  mutate(id = paste0(PK_ITEMS, "_", row_number())) %>%
  ungroup() %>%
  rename(doar_uri_old = doar_uri, repo_type_old = repo_type)
#' Subset the data frame:
#'   - only match repo full-texts
#' data manipulation
#'   - extract dfull-text domains with urltools
repo_domains <- my_df %>%
  filter(host_type == "repository") %>%
  mutate(landing_domain = urltools::domain(url_for_landing_page)) %>%
  mutate(landing_domain = gsub("www.", "", landing_domain)) %>%
  mutate(pdf_domain = urltools::domain(url_for_pdf)) %>%
  mutate(pdf_domain = gsub("www.", "", pdf_domain))
#' Prepare Matching
#'
#' Domain matching table Unpaywall full-text links
repo_matching <- repo_domains %>%
  select(id, repository_institution, landing_domain, pdf_domain) %>%
  gather(landing_domain, pdf_domain, key = "domain_type", value = "domain")  %>%
  filter(!is.na(domain))
#' Load Open DOAR data fetched using `opendoar.R` and transformed using
#' `opendoar_anaylsis.R`
open_doar <- readr::read_csv("data/opendoar_data_tidier.csv")
#' Domain matching table OpenDOAR repository links
open_doar_matching <- open_doar %>%
  select(repo_type, repo_domain, oai_domain, doar_uri) %>%
  gather(repo_domain, oai_domain, key = "domain_type", value = "domain") %>%
  filter(!is.na(domain)) %>%
  mutate(domain = gsub("www.", "", domain))
#' The matching itself consists of two steps: First, I want to bring together OpenDOAR with Unpaywall using common domains.
domain_matching <-
  inner_join(repo_matching, open_doar_matching, by = "domain") %>%
  distinct(id, repository_institution, domain, repo_type, doar_uri)
#' Next, we use the result of this match and re-do a join by the repository name contained in Unpaywall metadata
repo_doar_inst <- domain_matching %>%
  distinct(domain, repository_institution, repo_type, doar_uri) %>%
  filter(!is.na(repository_institution)) %>%
  inner_join(repo_domains, by = "repository_institution")
#' let's put both files together
pk_domain <- inner_join(my_df, domain_matching, by = "id") %>%
  select(id, repo_type, doar_uri) %>%
  distinct()
pk_upw_name <- repo_doar_inst %>%
  filter(!id %in% pk_domain$id) %>%
  distinct(id, repo_type, doar_uri) %>%
  inner_join(my_df, by = "id") %>%
  select(id, repo_type, doar_uri) %>%
  distinct()
repo_matching <- bind_rows(pk_domain, pk_upw_name)
#' export
write_csv(repo_matching, "data/repo_matching_results.csv")
