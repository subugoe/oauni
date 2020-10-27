#' opendoar analysis, script works from top-level of this project
library(tidyverse)
library(urltools)
opendoar <- readr::read_csv("data/opendoar_data.csv")
opendoar_df <- opendoar %>%
  mutate(repo_domain = domain(repo_url)) %>%
  mutate(repo_domain = gsub("www.", "", repo_domain))
#' one domain used by various repositories
opendoar_df %>%
  group_by(repo_domain) %>%
  filter(n() > 1) 
opendoar_out <- opendoar_df %>%
  # deal with multi-language repository names
  select(-repo_name) %>% 
  distinct() %>% 
  mutate(repo_domain = domain(repo_url)) %>%
  mutate(repo_domain = gsub("www.", "", repo_domain)) %>%
  mutate(oai_domain = domain(oai_url)) %>%
  mutate(oai_domain = gsub("www.", "", oai_domain)) 
  
write_csv(opendoar_out, "data/opendoar_data_tidier.csv")
