library(shiny)
library(lattice)

# Load the data 
scores <- read.csv("nyc_math_scores.csv")
scores$district <- factor(scores$district)
scores$Grade <- factor(scores$Grade)
scores$Year <- factor(scores$Year)

districts <- read.csv("district_list.csv")

shinyServer(function(input, output){
    
    # Make user specific variables
    output$text <- renderText({
        input$title
    })
    
    output$plot1 <- renderPlot({
        sub_df <- subset(scores, (district == input$dist & Grade == input$grd))
        x <- sub_df[, input$x]
        y <- sub_df[, input$y]
        xyplot(y ~ x, data = sub_df, grid = TRUE, xlab = input$x,
               ylab = input$y)
    
        })
    
    output$plot2 <- renderPlot({
        sub_df1 <- subset(scores,  (Year == input$Yr))
        sub_df1 <- sub_df1[sub_df1$district %in% c(input$range1,input$range2),]
        xyplot(Mean.Scale.Score ~ Grade|district*Year, data = sub_df1)
    })
})