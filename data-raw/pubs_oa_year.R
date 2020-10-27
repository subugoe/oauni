# code to prepare OA shares (national level)

library(dplyr)
library(forcats)
library(readr)

pubs_cat <-
  readr::read_csv("data-raw/pubs_cat.csv", col_types = "dccdcclc")
pubs_cat <- pubs_cat %>%
  mutate(
    sec_abbr = case_when(
      sector == "Hochschulen" ~ "UNI",
      sector == "Helmholtz-Gemeinschaft" ~ "HGF",
      sector == "Max-Planck-Gesellschaft" ~ "MPS",
      sector == "Leibniz-Gemeinschaft" ~ "WGL",
      sector == "Fraunhofer-Gesellschaft" ~ "FhS",
      sector == "Ressortforschung" ~ "GRA"
    ),
    sector = case_when(
      sector == "Hochschulen" ~ "Universities",
      sector == "Helmholtz-Gemeinschaft" ~ "Helmholtz Association",
      sector == "Max-Planck-Gesellschaft" ~ "Max Planck Society",
      sector == "Leibniz-Gemeinschaft" ~ "Leibniz Association",
      sector == "Fraunhofer-Gesellschaft" ~ "Fraunhofer Society",
      sector == "Ressortforschung" ~ "Government Research\n Agencies"
    ),
    oa_category = factor(
      oa_category,
      levels = c(
        "full_oa_journal",
        "other_oa_journal",
        "opendoar_inst",
        "opendoar_subject",
        "opendoar_other",
        "other_repo",
        "not_oa"
      )
    )
  )

# Exlcude institutions from university sector which are not listed in official statistics

excl_from_analysis <-
  readr::read_csv("data-raw/exclude_from_analysis.csv")
pubs_cat <- pubs_cat %>%
  anti_join(excl_from_analysis, by = c("INST_NAME" = "Universitäten"))

# generate dataset
pubs_oa_year <- pubs_cat %>%
  mutate(oa_category = fct_collapse(
    oa_category,
    is_oa = c(
      "full_oa_journal",
      "other_oa_journal",
      "opendoar_inst",
      "opendoar_subject",
      "opendoar_other",
      "other_repo"
    ),
    not_oa = "not_oa"
  ))  %>%
  #mutate(PUBYEAR = lubridate::ymd(paste0(PUBYEAR, "-01-01"))) %>% 
  group_by(PUBYEAR) %>% 
  mutate(n_total_year = n_distinct(PK_ITEMS)) %>% 
  ungroup() %>% 
  group_by(PUBYEAR, oa_category, n_total_year) %>%
  summarise(n_cat_year = n_distinct(PK_ITEMS)) %>%
  mutate(prop = n_cat_year / n_total_year) %>% 
  mutate(oa_cat = fct_rev(ifelse(oa_category %in% "is_oa", "Open Access", "Closed"))) %>%
  ungroup()
# factor
pubs_oa_year_r <- pubs_oa_year %>%
  mutate(oa_cat = factor(ifelse(oa_category %in% "is_oa", "Open Access", "Closed"), levels = c("Closed", "Open Access")))

usethis::use_data(pubs_oa_year, overwrite = TRUE)