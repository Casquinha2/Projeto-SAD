dados$Precipitation <- as.numeric(gsub(",", ".", dados$Precipitation))
dados$Snowfall <- as.numeric(gsub(",", ".", dados$Snowfall))
library(dplyr)

dados$Season <- gsub('\"', '', dados$Season)

dados_sazonais <- dados %>%
  group_by(Season) %>%
  summarise(
    Precipitacao_Total = sum(Precipitation, na.rm = TRUE),
    Neve_Total = sum(Snowfall, na.rm = TRUE)
  )

print(dados_sazonais)
library(ggplot2)
library(tidyr)  

dados_long <- dados_sazonais %>%
  pivot_longer(cols = c("Precipitacao_Total", "Neve_Total"),
               names_to = "Tipo",
               values_to = "Valor")


dados_long$Tipo <- factor(dados_long$Tipo,
                          levels = c("Precipitacao_Total", "Neve_Total"),
                          labels = c("Precipitação Total", "Queda de Neve Total"))

ggplot(dados_long, aes(x = Season, y = Valor, fill = Tipo)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  labs(title = "Precipitação e Queda de Neve Total por Estação",
       x = "Estação",
       y = "Quantidade (mm)",
       fill = "Tipo") +
  theme_minimal() +
  scale_fill_manual(values = c("Precipitação Total" = "pink", "Queda de Neve Total" = "lightblue"))
