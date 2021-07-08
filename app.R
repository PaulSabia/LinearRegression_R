library(shiny)

# Define UI
ui <- fluidPage(
  # App title
  titlePanel("Predict your House Price!"),
  # Input for square meters
  sidebarPanel(
    sliderInput(inputId = "squareMeters",
      label = "Square Meters",
      min = 1,
      max = 100000,
      value = 50000
    )
  ),
  # Price prediction
  mainPanel(
    tableOutput("predict")
  )
)

# Load saved model
load("model.rData")

# Define server
server <- function(input, output) {
  predictions <- reactive({
    preprocessInput = data.frame(squareMeters = as.integer(input$squareMeters))
    prediction <- predict(model, preprocessInput)
    
    data.frame(
      Prediction = as.character(c(paste(round(prediction, digits=2), " €")))
    )
  })
  output$predict <- renderTable({
    predictions()
  })
}

# Launch the app
shinyApp(ui = ui, server = server)
