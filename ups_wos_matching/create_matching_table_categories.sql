CREATE TABLE german_uni_oa_categories AS (
    SELECT
        w.fk_items AS fk_items,
        w.doi AS doi,
     --   w.doctype as doctype_wos,
     --   w.pubyear as pubyear_wos
        u.pk_oa AS pk_oa,
        u.HOST_TYPE_OAL AS host_type_list,
        u.IS_BEST_OAL AS is_best_list,
        u.URL_OAL AS url_list,
        u.URL_FOR_PDF_OAL AS url_pdf_list,
        u.URL_FOR_LANDING_PAGE_OAL AS url_landing_page_list
    FROM
        GESISMDAVARI.GERMAN_UNI_KB_PILLAR_SECTOR w
    INNER JOIN
        UNPAYWALL.SNAPSHOT_20190816_OA u
        ON w.doi = u.doi
);
