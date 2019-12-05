create table oadoi_full.german_unis_oa_categories as (
select
  w.*,
  u.is_best as upw_is_best,
  u.host_type as upw_host_type,
  u.url as upw_url,
  u.url_for_pdf as url_pdf,
  url_for_landing_page as url_land_page
from
  oadoi_full.doi_list_ger_unis w
left join (
  select
    doi,
    is_best,
    host_type,
    url,
    url_for_pdf,
    url_for_landing_page
  from
    oadoi_full.mongo_export_upwNov19_08_12, unnest(oa_locations)) u
  on lower(w.DOI) = u.doi
)
