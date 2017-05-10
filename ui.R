# This is a software to compare and contrast 
library(shiny)

# Load the data 
scores <- read.csv("nyc_math_scores.csv")
scores$district <- factor(scores$district)
scores$Grade <- factor(scores$Grade)
scores$Year <- factor(scores$Year)


shinyUI(fluidPage(
    titlePanel("NYC Math Scores"),
    sidebarLayout(
        sidebarPanel(
            textInput("title",
                      "Plot title:",
                      value = "Score graphs"),
            
            selectInput(inputId = "x", label = "Choose an x variable",
                        choices = names(scores),
                        selected = "Year"),
            
            selectInput(inputId = "y", label = "Choose a y variable",
                        choices = names(scores),
                        selected = "Mean.Scale.Score"),
            
            numericInput(inputId = "dist", label = "Selecting a district",
                         value = 1, min = 1, max =32),
            
            numericInput(inputId = "grd", label = "Selecting a grade",
                         value = 3, min = 3, max = 8),
            
            numericInput(inputId = "Yr", label = "Select a year for tab2",
                         value = 2006, min = 2006, max = 2012),
            
            sliderInput("range1", "Lower range of districts for tab2", min = 1, max = 32, value = 1),
            
            sliderInput("range2", "Higher range of districts for tab2", min = 1, max = 32, value = 2)
            
        ),
        
        # Show a tabset that includes a plot, summary, and table veiw 
        # of the different graphs for math scores
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Plot1", plotOutput("plot1")),
                        tabPanel("Plot2", plotOutput("plot2"))
                        )
        )
    )
    
)
)