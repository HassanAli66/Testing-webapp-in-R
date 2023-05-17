library(shiny)
library(httr)

ui <- fluidPage(
  titlePanel("Weather App"),
  sidebarLayout(
    sidebarPanel(
      textInput("city_input", "Enter City Name:", value = ""),
      br(),
      actionButton("submit_button", "Submit")
    ),
    mainPanel(
      textOutput("weather_output")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$submit_button, {
    city <- URLencode(input$city_input)
    apiKey <- '0981a53056535828bdc13e46f571d4a2'
    url <- paste0("http://api.openweathermap.org/data/2.5/weather?q=", city, "&appid=", apiKey, "&units=metric")
    response <- GET(url)
    weather_data <- content(response, as = "parsed")
    temp <- weather_data$main$temp
    humidity <- weather_data$main$humidity
    output$weather_output <- renderText(paste0("Temperature: ", temp, "°C\n", "Humidity: ", humidity, "%"))
  })
}

shinyApp(ui = ui, server = server,options = list(host = "put your host here"), port = 5002))
