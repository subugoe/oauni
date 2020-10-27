#' select_view UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList reactive selectInput observe updateSelectInput
#' @importFrom dplyr %>% filter
mod_select_view_ui <- function(id){
  ns <- NS(id)
  tagList(
    selectInput(ns("inst"), label = "Highlight institutions:", choices = NULL, multiple = TRUE)
  )
}
    
#' select_view Server Function
#'
#' @noRd 
mod_select_view_server <- function(input, output, session, r){
  ns <- session$ns
  
  observe({
    inst <- r$dataset %>% .$INST_NAME
    updateSelectInput( session, "inst", choices = c(All = "", inst))
  })
  
  r$my_inst <- reactive({
    if(is.null(input$inst)) {
      r$dataset
    } else {
      r$dataset %>%
        dplyr::filter(`INST_NAME` %in% input$inst) 
    }
  })
}
    
## To be copied in the UI
# mod_select_view_ui("select_view_ui_1")
    
## To be copied in the server
# callModule(mod_select_view_server, "select_view_ui_1")
 
