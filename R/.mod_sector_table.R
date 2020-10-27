#' sector_table UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @importFrom reactable reactableOutput renderReactable
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_sector_table_ui <- function(id){
  ns <- NS(id)

  fluidPage(fluidRow(
    tabBox(title = "OA summaries per sector (2010-18)",
        tabPanel("Overview sectors",
                 reactableOutput(ns("s2all"))),
        tabPanel("Universities",
                 reactableOutput(ns("s2uni"))),
        tabPanel("Helmholtz Association",
                 reactableOutput(ns("s2helmholtz"))),
        tabPanel("Max Planck Society",
                 reactableOutput(ns("s2mpg"))),
        tabPanel("Leibniz Society",
                 reactableOutput(ns("s2leibniz"))),
        tabPanel("Government Research Agencies",
                 reactableOutput(ns("s2gov"))),
        tabPanel("Fraunhofer Society",
                 reactableOutput(ns("fraunhofer"))),
        tabPanel("Description",
                 imageOutput(ns("photo")),
                 HTML("<p></p>",
                      "<p>This classification scheme illustrates how OA categories were derived. The classification is defined in more detail in the preprint article which is available together with supplementary material at:
                                      <p>Hobert, Anne, Jahn, Najko, Mayr, Philipp, Schmidt, Birgit, & Taubert, Niels. (2020). Open Access Uptake in Germany 2010-18: Adoption in a diverse research landscape. <a href='http://doi.org/10.5281/zenodo.3892951'>http://doi.org/10.5281/zenodo.3892951</a>[Preprint]</p></p>",
                      "<p>The classification uses open access information from:
                      <ul>
                          <li>the <a href='https://pub.uni-bielefeld.de/record/2934907'>ISSN-Gold-OA-3.0 list</a> provided and maintained by Bielefeld University,</li>
                          <li>the open access discovery service <a href='https://unpaywall.org/'>Unpaywall</a> provided and maintained by Impactstory, and</li>
                          <li>the registry for open access repositories <a href='https://v2.sherpa.ac.uk/opendoar/'>OpenDOAR</a>.</li>
                      </ul>
                      </p>")),
        width = 12
  ))
  )
}

#' sector_table Server Function
#'
#' @noRd
mod_sector_table_server <- function(input, output, session){
  ns <- session$ns
  output$s2all <- renderReactable({
    s2_react_table(s2_all, all = TRUE)
  })
  output$s2uni <- renderReactable({
    s2_react_table(s2_uni)
  })
  output$s2helmholtz <- renderReactable({
    s2_react_table(s2_helmholtz)
  })
  output$s2mpg <- renderReactable({
    s2_react_table(s2_mpg)
  })
  output$s2leibniz <- renderReactable({
    s2_react_table(s2_leibniz)
  })
  output$s2gov <- renderReactable({
    s2_react_table(s2_gra)
  })
  output$fraunhofer <- renderReactable({
    s2_react_table(s2_fraunhofer)
  })
  output$photo <- renderImage(
    list(
      src = system.file("oa_class_scheme_bold.png", package = "oauni"),
      contentType = "image/png",
      width = 630,
      height = 400
    )
  )

}

## To be copied in the UI
# mod_sector_table_ui("sector_table_ui_1")

## To be copied in the server
# callModule(mod_sector_table_server, "sector_table_ui_1")
