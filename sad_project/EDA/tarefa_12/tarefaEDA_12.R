library(ggplot2)

ggplot(dados, aes(x = as.numeric(Bike_Rentals))) +   # garantir numérico
  geom_histogram(aes(y = after_stat(density)), binwidth = 5,
                 fill = "pink", alpha = 0.5, color = "pink") +
  geom_density(color = "lightblue", linewidth = 1) +
  labs(title = "Histograma com Curva de Densidade Kernel de Bike Rentals",
       x = "Número de Bicicletas Alugadas",
       y = "Densidade") +
  theme_minimal()
