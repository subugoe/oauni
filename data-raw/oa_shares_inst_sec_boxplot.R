## code to prepare boxplot dataset goes here
library(dplyr)
library(readr)
library(forcats)

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

## exclusion for inst_level analysis
exclude_from_inst_analysis <-
  readr::read_csv("data-raw/exclude_from_inst_level_analysis.csv")

pubs_cat <- pubs_cat %>%
  anti_join(exclude_from_inst_analysis, by = c("INST_NAME" = "NAME"))

#institutions with less than 100 publications
inst_to_drop <- pubs_cat %>% 
  group_by(INST_NAME) %>% 
  summarise(n = n_distinct(PK_ITEMS)) %>% 
  filter(n < 100) %>% 
  pull(INST_NAME)

oa_inst_sec <- pubs_cat %>%
  filter(oa_category != "not_oa") %>%
  filter(!INST_NAME %in% inst_to_drop) %>%
  group_by(PUBYEAR, INST_NAME, sector, sec_abbr) %>%
  summarise(oa_articles = n_distinct(PK_ITEMS))
all_inst_sec <-  pubs_cat %>%
  filter(!INST_NAME %in% inst_to_drop) %>%
  group_by(PUBYEAR, INST_NAME, sector, sec_abbr) %>%
  summarise(articles = n_distinct(PK_ITEMS))
cat_inst_sec <- pubs_cat %>% 
  filter(!INST_NAME %in% inst_to_drop) %>%
  group_by(PUBYEAR, INST_NAME, sector, sec_abbr, oa_category) %>% 
  summarise(n_cat = n_distinct(PK_ITEMS)) %>%
  ungroup()
host_inst_sec <- pubs_cat %>% 
  filter(!INST_NAME %in% inst_to_drop) %>%
  mutate(oa_host = fct_collapse(
    oa_category,
    journal = c("full_oa_journal", "other_oa_journal"),
    repository = c(
      "opendoar_inst",
      "opendoar_subject",
      "opendoar_other",
      "other_repo"
    ),
    not_oa = c("not_oa")
  )) %>%
  group_by(PUBYEAR, INST_NAME, sector, sec_abbr, oa_host) %>% 
  mutate(n_host = n_distinct(PK_ITEMS)) %>%
  ungroup() %>% 
  group_by(PUBYEAR, INST_NAME, sector, sec_abbr, oa_category, oa_host, n_host) %>% 
  summarise() %>% 
  ungroup()
oa_shares_inst_sec_boxplot <- all_inst_sec %>% 
  full_join(pubs_cat %>% distinct(oa_category), by = character()) %>% 
  left_join(cat_inst_sec) %>%
  left_join(host_inst_sec) %>% 
  left_join(oa_inst_sec)  %>%
  ungroup() %>%
  mutate(oa_articles = ifelse(is.na(oa_articles), 0, oa_articles),
         n_cat = ifelse(is.na(n_cat), 0, n_cat),
         n_host = ifelse(is.na(n_host), 0, n_host)) %>% 
  mutate(prop = oa_articles / articles) %>%
  mutate(prop_cat = n_cat / articles) %>% 
  mutate(prop_host = n_host / articles) %>% 
  mutate(sector_cat = case_when(
    sec_abbr == "UNI" ~ "Universities",
    sec_abbr %in% c("MPS", "HGF") ~ "Research-oriented",
    sec_abbr == "WGL" ~ "Diverse missions",
    sec_abbr %in% c("FhS", "GRA") ~ "Practise-oriented"
  )
  ) %>%
  mutate(sector_cat = factor(
    sector_cat,
    levels = c(
      "Universities",
      "Research-oriented",
      "Diverse missions",
      "Practise-oriented"
    )
  )) %>% 
  mutate(sec_abbr = forcats::fct_rev(forcats::fct_reorder(sec_abbr, articles)))


usethis::use_data(oa_shares_inst_sec_boxplot, overwrite = TRUE)
