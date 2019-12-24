
library(shiny)
library(quantmod)

ui<-fluidPage(
    titlePanel("Mercados con R"),
    sidebarLayout(
        sidebarPanel("Seleccione la acción que desea consultar",
                     selectInput('accion', 
                                 label = 'Acción', 
                                 choices = c("Apple"="AAPL", "Cisco"="CSCO",
                                             "IBM"="IBM", "Facebook"="FB",
                                             "Twitter"="TWTR", "Microsoft"="MSFT",
                                             "Google"="GOOG"))),
        mainPanel("Gráfico de Acciones del Mercado de Valores Americano",
                  h1('Gráficos de Precios'),
                  p('A continuación se muestra la gráfica del precio de la acción seleccionada.'),
                  plotOutput('grafico'))
    )
)

server<-function(input, output) {
    output$grafico <- renderPlot({
        stockdata <- getSymbols(input$accion, src="yahoo", from = "2019-01-01",
                                to = "2019-12-23", auto.assign = FALSE)
        candleChart(stockdata, name=input$accion)
    })
}

shinyApp(ui=ui, server=server)