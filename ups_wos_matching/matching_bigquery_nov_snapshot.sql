create table oadoi_full.german_unis_oa_categories as (
select
  w.*,
  u.oa_status,
  u2.is_best,
  u2.host_type,
  u2.url,
  u2.url_for_pdf,
  u2.url_for_landing_page
from
  oadoi_full.doi_list_ger_unis w
left join (
    select
      doi, oa_status
    from
      oadoi_full.mongo_export_upwNov19_08_12
    union all
    select
        doi, oa_status
    from
      oadoi_full.mongo_export_upwNov19_13_19 ) u
    on lower(w.DOI) = u.doi
left join (
    select
      doi,
      is_best,
      host_type,
      url,
      url_for_pdf,
      url_for_landing_page
    from
      oadoi_full.mongo_export_upwNov19_08_12, unnest(oa_locations)
    union all
    select
      doi,
      is_best,
      host_type,
      url,
      url_for_pdf,
      url_for_landing_page
    from
      oadoi_full.mongo_export_upwNov19_13_19, unnest(oa_locations)) u2
    on lower(w.DOI) = u2.doi
)
