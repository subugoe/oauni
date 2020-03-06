# opendoar analysis
library(tidyverse)
library(urltools)
opendoar <- readr::read_csv("data/opendoar_data.csv")
opendoar_df <- opendoar %>%
  mutate(repo_domain = domain(repo_url)) %>%
  mutate(repo_domain = gsub("www.", "", repo_domain))
opendoar_df %>%
  group_by(repo_domain) %>%
  filter(n() > 1) %>%
  View()
opendoar_df %>%
  group_by(doar_uri, repo_type) %>%
  filter(n() > 1) %>%
  View()
opendoar_df %>%
  select(-repo_name) %>% 
  distinct() %>% 
  mutate(repo_domain = domain(repo_url)) %>%
  mutate(repo_domain = gsub("www.", "", repo_domain)) %>%
  write_csv("data/opendoar_data_tidier.csv")
