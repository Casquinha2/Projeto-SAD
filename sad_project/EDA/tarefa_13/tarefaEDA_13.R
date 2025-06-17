library(ggplot2)
library(dplyr)

dados$Season <- gsub('\"', '', dados$Season)
dados$Season <- tools::toTitleCase(tolower(dados$Season))

dados$Hour <- factor(dados$Hour, levels = 0:23, ordered = TRUE)

dados$Temperature <- as.numeric(dados$Temperature)
dados$Bike_Rentals <- as.numeric(dados$Bike_Rentals)


ggplot(dados, aes(x = Temperature, y = Bike_Rentals, color = Hour)) +
  geom_point(alpha = 0.6) +
  facet_wrap(~Season) +
  labs(title = "Correlação entre Número de Bicicletas Alugadas e Temperatura por Estação",
       x = "Temperatura (°C)",
       y = "Número de Bicicletas Alugadas",
       color = "Hora do Dia") +
  theme_minimal() +
  scale_color_viridis_d()
