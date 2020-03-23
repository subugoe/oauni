# oa-german-inst
OASE-OAUNI collaboration on the open access status of the publication output of German research institutions (universities, non-university research institutes, and federal and state institutions).

The goal is to answer the three research questions 

1) Has the OA fraction of the publication output of German universities and research institutions increased constantly over time?
2) Can we observe differences between the research sectors of the German science system? Are there obvious explanations for this (like different missions or subject profiles?
3) Which OA type is the most prevalent OA approach and can we identify different patterns of adoption to OA?

The analyses we conducted are documented within this repository.

The final analysis of the considered dataset is reported in [analysis.Rmd](analysis.Rmd)

The document [data_gathering.Rmd](data_gathering.Rmd) describes how the data have been selected, pulled from the different sources, combined, preprocessed and classified according to our own schema. Relevant code for this step (sql and R scripts) is documented in the folder [data_gathering_preprocessing](data_gathering_preprocessing/).

The folder [data](data/) contains datasets that we downloaded from external sources (like the ISSN to ISSN-L conversion list), as well as intermediate steps of the data gathering process (some of them generated and stored only locally, not here on Github).

Some preliminary descriptive analysis that we undertook to better understand the data is contained in [exploration.Rmd](exploration.Rmd) together with some plot-testing.
