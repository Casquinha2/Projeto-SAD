library(dplyr)


resumo_tarefa9 <- raw_seoul_bike_sharing %>%
  group_by(Season) %>%
  summarise(
    temperatura_media    = mean(temperature, na.rm = TRUE),
    humidade_media       = mean(humidity, na.rm = TRUE),
    vento_medio          = mean(wind_speed, na.rm = TRUE),
    visibilidade_media   = mean(visibility, na.rm = TRUE),
    ponto_orvalho_medio  = mean(dew_point, na.rm = TRUE),
    radiacao_solar_media = mean(solar_radiation, na.rm = TRUE),
    precipitacao_media   = mean(precipitation, na.rm = TRUE),
    neve_media           = mean(snowfall, na.rm = TRUE),
    alugueres_medios     = mean(bikes_rented, na.rm = TRUE)
  ) %>%
  arrange(desc(alugueres_medios))  


  print(resumo_tarefa9)
})

