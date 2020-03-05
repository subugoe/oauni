<!-- TOC -->

- [Minutes of Meetings and Calls](#minutes-of-meetings-and-calls)
  - [Minutes of Call 5 March 2020](#minutes-of-call-5-march-2020)
  - [Minutes of Call 8 January 2020](#minutes-of-call-8-january-2020)
  - [Minutes of Call 18 Dec 2019](#minutes-of-call-18-dec-2019)
  - [Minutes of Call 11 Dec 2019](#minutes-of-call-11-dec-2019)
  - [Minutes of Call 4 Dec 2019](#minutes-of-call-4-dec-2019)
  - [Minutes of Call 20 Nov 2019](#minutes-of-call-20-nov-2019)
  - [Minutes of Call 6 Nov 2019](#minutes-of-call-6-nov-2019)
  - [Minutes of Call 30 Oct 2019](#minutes-of-call-30-oct-2019)
  - [Minutes of Initiating Call 17 Oct 2019](#minutes-of-initiating-call-17-oct-2019)

<!-- /TOC -->

# Minutes of Meetings and Calls

## Minutes of Call 5 March 2020

Participants
-----
- Philipp
- Niels
- Anne

Agenda
-----

- shown an example of the type of graphic that can be used in discussion to critically reflect on categorisation
- Next steps:
  - Niels will elaborate on literature review
  - Anne will include some results by the end of the week
  - Philipp will work on it on Monday
- Deadline: agree upon authors, title etc. by end of March, have preprint ready by end of April

Next meeting: Thursday, 12 March


## Minutes of Call 8 January 2020

Participants
-----
- Philipp
- Niels
- Masoud
- Anne

Agenda
-----

**Preliminary results**

- shown some first figures for development of numbers of articles on the national level, sectoral level and institutional level
- figures for national and sectoral level are promising; institutional level has to be discussed in more detail (see section below)

**Publishing of aggregated table on the institutional level**

- aggregation on the institutional level leaves many fields with just 1 publication, question: are we allowed to publish such a table? (answer: probably yes, because it is just a counting result, does not contain identifiers)
- which analyses to conduct exactly: which institution to choose for visualisation, which criteria? what comparisons are interesting?
- orientation: [recent report](https://pub.uni-bielefeld.de/download/2912807/2912864/OA-Gold-Report.pdf) by Niels and others, grouping of institutions according to
  - total publication output
  - OA share
  - OA growth
- include total publication output, OA share and OA growth in tables to publish (might be interesting for individual institutions)

**Next steps/homework**

- Anne: send around brief report with presented results
- Anne: produce aggregated tables to publish and some analysis results to choose from (which to include in the paper or appendix);
- everybody: contribute to text, contributions to chapters more or less according to comments in the document

**Next Call**

on Thursday, 16th at 10:00


## Minutes of Call 18 Dec 2019

Date
-----
18 December 2019

Participants
-----
- Philipp
- Niels
- Najko
- Anne

Agenda
-----

**Duplikate durch Repositorienzuordnung**

- Manche Repositorien haben dieselbe Domain (zB. opus4.kobv.de) und unterscheiden sich nur in der Subdomain. Jeder Unpaywalleintrag mit dieser Domain wird dann mit jedem Repositorium dieser Domain gematcht
- Doppelungen im Unpaywalldatensatz
- Lösung: Analyse basierend auf aggregierten Datensätzen, die jeden Artikel pro OA Typ und Aggregationslevel nur einfach zählen
- 3 Aggregationslevel: Institution - Sektor - National

**Forschungsfragen**
- Analyse auf Instutionenebene: zeitliche Entwicklung, Vergleiche
- Analyse auf Sektorenebene: Nullhypothese, dass OA Anteile über alle Sektoren gleich sind, widerlegbar?
- Philipp und Niels: genauere Festlegung und Formulierung im gemeinsamen [Google Doc](https://docs.google.com/document/d/1GZtq2jrPcmU9Bab6pKOSay7f_u-XE5E0-T6ElyF4ZhI/edit#)

**Next Call**

8 Januar 2020, 10 Uhr

## Minutes of Call 11 Dec 2019

Date
-----
11 December 2019

Participants
-----
- Philipp
- Najko
- Anne
- Niels

Agenda
-----

**Semanticscholar**
- more than 20 % of full text links with host_type repository have domain "pdfs.semanticscholar.org"
- significant effect on proportions of publisher-based, repository-based and overlapping categories
- 3 options:
  - exclude records with semanticscholar link
  - keep them as repository-based records
  - define a third category "semanticscholar" in addition to publisher based OA and repository based OA
- go with 3rd option, homework: reflect on this

**Full OA journals**
- two options: use `journal_is_oa` field from Unpaywall or Bielefeld ISSN-Gold-OA list
- about 1500 journals are in ISSN-Gold-OA list but not OA in Unpaywall, 129 vice versa
- classify as OA journal any ISSN, which is in ISSN-Gold-OA list or Unpaywall list

**Publication years**

- publication years registered in WoS and Unpaywall differ, WoS up to two years later than Unpaywall, see [matching report](https://github.com/nicholasmfraser/wos_unpaywall_matching/blob/master/report.pdf).
- Unpaywall tables in Big Query contain records with publication years 2008 onwards
- restrict analysis to WoS records with publication year 2010 until 2018

**Draft for paper**
- [first draft](https://docs.google.com/document/d/1GZtq2jrPcmU9Bab6pKOSay7f_u-XE5E0-T6ElyF4ZhI/edit#) for the joint paper
- start writing
  - research questions: everybody, serves as orientation for data analysis
  - Introduction and Background: mainly Philipp
  - Methodology: Masoud, Niels, Najko, Anne
  - Results: Najko, Anne; additional section on citation analysis ? (Masoud, Philipp)

**Data schema**
- data schema specified in [paper draft](https://docs.google.com/document/d/1GZtq2jrPcmU9Bab6pKOSay7f_u-XE5E0-T6ElyF4ZhI/edit#)
- add oa information with that schema to table in WoS

**Next call**

Wednesday, 18 December, 9:30


## Minutes of Call 4 Dec 2019

Date
-----
4 December 2019

Participants
-----
- Philipp
- Najko
- Anne

Agenda
-----

**Unpaywall data**
- in KB infrastructure: April data set, contains errors: some publisher based entries are classified as repository based
- use Big Query table with November 2019 snapshot to generate matching table

**Journal**
- submit final version at Scientometrics, publish preprint OA
- second option: JASIST

**Next Call**
- next week after Status Call

## Minutes of Call 20 Nov 2019

Date
-----
20 November 2019

Participants
-----
- Philipp
- Masoud
- Najko
- Anne

Agenda
-----

**Unpaywall data**

- Import is ongoing, should be finished these days
- In future: DZHW will update, at least yearly

**Research focus**

- 5 pillars + 2
- OA categories:
  - done by Göttingen, types as stated below
  - matching: Göttingen, UT list of german institution provided by GESIS
- focus mainly on OA shares, perhaps add citation advantage

**Next meeting**
after matching is finished,exact date to be specified

## Minutes of Call 6 Nov 2019

Date
-----
6 November 2019

Participants
------

- Philipp
- Masoud
- Niels
- Anne

Agenda
------

**Sectors**
- selection: 5 pillars + Ressortforschung
- 2 cases that appear twice (in different sectors)
  - include in analyses on the level of sectors, count them only for one sector in analyses on the national level
- 5 pillars: number of institutions seem correct
- Ressortforschung: include them in the dataset, maybe exclude them for the analyses later on

**OA Types**
- as agreed upon in the first call (see [below](#minutes-of-initiating-call-17-oct-2019)): own classification, implemented by Göttingen
- ask Stephan again about making the Unpwaywall dataset available
- start matching and classification in two to three weeks (hopefully with dataset in KB, if not other solution)

**Research questions**
- Focus on first one: OA shares
- Citation analysis: Compare closed vs. gold or green vs. closed or gold vs. green ?
- Collaboration analysis in a separate paper, but have an eye on average number of coauthors

**Timeline**

- complete until Status meeting in January
- start literature review based on OASE-grant application (Philipp), add reviews of newer papers, Piwowar and so on (everybody)


## Minutes of Call 30 Oct 2019

Date
-----

30 October 2019

Participants
----------

- Philipp
- Neda
- Najko
- Anne

Agenda
------

**Sector productivity**

- queries shared in the joint repository ([https://github.com/subugoe/oa-german-inst/tree/master/productivity_sectors](https://github.com/subugoe/oa-german-inst/tree/master/productivity_sectors))
- resulting numbers: [https://drive.google.com/file/d/1FgpCs6Ar91DvU8NsqHRyk_JG_AvivDg2/view](https://drive.google.com/file/d/1FgpCs6Ar91DvU8NsqHRyk_JG_AvivDg2/view)
- potential additional sectors of 'Ressortforschung' have relatively low publication output

**Open Questions**

- Matching based purely on doi or additionally on title for increased precision?
- Which institutions to select? In particular, including Ressortforschung or not?
- Which research question(s) to focus on?

**Next call**

Next week Wednesday, depending on Niels' schedule


## Minutes of Initiating Call 17 Oct 2019

Date
-----

17 October 2019

Participants
----------

- Philipp
- Neda
- Masoud
- Niels
- Najko
- Anne

Agenda
------

See also shared document of this initial call [here](https://docs.google.com/document/d/1hzOFxW1DNEzfs3bX5VkPKkMefK7Nw-Elo0GtlfpNma4/edit#).

**Previous work**

- OASE: [ISSI paper](https://arxiv.org/abs/1905.00011)
- OAUNI: [talk at OA Tage](https://docs.google.com/presentation/d/1cKVjxyq1XZpe1ITGb9Up38SBWDz7z0c1NwPVqH56fM4/edit?usp=sharing)

**Data selection**

- **sectors**
  - investigate productivity, then agree upon sampling
  - e.g. five-pillar approach
  - or publicly funded research (highlighted in green in [shared document](https://docs.google.com/document/d/1hzOFxW1DNEzfs3bX5VkPKkMefK7Nw-Elo0GtlfpNma4/edit#))
  - still to decide: what parts of the analysis will be conducted at the level of institutions, or level of sectors, resp.
- **OA types**: own categorization scheme instead of relying upon Unpaywall oa_status, since some categories are questionable, and scheme may be subject to changes; use host_type field for classification (in Göttingen):
  - Host Type : Publisher / Repository (overlap per article is possible)
  - Sub Host Types
    - Publisher: Fully OA Journal / other Journal (mutually exclusive, using ISSN Gold List)
    -  Repository: Subject Repository / Institutional Repository (using URL domains, overlap per article possible) / Other repository
- **Time period**: 2008 - 2018 (not earlier since affiliation information most reliable from 2008 onwards)
- **Authors**:
  - gather all author information for each record, gather also tag 'RP' or 'RS'
  - some more discussion needed regarding which parts of the analysis should be restricted to corresponding authorships only
- **Document type**: Article and Review

**Research ideas**

1. **Investigate to what extent the OA fraction of the publication output of German universities/institutions has increased in the last years** - ISSI poster approach + a refined methodology (reprint authors + matching) and more data (mainly more institutions) and different OA types + Analysis with Unpaywall April 2019
2. **Investigating a citation advantage for OA (Gold, Green, ...) publications compared to closed** - replicating the previous research (Kurtz et al., 2005; Eysenbach, 2006, ...) on OA for the situation in Germany
3. **Collaboration analysis** in different sectors (Bielefeld), overview over German research landscape

**Tasks**

- Investigate productivity of sectors (@GESIS)
- Investigate collaboration network (@Niels), share recent paper
- Determine OA status for selected publications (@SUB)
- Set up GitHub repository (@Anne) to share routines, queries, and minutes

**Next call**

Wednesday, 30th of October, ca. 11:30 (directly after Status Call)
