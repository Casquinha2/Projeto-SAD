library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)
library(readxl)

dados_completos <- read_excel("C:/Users/sense/Desktop/sad_project/Previsão_da_partilha_de_bicicletas/modelo_de_regressao.xlsx")

# Modelo de regressão
modelo_regressao <- lm(Bike_Rentals ~ Temperature + Humidity + Wind_Speed + Precipitation + Snowfall,
                       data = dados_completos)

# Cidades
cidades <- data.frame(
  nome = c("Nova York", "Paris", "Suzhou", "Londres"),
  lat = c(40.7128, 48.8566, 31.2989, 51.5074),
  lon = c(-74.0060, 2.3522, 120.5853, -0.1278)
)

obter_previsao <- function(lat, lon) {
  set.seed(round(lat + lon))
  dias <- 1:5
  horas <- 0:23
  
  expand.grid(dia = dias, hora = horas) %>%
    mutate(
      Temperature = runif(n(), min = 10, max = 30),
      Humidity = runif(n(), min = 40, max = 90),
      Wind_Speed = runif(n(), min = 0, max = 30),
      Precipitation = runif(n(), min = 0, max = 10),
      Snowfall = runif(n(), min = 0, max = 5)
    ) %>%
    mutate(bikes_previstas = predict(modelo_regressao, newdata = .))
}

# ========== UI ==========
ui <- fluidPage(
  titlePanel("Previsão de Bicicletas por Cidade"),
  leafletOutput("mapa"),
  br(),
  textOutput("mensagem_inicial"),
  conditionalPanel(
    condition = "output.cidadeSelecionada != null",
    sliderInput("dia", "Seleciona o dia:", min = 1, max = 5, value = 1, step = 1)
  ),
  verbatimTextOutput("info"),
  plotOutput("grafico")
)

# ========== SERVER ==========
server <- function(input, output, session) {
  dados_reactivos <- reactiveVal(NULL)
  cidade_selecionada <- reactiveVal(NULL)
  
  output$mapa <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(
        data = cidades,
        lng = ~lon,
        lat = ~lat,
        label = ~nome,
        layerId = ~nome
      )
  })
  
  output$mensagem_inicial <- renderText({
    if (is.null(cidade_selecionada())) {
      "Clique numa cidade para ver a previsão"
    } else {
      ""
    }
  })
  
  observeEvent(input$mapa_marker_click, {
    cidade <- input$mapa_marker_click$id
    coords <- cidades %>% filter(nome == cidade)
    previsao <- obter_previsao(coords$lat, coords$lon)
    
    dados_reactivos(previsao)
    cidade_selecionada(cidade)
    
    output$info <- renderPrint({
      paste("Previsão de aluguer de bicicletas para:", cidade)
    })
  })
  
  output$cidadeSelecionada <- reactive({
    cidade_selecionada()
  })
  outputOptions(output, "cidadeSelecionada", suspendWhenHidden = FALSE)
  
  output$grafico <- renderPlot({
    req(dados_reactivos(), input$dia)
    df <- dados_reactivos()
    df_dia <- df %>% filter(dia == input$dia)
    
    ggplot(df_dia, aes(x = hora, y = bikes_previstas)) +
      geom_line(color = "pink", size = 1) +
      geom_point(color = "purple") +
      labs(
        title = paste("Previsão de Bicicletas - Dia", input$dia),
        x = "Hora",
        y = "Bicicletas Previstas"
      ) +
      theme_minimal()
  })
}

shinyApp(ui, server)
