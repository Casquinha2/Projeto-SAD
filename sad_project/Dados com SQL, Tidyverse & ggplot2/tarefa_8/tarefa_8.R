resumo_tarefa8 <- raw_seoul_bike_sharing %>%
  filter(!is.na(Season)) %>%
  group_by(Season) %>%
  summarise(
    media_alugueres = mean(bikes_rented, na.rm = TRUE),
    min_alugueres   = min(bikes_rented, na.rm = TRUE),
    max_alugueres   = max(bikes_rented, na.rm = TRUE),
    sd_alugueres    = sd(bikes_rented, na.rm = TRUE),
    .groups = "drop"
  )

  print(resumo_tarefa8)


