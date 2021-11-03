CREATE TABLE pubs_german_pillars_update AS
(SELECT
    items.pk_items,
    items.ut_eid,
    items.doi,
    items.doctype,
    items.pubyear,
    issues.issn,
    sec.pk_kb_sectors,
    sec.sector,
    sec.subsector,
    inst.pk_kb_inst,
    inst.name as inst_name
  FROM
      wos_b_2021.items items
  INNER JOIN
        wos_b_2021.issues issues
            ON issues.pk_issues = items.fk_issues
  INNER JOIN
        wos_b_2021.databasecollection db
            ON db.fk_items =  items.pk_items
   INNER JOIN
        wos_b_2021.kb_a_addr_inst a_addr_inst
             ON items.pk_items = a_addr_inst.fk_items
             AND items.ut_eid = a_addr_inst.ut_eid
   INNER JOIN
        wos_b_2021.kb_inst inst
            ON inst.pk_kb_inst = a_addr_inst.fk_kb_inst
   INNER JOIN
        wos_b_2021.kb_a_inst_sec a_inst_sec
            ON inst.pk_kb_inst = a_inst_sec.fk_kb_inst
   INNER JOIN
        wos_b_2021.kb_sectors sec
            ON sec.pk_kb_sectors = a_inst_sec.fk_kb_sectors
   INNER JOIN
        wos_b_2021.kb_a_addr_sec a_addr_sec
            ON a_addr_sec.fk_kb_a_addr_inst = a_addr_inst.pk_kb_a_addr_inst
            AND a_addr_sec.fk_kb_sectors = sec.pk_kb_sectors
   WHERE
        db.edition_value IN (
            'WOS.SCI', 'WOS.SSCI', 'WOS.AHCI'
        )
        AND items.doctype IN (
            'Article', 'Review'
        )
        AND sec.pk_kb_sectors IN (
            3, 4, 6, 7, 8, 9, 10
        )
        AND items.pubyear > 2009
        AND items.pubyear < 2021
);
