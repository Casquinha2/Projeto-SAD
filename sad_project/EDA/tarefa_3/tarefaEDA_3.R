library(readxl)
library(writexl)

dados <- read_excel("tarefa_2.xlsx")

dados$Hour <- factor(dados$Hour, levels = 0:23, ordered = TRUE)

str(dados$Hour)

write_xlsx(dados, "tarefa_3.xlsx")

library(readxl)
library(ggplot2)

dados <- read_excel("tarefa_3.xlsx")

dados$Hour <- factor(dados$Hour, levels = 0:23, ordered = TRUE)

ggplot(dados, aes(x = Hour, y = as.numeric(Bike_Rentals))) +
  stat_summary(fun = mean, geom = "bar", fill = "pink", color = "black") +
  labs(title = "Média de bicicletas alugadas por hora do dia",
       x = "Hora do dia",
       y = "Média de alugueres") +
  theme_minimal()
