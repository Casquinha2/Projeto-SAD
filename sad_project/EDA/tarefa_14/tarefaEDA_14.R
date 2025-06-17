library(ggplot2)

dados$Season <- gsub('\"', '', dados$Season)
dados$Season <- tools::toTitleCase(tolower(dados$Season))

dados$Hour <- factor(dados$Hour, levels = 0:23, ordered = TRUE)

dados$Bike_Rentals <- as.numeric(dados$Bike_Rentals)

ggplot(dados, aes(x = Hour, y = Bike_Rentals)) +
  geom_boxplot(fill = "pink", alpha = 0.7, outlier.size = 0.5) +
  facet_wrap(~Season, ncol = 2) +
  labs(title = "Distribuição de Bicicletas Alugadas por Hora e Estação",
       x = "Hora do Dia",
       y = "Número de Bicicletas Alugadas") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
