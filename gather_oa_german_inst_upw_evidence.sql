  SELECT
      w.doi as wos_doi,
      u.doi as upw_doi, u.is_paratext, u.is_oa, u.journal_is_in_doaj, u.journal_is_oa, u.journal_issn_l, u.journal_issns, u.oa_status,
      u2.evidence, u2.host_type, u2.is_best, u2.repository_institution, u2.url_for_landing_page, u2.url_for_pdf
  FROM
      oadoi_full.oa_german_inst_dois w
  LEFT JOIN (
      SELECT doi, is_paratext, is_oa, journal_is_in_doaj, journal_is_oa, journal_issn_l, journal_issns, oa_status
      FROM
          oadoi_full.mongo_upwFeb20_08_12
      UNION ALL
      SELECT
          doi, is_paratext, is_oa, journal_is_in_doaj, journal_is_oa, journal_issn_l, journal_issns, oa_status,
      FROM
          oadoi_full.mongo_upwFeb20_13_20
  ) u
  ON
      u.doi = w.doi
  LEFT JOIN (
      SELECT
          doi, evidence, host_type, is_best, repository_institution, url_for_landing_page, url_for_pdf
      FROM
          oadoi_full.mongo_upwFeb20_08_12, unnest(oa_locations)
      UNION ALL
      SELECT
          doi, evidence, host_type, is_best, repository_institution, url_for_landing_page, url_for_pdf
      FROM
          oadoi_full.mongo_upwFeb20_13_20, unnest(oa_locations)
  ) u2
  ON
      w.doi = u2.doi
