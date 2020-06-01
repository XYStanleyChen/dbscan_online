
shinyServer(function(input, output, session) {
    
    output$average_auc <- renderValueBox({
        valueBox(value = 0.917, subtitle = "Average Auc Score", icon = icon("flask"), color = "orange")
    })
})
