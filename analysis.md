Analysis of German publication output
================
Anne Hobert
3/6/2020

## Data

In this document we describe the analysis of our sample of publications
from German research institutions. We work with the dataset `pubs_cat`
generated in [data\_gathering.Rmd](data_gathering.Rmd).

## Investigation of research questions

The goal is to answer the three research questions

1)  Has the OA fraction of the publication output of German universities
    and research institutions increased constantly over time?
2)  Can we observe differences between the research sectors of the
    German science system? Are there obvious explanations for this (like
    different missions or subject profiles?
3)  Which OA type is the most prevalent OA approach and can we identify
    different patterns of adoption to OA?

### OA fraction of the German publication output

First, we look at how the overall OA share developed over time. The
following figure displays the number of publications associated with one
of the German research institutions we considered and highlights they
part that is freely accessible online according to Unpaywall over the
considered time period from 2010 until
2018.

<div class="figure" style="text-align: center">

<img src="analysis_files/figure-gfm/unnamed-chunk-4-1.png" alt="Open access to journal articles from German research institutions according to Unpaywall. Blue area represents journal articles with at least one freely available full-text, grey area represents toll-access articles." width="90%" />

<p class="caption">

Open access to journal articles from German research institutions
according to Unpaywall. Blue area represents journal articles with at
least one freely available full-text, grey area represents toll-access
articles.

</p>

</div>

As can be seen, the total number of articles, as well as the part that
is OA increases constantly over time. The number of articles that are
not openly available, is quite stable with a slow increase from 54567 in
2010 to 56323 in 2013, and decreasing again continuously from that point
onwards to 52184 publications in 2018. Since the number of OA articles
increases continuously from 28993 publications in 2010 to 55031 in 2018,
the relative proportion of OA articles rises significantly from 34.7 %
in 2010 to 51.33 % in 2018.

### Differences between sectors

In order to investigate what role the different sectors play in OA
publishing in Germany and how they contribute to the OA
development/overall OA shares, we distplay the development over time of
the number of OA articles for each sector in the following figure. Note
that scales for the `y-axes` are not the same, since the total
publication output varies significantly among
sectors.

<div class="figure" style="text-align: center">

<img src="analysis_files/figure-gfm/unnamed-chunk-6-1.png" alt="Open access to journal articles per sector according to Unpaywall. Blue area represents journal articles with at least one freely available full-text, grey area represents toll-access articles. Sectors are ordered by publication output with the highest output top left and lowest at the bottom. Note that scales for the `y-axes` are not the same, since the total publication output varies significantly among sectors." width="90%" />

<p class="caption">

Open access to journal articles per sector according to Unpaywall. Blue
area represents journal articles with at least one freely available
full-text, grey area represents toll-access articles. Sectors are
ordered by publication output with the highest output top left and
lowest at the bottom. Note that scales for the `y-axes` are not the
same, since the total publication output varies significantly among
sectors.

</p>

</div>

In order to investigate the variability of OA publishing within the
sectors, we now go one level deeper and examine OA shares of individual
institutions, grouped by the sector they belong to. We only include
institututions with a publication output of at least 100 publications in
the observed time period of 9 years. Of the 469 institutions in total,
334 fulfill this condition. This means, that in the following
institution specific analyses, 135 insitutions, or 4649 articles are not
considered. Of the remaining institutions, we first calculate the
individual OA shares.

The following figure displays scatterplots where the OA share of an
institution over the whole time period is shown with respect to its
publication
output.

<div class="figure" style="text-align: center">

<img src="analysis_files/figure-gfm/unnamed-chunk-8-1.png" alt="Open Access shares of research institutions in Germany with respect to their total publication output grouped by the sector they belong to. Only institutions with at least 100 publications are shown. Blue points correspond to single insitutions, gray lines are obained by linear regression within the sector, gray areas are pointwise symmetric 95% t-distribution confidence bands. Scales of the x-axes vary across subplots in order to adapt to the different publication volumes. Dashed lines show the median value per sector for the OA share (red) and the total number of publications (orange)." width="90%" />

<p class="caption">

Open Access shares of research institutions in Germany with respect to
their total publication output grouped by the sector they belong to.
Only institutions with at least 100 publications are shown. Blue points
correspond to single insitutions, gray lines are obained by linear
regression within the sector, gray areas are pointwise symmetric 95%
t-distribution confidence bands. Scales of the x-axes vary across
subplots in order to adapt to the different publication volumes. Dashed
lines show the median value per sector for the OA share (red) and the
total number of publications (orange).

</p>

</div>

The most striking observations from this figure are the high OA shares
of most of the Max-Planck and Helmholtz institutes and the very low OA
fractions of almost all of the state and federal institutes as well as
the ones from the Fraunhofer Society. Universities and Leibniz-Society
have many institutes with OA shares close to one half. We can further
see very well that the universities have by far the largest publication
volumes, followed by the Helmholtz-Society. The linear trend of higher
publication volume implying higher OA shares is most distinctive for the
university sector (narrowest confidence bands).

The following box plot quantifies the observations regarding the
variability of OA shares within sectors made
before.

<div class="figure" style="text-align: center">

<img src="analysis_files/figure-gfm/unnamed-chunk-9-1.png" alt="OA shares of German research institutions per sector. The color of the boxes groups sectors into universities with a typically high total journal publication output, research-oriented institutes with a medium journal publication output and practise oriented institutions with a comparatively low journal publication output. Gray points display the OA shares for individual institutions." width="90%" />

<p class="caption">

OA shares of German research institutions per sector. The color of the
boxes groups sectors into universities with a typically high total
journal publication output, research-oriented institutes with a medium
journal publication output and practise oriented institutions with a
comparatively low journal publication output. Gray points display the OA
shares for individual institutions.

</p>

</div>

### Prevalences of OA categories

As mentioned in the previous chapters, there are several ways of
providing open access to scientific journal articles. In this section,
we want to investigate the prevalence of the most widespread OA routes:
Green OA and Gold OA. We further distinguish these two main categories
as described in the methodology section (see Table 1) according to
whether the journal is fully OA (Gold OA), and into deposition on
disciplinary, institutional, or OpenDOAR-listed repositories (Green OA).
Note that, as mentioned before, the OA categories are not exclusive,
that is, an article might be counted for several categories and numbers
not necessarily sum up to the total number of articles published. As a
preliminary step, we therefore illustrate the most common combinations
of OA categories in our dataset.

Keeping in mind that our categories are non-exclusive, as just shown, we
now visualise the number of articles per category on the national level,
that is, without differentiation by
sector.

<div class="figure" style="text-align: center">

<img src="analysis_files/figure-gfm/unnamed-chunk-12-1.png" alt="Development of the percentage of journal articles per OA category (as per schema in Table 1) over time. Categories are non-exclusive, that is some articles may be counted for more than one category. Colors correspond to the OA category. Grey area displays the total percentage of OA publications. On the left, access provided via a publisher is highlighted, on the right via repositories. " width="90%" />

<p class="caption">

Development of the percentage of journal articles per OA category (as
per schema in Table 1) over time. Categories are non-exclusive, that is
some articles may be counted for more than one category. Colors
correspond to the OA category. Grey area displays the total percentage
of OA publications. On the left, access provided via a publisher is
highlighted, on the right via repositories.

</p>

</div>

Observations:

  - drop in other oa journal -\> Delayed OA
  - slight drop in other\_repo -\> more sources registered, published
    more in registered sources
  - apart from this: all OA categories increase, not oa decreases
  - most prevalent category: subject-specific repos, registered with
    OpenDOAR

Again, we go one step further and look at sector specific OA
proportions.

<div class="figure" style="text-align: center">

<img src="analysis_files/figure-gfm/unnamed-chunk-13-1.png" alt="OA shares per category and sector. Coloring displays the percentage in the respective category, size of the points corresponds to the total publication output. Grey numbers display the percentage value explicitly. The bottom row shows the overall OA share of the sectors, the rightmost column the percentage of articles in the corresponding category regardless of the sector (on the national level)." width="90%" />

<p class="caption">

OA shares per category and sector. Coloring displays the percentage in
the respective category, size of the points corresponds to the total
publication output. Grey numbers display the percentage value
explicitly. The bottom row shows the overall OA share of the sectors,
the rightmost column the percentage of articles in the corresponding
category regardless of the sector (on the national level).

</p>

</div>

size according to share as
well:

<div class="figure" style="text-align: center">

<img src="analysis_files/figure-gfm/unnamed-chunk-14-1.png" alt="OA shares per category and sector. Coloring and size of the points displays the percentage in the respective category. Grey numbers display the percentage value explicitly. The bottom row shows the overall OA share of the sectors, the rightmost column the percentage of articles in the corresponding category regardless of the sector (on the national level)." width="90%" />

<p class="caption">

OA shares per category and sector. Coloring and size of the points
displays the percentage in the respective category. Grey numbers display
the percentage value explicitly. The bottom row shows the overall OA
share of the sectors, the rightmost column the percentage of articles in
the corresponding category regardless of the sector (on the national
level).

</p>

</div>

<div class="figure" style="text-align: center">

<img src="analysis_files/figure-gfm/unnamed-chunk-15-1.png" alt="OA shares per category and sector. The relationship between OA shares of individual OA categories (as per schema in Table 1) and overall OA share is shown. Coloring and shape is according to sector. Sizes of shapes correspond to total publication output." width="90%" />

<p class="caption">

OA shares per category and sector. The relationship between OA shares of
individual OA categories (as per schema in Table 1) and overall OA share
is shown. Coloring and shape is according to sector. Sizes of shapes
correspond to total publication output.

</p>

</div>

### Discussion

  - Upset plot of overlapping evidence categories to show influence of
    semantic scholar, webscraping.

In order to demonstrate the prevalence of evidence categories in
Unpaywall, we load the original, non-categorized Unpaywall data:

We now determine the evidence combinations for all matched DOIs and then
calculate the frequency of each combination found.

We now prepare the data for plotting with the UpSetR package and
visualise the overlapping evidence categories.
