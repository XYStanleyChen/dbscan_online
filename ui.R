
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
                    column(4, valueBoxOutput(outputId = "average_auc", width = 15)),
                    # This box is dynamic,
                    # Therefore its content should changed according to users' activity
                    column(4, valueBoxOutput(outputId = "average_sil", width = 15)),
                    # This box is static,
                    # therefore we use valueBox directly to define the valueBox
                    column(4, valueBox(value = "dbscan", subtitle = "Algorithm", icon = icon("cogs"), color = "purple", width = 15))
                ),
                
                fluidRow(
                    column(6, uiOutput(outputId = "roc_plot")),
                    column(6, uiOutput(outputId = "sil_plot"))
                ), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(),
                
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
                        width = 4, br(),br(),
                        actionButton(inputId = "submit_par", label = "Submit Changes", icon("paper-plane"),
                                     style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
                    )
                ),
                
                fluidRow(
                    box(
                        title = "Learn More about these two images",
                        collapsible = TRUE,
                        collapsed = TRUE,
                        status = "primary",
                        width = 8,
                        background = NULL,
                        p(h5("Left: ", tags$strong("roc-auc curve"), "; Right: ", tags$strong("silhouette plot"))),
                        tags$ul(
                            tags$li(tags$strong("roc-auc curve"), "Generates by cross-validating each one of 7 pumps"),
                            tags$li(tags$strong("silhouette plot"), "An indicator of clustering result(The higher, the better)")
                        ),
                        p(h5(tags$strong("AUC Score"), "Much Lower than Expected?")),
                        tags$ul(
                            tags$li("The reason is that the", tags$code("predict.dbscan_fast"),
                                    "function provided in", tags$code("dbscan"),
                                    "package is far too slow and highly memory-consuming."),
                            tags$li("Therefore, I implemented a simplified version of this function, which compromise the prediction preformance."),
                            tags$li("Generally, you could expect an Average AUC Score about", em(strong("0.2")), "higher than the one shown above.")
                        )
                    )
                )
            ), # end of Model Tab
            ################### Info Tab Content ###################
            # Users may read this information while the model tab is loading.
            # tips: should link to my LinkedIn
            tabItem(tabName = "info",
                    #h1("This is Info Tab"),
                    br(),
                    p(h4("This is a web APP for online dbscan model adjustment:")),
                    tags$ul(
                        tags$li("Data is obtained from a local pump company, you can have a look at the data sets at", tags$a(href = "https://hazyyyyyyy.shinyapps.io/real_water_pump/", "here")),
                        tags$li("You can move the sliders in the", tags$em(tags$strong("model")), "tab to create your own dbscan model based on pump1's data."),
                        tags$li("Training a model could take a few minutes, sorry for the waiting......orz")
                    ),
                    # p(h4("This model is based on dbscan algorithm,", br(),
                    # "You can move the sliders in the", em(strong("model")), "tab to create your own dbscan model based on pump1's data.")),
                    # p(h4("Training a model could take a few minutes, sorry for the waiting......orz")),
                    br(),
                    p(tags$h4("Bad parameters circumstances:")),
                    p("1. Your parameters renders a model with only one cluster ;"),
                    p("2. Your parameters renders a model with more than two clusters ;"),
                    p("Both of these two occasions may results in an error message ."),
                    p(tags$h4("Solution:")),
                    p("Try to increase eps, or decrease minPts !"),
                    fluidRow(
                        column(
                            width = 7,
                            imageOutput(outputId = "info_meme")
                        )
                    ),
                    #br(),br(),br(),hr(),
                    em(h4("Thank you so much for your visit! You can check for more information at the links below:")),
                    p("Code: "), a(href = "https://github.com/hazyyyyyyy/dbscan_online", "https://github.com/hazyyyyyyy/dbscan_online"),
                    br(),
                    p("My LinkedIn: "), a(href = "www.linkedin.com/in/stanley-xueyu-chen", "www.linkedin.com/in/stanley-xueyu-chen"),
                    
            ) # end of Info Tab
        ) # end of tabItems
    ) # end of dashboardBody
)