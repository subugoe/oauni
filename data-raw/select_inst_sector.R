## select input for box plot
library(dplyr)
library(forcats)

unique_inst <- oa_shares_inst_sec_boxplot %>%
  mutate(sector = forcats::fct_rev(forcats::fct_reorder(sector, articles))) %>%
  dplyr::ungroup() %>%
  dplyr::distinct(INST_NAME, sector)

select_inst_sector <- split(unique_inst$INST_NAME, unique_inst$sector)

usethis::use_data(select_inst_sector, overwrite = TRUE)

