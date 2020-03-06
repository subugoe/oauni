#OpenDoar Client
library(httr)
library(tidyverse)
opendoar_api <- function(query) {
  url <- modify_url("https://v2.sherpa.ac.uk/cgi/retrieve", query = query)
  
  resp <- GET(url)
  if (http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  
  jsonlite::fromJSON(content(resp, "text"), simplifyVector = FALSE)
}

opendoar_parse <- function(resp) {
  rep_md <- map(resp$items, "repository_metadata") 
  my_df <- rep_md %>%
    tibble(
      repo_url = map_chr(., "url", .null = NA_integer_),
      oai_url = map_chr(., "oai_url", .null = NA_integer_),
      repo_type = map_chr(., "type", .null = NA_integer_),
      repo_name = map(., "name") %>% 
        map(bind_rows) %>%
        map("name"),
      org_url = map(resp$items, "organisation") %>% 
        map_chr("url", .null = NA_integer_),
      doar_uri = map(resp$items, "system_metadata") 
      %>% map_chr("uri", .null = NA_integer_)
    ) 
  my_df %>%
    select(-.)
}


tmp <- purrr::map_df(seq(0, 5500, by = 100), function(offset) {
  offset <- offset
  resp <- opendoar_api(query = list(
    `item-type` = "repository", 
    format = "Json", 
    `api-key` = "1CFF9930-1118-11EA-94B9-86F42A6A9D3C",
    offset = offset)
    ) 
   if(length(resp$items) == 0)
     NULL
   opendoar_parse(resp)
}
)
tmp %>%
  unnest(cols = repo_name) %>%
  write_csv("data/opendoar_data.csv")
