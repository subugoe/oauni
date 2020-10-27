## code to prepare `oa_shares_inst_sector` dataset goes here

library(dplyr)
library(forcats)
library(tidyr)
library(readr)

## overall data
pubs_cat <- readr::read_csv("data-raw/pubs_cat.csv", col_types = "dccdcclc")
pubs_cat <- pubs_cat %>% 
  mutate(sec_abbr = case_when(
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

## Exclude institutions from university sector which are not listed in official statistics

excl_from_analysis <- readr::read_csv("data-raw/exclude_from_analysis.csv")
pubs_cat <- pubs_cat %>% 
  anti_join(excl_from_analysis, by = c("INST_NAME" = "Universitäten"))

## exclusion for inst_level analysis
exclude_from_inst_analysis <- readr::read_csv("data-raw/exclude_from_inst_level_analysis.csv")

oa_shares_inst <- pubs_cat %>%
  anti_join(exclude_from_inst_analysis, by = c("INST_NAME" = "NAME")) %>% 
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
  )) %>%
  group_by(INST_NAME) %>%
  mutate(n_total = n_distinct(PK_ITEMS)) %>%
  ungroup() %>%
  group_by(INST_NAME, oa_category, n_total) %>%
  summarise(n_cat = n_distinct(PK_ITEMS)) %>%
  pivot_wider(
    names_from = oa_category,
    values_from = n_cat,
    values_fill = list(n_cat = 0)
  ) %>%
  mutate(oa_share = is_oa / n_total) %>%
  rename(n_oa = is_oa, n_not_oa = not_oa) %>%
  ungroup()
oa_shares_inst_sector <- pubs_cat %>%
  anti_join(exclude_from_inst_analysis, by = c("INST_NAME" = "NAME")) %>% 
  mutate(oa_category = fct_collapse(
    oa_category,
    journal_oa = c("full_oa_journal", "other_oa_journal"),
    repo_oa = c(
      "opendoar_inst",
      "opendoar_subject",
      "opendoar_other",
      "other_repo"
    ),
    not_oa = "not_oa"
  )) %>%
  group_by(sector) %>%
  mutate(n_total_sec = n_distinct(PK_ITEMS)) %>%
  ungroup() %>%
  left_join(oa_shares_inst, by = 'INST_NAME') %>%
  group_by(sector, INST_NAME, n_total, oa_share, n_total_sec) %>%
  summarise() 

oa_shares_inst_sector_stats <- oa_shares_inst_sector %>% 
  ungroup() %>% 
  filter(n_total >= 100) %>% 
  group_by(sector) %>% 
  summarise(mean_oa_share = mean(oa_share), 
            median_oa_share = median(oa_share),
            mean_pub_volume = mean(n_total),
            median_pub_volume = median(n_total),
            sd_oa_share = sd(oa_share),
            sd_pub_volume = sd(n_total)
  )

oa_shares_inst_sector <- oa_shares_inst_sector %>%
  filter(n_total >= 100) %>%
  left_join(oa_shares_inst_sector_stats, by = "sector") %>%
  ungroup()

usethis::use_data(oa_shares_inst_sector, overwrite = TRUE)
