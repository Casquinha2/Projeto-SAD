library(ggplot2)

dados$Date <- as.Date(dados$Date)

ggplot(dados, aes(x = Date, y = Bike_Rentals)) +
  geom_point(alpha = 0.5, color = "#c41f61") +
  labs(title = "Número de Bicicletas Alugadas ao Longo do Tempo",
       x = "Data",
       y = "Número de Bicicletas Alugadas") +
  theme_minimal()
