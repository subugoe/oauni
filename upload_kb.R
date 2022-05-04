pubs_cat_details <- readr::read_csv("data/pubs_cat_details.csv", col_types = "ccccdccccccllllccccclccclclccccccccccccc")

######
## Add hybrid flag to updated data
upw_evidence <- readr::read_csv("data/upw_evidence.csv", col_types = "ccllllccccclccc")

hybrid_pubs <- upw_evidence %>%
  filter(oa_status == "hybrid", is_paratext == FALSE) %>%
  select(wos_doi) %>%
  distinct()

# readr::write_csv(hybrid_pubs, "data/hybrid_pubs.csv") ## for restarting R, saving memory
# rm(upw_evidence)
#
# hybrid_pubs <- readr::read_csv("data/hybrid_pubs.csv")

pubs_cat_hybrid <- pubs_cat_details %>%
  filter(oa_category == "other_oa_journal") %>%
  select(id, DOI, oa_category) %>%
  inner_join(hybrid_pubs, by = c("DOI" = "wos_doi")) %>%
  select(id, oa_category) %>%
  mutate(oa_category = "hybrid") %>%
  rename(oa_cat_hybrid = oa_category)

pubs_cat_details <- pubs_cat_details %>%
  left_join(pubs_cat_hybrid, by = "id") %>%
  mutate(oa_category = ifelse(is.na(oa_cat_hybrid), oa_category, oa_cat_hybrid))

export_to_kb <- pubs_cat_details %>%
  select(id, PK_ITEMS, UT_EID, DOI, PK_KB_SECTORS, PK_KB_INST, upw_doi, is_oa, journal_is_in_doaj, journal_is_oa, journal_issn_l, journal_issns, oa_status, evidence, host_type, is_best, repository_institution, url_for_landing_page, url_for_pdf, upw_matched, issn_gold, repo_type, oa_category) %>%
  rename(fk_items = PK_ITEMS, ut_eid = UT_EID, doi_wos = DOI, fk_kb_sectors = PK_KB_SECTORS, fk_kb_inst = PK_KB_INST, doi_upw = upw_doi)

readr::write_csv(export_to_kb, "data/export_tables/oa_german_inst_update.csv")
