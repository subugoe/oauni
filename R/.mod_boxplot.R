#' boxplot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @importFrom plotly plotlyOutput
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_boxplot_ui <- function(id) {
  ns <- NS(id)
  fluidPage(fluidRow(
    box(title = "OA percentage across sectors",
        plotly::plotlyOutput(ns("boxplot")), width = 8,
        footer = tags$small("OA shares of German research institutions per sector. The color of the boxes groups sectors into universities with a typically high total journal publication output, research-oriented institutes with a medium journal publication output and practise oriented institutions with a comparatively low journal publication output. Colored circles display the OA shares for individual institutions, larger filled points highlight specific institutions upon selection.")),
    box(
      title = "Benchmark OA percentage",
      selectInput(
        ns("inst"),
        "Highlight institutions:",
        choices = c("Select ..." = "", select_inst_sector),
        multiple = TRUE,
        selected = "Select ..."
      ),
      sliderInput(
        ns("pubyear"),
        label = "Publication period:",
        min = 2010,
        max = 2018,
        value = c(2010, 2018),
        sep = ""
      ),
      selectInput(
        ns("oa_cat"),
        label = "Which articles should be included?",
        choices = setNames(c("All",
                             levels(oa_shares_inst_sec_boxplot$oa_host)[1:2],
                             levels(oa_shares_inst_sec_boxplot$oa_category)),
                           c("All OA articles",
                             "All OA Journal",
                             "All OA Repository",
                             "Full OA Journal",
                             "Other OA Journal",
                             "Repositories in OpenDOAR: institutional",
                             "Repositories in OpenDOAR: disciplinary",
                             "Repositories in OpenDOAR: other",
                             "Other Repositories",
                             "Closed articles"))
      ),
      width = 4
    )
  ))
}

#' boxplot Server Function
#'
#' @importFrom dplyr filter between group_by summarise mutate
#' @importFrom plotly ggplotly style config layout
#'
#' @noRd
mod_boxplot_server <- function(input, output, session) {
  ns <- session$ns
  
  output$boxplot <- renderPlotly({
    req(input$pubyear)
    
    if (input$oa_cat == "All"){
      boxplot_df <- oa_shares_inst_sec_boxplot %>% 
        dplyr::distinct(PUBYEAR, INST_NAME, sec_abbr, sector_cat, articles, oa_articles) %>% 
        dplyr::filter(between(PUBYEAR, min(input$pubyear), max(input$pubyear))) %>%
        dplyr::group_by(INST_NAME, sec_abbr, sector_cat) %>%
        dplyr::summarise(oa_articles = sum(oa_articles),
                         articles = sum(articles)) %>%
        dplyr::mutate(prop = oa_articles / articles)
    } else {
      if (input$oa_cat %in% c("journal", "repository")) {
        boxplot_df <- oa_shares_inst_sec_boxplot %>% 
          dplyr::filter(oa_host == input$oa_cat) %>% 
          dplyr::distinct(PUBYEAR, INST_NAME, sec_abbr, sector_cat, articles, n_host) %>% 
          dplyr::filter(between(PUBYEAR, min(input$pubyear), max(input$pubyear))) %>%
          dplyr::group_by(INST_NAME, sec_abbr, sector_cat) %>%
          dplyr::summarise(n_host = sum(n_host),
                           articles = sum(articles)) %>%
          dplyr::mutate(prop = n_host / articles)
      } else{
        boxplot_df <- oa_shares_inst_sec_boxplot %>% 
          dplyr::filter(oa_category == input$oa_cat) %>% 
          dplyr::distinct(PUBYEAR, INST_NAME, sec_abbr, sector_cat, articles, n_cat) %>% 
          dplyr::group_by(INST_NAME, sec_abbr, sector_cat) %>% 
          dplyr::summarise(n_cat = sum(n_cat),
                           articles = sum(articles)) %>% 
          dplyr::mutate(prop = n_cat / articles)
      }
    }
    
    
    if (is.null(input$inst)) {
      p <- boxplot_oa(boxplot_df)
    } else {
      p <- boxplot_oa(boxplot_df,
                      insts = dplyr::filter(boxplot_df, INST_NAME %in% input$inst))
      NULL
    }
    
    
    p <- plotly::ggplotly(p, tooltip = "text") %>%
      plotly::style(hoverlabel = list(bgcolor = "white"),
                    hoveron = "fill") %>%
      plotly::config(toImageButtonOptions = list(format = "svg")) %>%
      plotly::layout(legend = list(
        orientation = "h",
        x = 0.4,
        y = -0.4
      ))
  })
}

## To be copied in the UI
# mod_boxplot_ui("boxplot_ui_1")

## To be copied in the server
# callModule(mod_boxplot_server, "boxplot_ui_1")
