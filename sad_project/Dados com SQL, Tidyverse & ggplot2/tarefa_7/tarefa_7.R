resumo_tarefa7 <- raw_seoul_bike_sharing_5dias %>%
  group_by(Season, Hour) %>%
  summarise(
    temperatura_media = mean(temperature, na.rm = TRUE),
    alugueres_medios = mean(bikes_rented, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(alugueres_medios)) %>%
  slice(1:10)

print(resumo_tarefa7)

