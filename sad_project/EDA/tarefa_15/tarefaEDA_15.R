library(dplyr)

dados$Date <- as.Date(dados$Date)

precipitacao_diaria <- dados %>%
  group_by(Date) %>%
  summarize(
    Precipitacao_Total = sum(Precipitation, na.rm = TRUE),
    Queda_Neve_Total = sum(Snowfall, na.rm = TRUE)
  )

head(precipitacao_diaria)
library(ggplot2)
library(tidyr)  # para pivot_longer

# Transformar para formato longo para facilitar o gráfico
precipitacao_long <- precipitacao_diaria %>%
  pivot_longer(cols = c("Precipitacao_Total", "Queda_Neve_Total"),
               names_to = "Tipo",
               values_to = "Valor")

# Ajustar nomes para legenda
precipitacao_long$Tipo <- factor(precipitacao_long$Tipo,
                                 levels = c("Precipitacao_Total", "Queda_Neve_Total"),
                                 labels = c("Precipitação Total", "Queda de Neve Total"))

# Gráfico de linhas
ggplot(precipitacao_long, aes(x = Date, y = Valor, color = Tipo)) +
  geom_line() +
  labs(title = "Precipitação e Queda de Neve Total Diária",
       x = "Data",
       y = "Quantidade (mm)",
       color = "Tipo") +
  theme_minimal() +
  scale_color_manual(values = c("Precipitação Total" = "#c41f61", "Queda de Neve Total" = "#1f8bc4"))

