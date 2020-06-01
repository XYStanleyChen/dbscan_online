
ui <- dashboardPage(
    skin = "blue",
    header = dashboardHeader(title = "Dbscan Adjustment"),
    
    sidebar = dashboardSidebar(
        sidebarMenu(
            menuItem(text = "Model", icon = icon("cube"), tabName = "model"),
            menuItem(text = "Info", icon = icon("question-circle"), tabName = "info")
        )
    ),
    
    body = dashboardBody(
        tabItems(
            # Model Tab:
            # Users may adjust parameters here
            tabItem(
                tabName = "model",
                h1("More information available on info page"),
                ################### Model Tab Content ###################
                fluidRow(
                  # This box is dynamic,
                  # Therefore its content should changed according to users' activity
                  column(6, valueBoxOutput(outputId = "average_auc", width = 15)),
                  # This box is dynamic,
                  # Therefore its content should changed according to users' activity
                  #valueBoxOutput(outputId = "average_sil", width = 15),
                  # This box is static,
                  # therefore we use valueBox directly to define the valueBox
                  column(6, valueBox(value = "dbscan", subtitle = "Algorithm", icon = icon("cogs"), color = "purple", width = 15))
                ),

                fluidRow(
                  column(6, uiOutput(outputId = "roc_plot")),
                  column(6, uiOutput(outputId = "sil_plot"))
                ),

                fluidRow(
                  column(
                    width = 4,
                    #slider1_style <- HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: green}"),
                    sliderInput(inputId = "epsilon_in", label = "epsilon(default 2):", min = 1, max = 5, value = 2)
                    ),
                  column(
                    width = 4,
                    #slider2_stylr <- HTML(".js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge, .js-irs-1 .irs-bar {background: red}"),
                    sliderInput(inputId = "minPts_in", label = "minimum points per cluster(default 16):", min = 1, max = 100, value = 16)
                  ),
                  # This actionButton style can be found on: https://stackoverflow.com/questions/33620133/change-the-color-of-action-button-in-shiny
                  column(
                    width = 4,
                    actionButton(inputId = "submit_par", label = "Submit Changes", icon("paper-plane"),
                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
                  )
                ),

                fluidRow(
                  box(
                    title = "Learn More about the prediction result image",
                    collapsible = TRUE,
                    collapsed = TRUE,
                    status = "primary",
                    width = 8,
                    background = NULL,
                    p(h5("Wanna Reset the Plot?")),
                    tags$ul(
                      tags$li("Simply", tags$strong("Choose a different option"), "in the select box")
                    ),
                    p(h5("AUC Score Much Lower than Expected?")),
                    tags$ul(
                      tags$li("The reason is that the", tags$code("predict.dbscan_fast"),
                              "function provided in", tags$code("dbscan"),
                              "package is far too slow and highly memory-consuming."),
                      tags$li("Therefore, I implemented a simplified version of this function, which compromise the prediction preformance."),
                      tags$li("Generally, you could expect an Average AUC Score about", em(strong("0.2")), "higher than the one shown above.")
                    )
                  )
                )
            ) # end of tabItem
        ) # end of tabItems
    ) # end of dashboardBody
)