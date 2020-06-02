
shinyServer(function(input, output, session) {
    ################### InitIalization ###################
    output$average_auc <- renderValueBox({
        valueBox(value = 0.917, subtitle = "Average Auc Score", icon = icon("flask"), color = "orange")
    })
    output$average_sil <- renderValueBox({
        valueBox(value = 0.76, subtitle = "Average Silhouette Score", icon = icon("bezier-curve"), color = "blue")
    })
    
    
    output$roc_plot <- renderUI(
        imageOutput(outputId = "roc_image")
    )
    output$roc_image <- renderImage(
        {list(src = "www/roc_1vsall.png", width = "100%", height = "560")},
        deleteFile = FALSE
    )
    
    output$sil_plot <- renderUI(
        imageOutput(outputId = "sil_image")
    )
    output$sil_image <- renderImage(
        {list(src = "www/sil_1.png", width = "100%", height = "560")},
        deleteFile = FALSE
    )
    
    output$info_meme <- renderImage(
        {list(src = "www/meme.jpg", width = "60%", height = "400")},
        deleteFile = FALSE
    )
    
    ################### Click Submit Button ###################
    observeEvent(input$submit_par, {
        
        # # change the roc_plot UI to plot
        # output$roc_plot <- renderUI({
        #     plotOutput(outputId = "image", width = "100%", height = "560")
        # })
        
        # read user parameters, load pump1's data
        user_parameters <- reactiveValues()
        user_parameters$eps <- input$epsilon_in
        user_parameters$minPts <- input$minPts_in
        source("load_pump1_data.R")
        
        # build model
        #epsilon1 <- isolate(user_parameters$eps)
        db1 <- dbscan(d1, eps = isolate(user_parameters$eps), minPts = isolate(user_parameters$minPts))
        actual_clu1 <- db1$cluster #(containing 0,1)
        print(db1)
        
        # change plot accordingly
        if (verify_dbmodel(db1)) {
            # only two clusters
            withProgress(min = 0, max = 7, value = 1, message = "Performing calculation", detail = "This could take a few minutes...",{
                source("load_other_model.R")
                
                # change the roc_plot UI to plot
                output$roc_plot <- renderUI({
                    plotOutput(outputId = "image", width = "100%", height = "560")
                })
                
                ########################## 1 vs all ##########################
                #pre_12 <- predict(db1, newdata = d2, data = d1)
                my_pre_12 <- my_predict(actual_clu_orig = actual_clu1, orig_data = d1, new_data = d2)
                print("pre_12")
                incProgress(amount = 1, message = "Complete prediction of pump2...")
                
                #pre_13 <- predict(db1, newdata = d3, data = d1)
                my_pre_13 <- my_predict(actual_clu_orig = actual_clu1, orig_data = d1, new_data = d3)
                print("pre_13")
                incProgress(amount = 1, message = "Complete prediction of pump3...")
                
                #pre_14 <- predict(db1, newdata = d4, data = d1)
                my_pre_14 <- my_predict(actual_clu_orig = actual_clu1, orig_data = d1, new_data = d4)
                print("pre_14")
                incProgress(amount = 1, message = "Complete prediction of pump4...")
                
                #pre_15 <- predict(db1, newdata = d5, data = d1)
                my_pre_15 <- my_predict(actual_clu_orig = actual_clu1, orig_data = d1, new_data = d5)
                print("pre_15")
                incProgress(amount = 1, message = "Complete prediction of pump5...")
                
                #pre_16 <- predict(db1, newdata = d6, data = d1)
                my_pre_16 <- my_predict(actual_clu_orig = actual_clu1, orig_data = d1, new_data = d6)
                print("pre_16")
                incProgress(amount = 1, message = "Complete prediction of pump6...")
                
                #pre_17 <- predict(db1, newdata = d7, data = d1[,-6]) #6 is instantFlow
                my_pre_17 <- my_predict(actual_clu_orig = actual_clu1, orig_data = d1[,-6], new_data = d7)
                print("prediction done")
                incProgress(amount = 1, message = "Prediction Succeed!")
                
                my_roc12 <- roc(response=actual_clu2, predictor=my_pre_12, auc=T)
                print("roc12 done")
                my_roc13 <- roc(response=actual_clu3, predictor=my_pre_13, auc=T)
                print("roc13 done")
                my_roc14 <- roc(response=actual_clu4, predictor=my_pre_14, auc=T)
                print("roc14 done")
                my_roc15 <- roc(response=actual_clu5, predictor=my_pre_15, auc=T)
                print("roc15 done")
                my_roc16 <- roc(response=actual_clu6, predictor=my_pre_16, auc=T)
                print("roc16 done")
                my_roc17 <- roc(response=actual_clu7, predictor=my_pre_17, auc=T)
                print("roc17 done")
                my_roc.list1 <- list(my_roc12, my_roc13, my_roc14, my_roc15, my_roc16, my_roc17)
                names(my_roc.list1) <- c("my_roc_12", "my_roc_13", "my_roc_14", "my_roc_15", "my_roc_16", "my_roc_17")
                
                # these parameters can be found in example of ?ggroc
                # legacy.axes=T moves x-axis to 0
                my_auc_data1 <- data.frame( content=c(
                    paste("auc = ", round(my_roc12$auc, 3)),
                    paste("auc = ", round(my_roc13$auc, 3)),
                    paste("auc = ", round(my_roc14$auc, 3)),
                    paste("auc = ", round(my_roc15$auc, 3)),
                    paste("auc = ", round(my_roc16$auc, 3)),
                    paste("auc = ", round(my_roc17$auc, 3))),
                    xPos=rep(0.7, times=6),
                    yPos=rep(0.5, times=6),
                    name = c("my_roc_12", "my_roc_13", "my_roc_14", "my_roc_15", "my_roc_16", "my_roc_17"))
                
                # g.group1 <- ggroc(roc.list1, aes = "group", legacy.axes = T,
                #                   alpha = 0.5, colour = "blue", linetype = 5, size = 1.5) +
                #                   xlab("FPR") + ylab("TPR") +
                #                   geom_segment(aes(x = 0, xend = 1, y = 0, yend = 1), color="darkgrey", linetype="dashed")
                # 
                # g1 <- g.group1 + facet_wrap(.~name) + theme(legend.position = "none") +
                #   geom_text(data=auc_data1, mapping = aes(x=auc_data1$xPos, y=auc_data1$yPos, label=auc_data1$content))
                
                ########################## plot ##########################
                output$image <- renderPlot({
                    g.group1 <- ggroc(my_roc.list1, aes = "group", legacy.axes = T,
                                      alpha = 0.5, colour = "blue", linetype = 5, size = 1.5) +
                        xlab("FPR") + ylab("TPR") +
                        geom_segment(aes(x = 0, xend = 1, y = 0, yend = 1), color="darkgrey", linetype="dashed")
                    
                    g.group1 + facet_wrap(.~name) + theme(legend.position = "none") +
                        geom_text(data=my_auc_data1, mapping = aes(x=xPos, y=yPos, label=content))
                    
                })
                ########################## change AUC ##########################
                output$average_auc <- renderValueBox({
                    valueBox(value = round( 
                        (round(my_roc12$auc, 3)+round(my_roc13$auc, 3)+
                             round(my_roc14$auc, 3)+round(my_roc15$auc, 3)+
                             round(my_roc16$auc, 3)+round(my_roc17$auc, 3))/6,
                        3),
                        subtitle = "Your model's AUC",
                        icon = icon("flask"),
                        color = "orange")
                })
                ########################## change Sil ##########################
                sil_1 <- silhouette(db1$cluster, dist=distance1)
                output$sil_plot <- renderUI({
                    plotOutput(outputId = "sil_image", width = "100%", height = "560")
                })
                output$sil_image <- renderPlot({
                    # distance1 already defined in global.R
                    sil1 <- silhouette(db1$cluster, dist=distance1)
                    plot(sil_1, border = NA)
                })
                output$average_sil <- renderValueBox({
                    valueBox(value = round(summary(sil_1, FUN = mean)$avg.width, 3), subtitle = "Your model's Silhouette", icon = icon("bezier-curve"), color = "blue")
                })
                
            }) #End of withProgress
        }
        else{
            # more than two clusters or only one cluster
            showNotification("Nah, bad parameters.", action = "You could read more information in info tab.", type = "warning")
            
            # change the roc_plot UI to meme
            output$roc_plot <- renderUI({
                imageOutput(outputId = "meme", width = "100%", height = "560")
            })
            output$meme <- renderImage(
                {list(src = "www/meme.jpg", width = "100%", height = "560")},
                deleteFile = FALSE
            )
            
            ########################## change Sil ##########################
            sil_1 <- silhouette(db1$cluster, dist=distance1)
            output$sil_plot <- renderUI({
                plotOutput(outputId = "sil_image", width = "100%", height = "560")
            })
            output$sil_image <- renderPlot({
                # distance1 already defined in global.R
                sil1 <- silhouette(db1$cluster, dist=distance1)
                plot(sil_1, border = NA)
            })
            output$average_sil <- renderValueBox({
                valueBox(value = round(summary(sil_1, FUN = mean)$avg.width, 3), subtitle = "Average Silhouette Score", icon = icon("bezier-curve"), color = "blue")
            })
        }
    })
})
