library(dplyr)

dados$Date <- as.Date(dados$Date)

queda_neve_por_dia <- dados %>%
  group_by(Date) %>%
  summarize(total_neve = sum(Snowfall, na.rm = TRUE))

dias_com_neve <- sum(queda_neve_por_dia$total_neve > 0)

dias_com_neve
