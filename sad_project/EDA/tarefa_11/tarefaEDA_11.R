library(ggplot2)

dados$Date <- as.Date(dados$Date)

dados$Hour <- factor(dados$Hour, levels = 0:23, ordered = TRUE)

ggplot(dados, aes(x = Date, y = Bike_Rentals, color = Hour)) +
  geom_point(alpha = 0.6) +
  labs(title = "Número de Bicicletas Alugadas ao Longo do Tempo por Hora",
       x = "Data",
       y = "Número de Bicicletas Alugadas",
       color = "Hora do Dia") +
  theme_minimal() +
  scale_color_viridis_d()
