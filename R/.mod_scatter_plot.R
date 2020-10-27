#' scatter_plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList
#' @importFrom plotly plotlyOutput ggplotly renderPlotly style config
#' @importFrom dplyr %>%
mod_scatter_plot_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotlyOutput(ns("plot"))
  )
}
    
#' scatter_plot Server Function
#'
#' @noRd 
mod_scatter_plot_server <- function(input, output, session, r){
  ns <- session$ns
  
  output$plot <- renderPlotly({
    p <- scatterplot_oa(r$dataset, r$my_inst())
     plotly::ggplotly(p, tooltip = "text") %>%
       plotly::style(hoverlabel = list(bgcolor = "white"), hoveron = "fill") %>%
       plotly::config(toImageButtonOptions = list(format = "svg"))
  })
}
    
## To be copied in the UI
# mod_scatter_plot_ui("scatter_plot_ui_1")
    
## To be copied in the server
# callModule(mod_scatter_plot_server, "scatter_plot_ui_1")
 
