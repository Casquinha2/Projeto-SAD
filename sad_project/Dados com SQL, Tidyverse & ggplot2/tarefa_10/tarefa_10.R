
seoul_cidade <- world_cities %>% filter(tolower(city) == "seoul")
seoul_bikes <- bike_systems %>% filter(grepl("seoul", tolower(city_region)))

resultado_tarefa10 <- paste0(
  "Tarefa 10 - Contagem total de bicicletas e informações sobre a cidade de Seul\n\n",
  "Cidade: ", seoul_cidade$city, "\n",
  "País: ", seoul_cidade$country, "\n",
  "Latitude: ", seoul_cidade$lat, "\n",
  "Longitude: ", seoul_cidade$lng, "\n",
  "População: ", seoul_cidade$population, "\n",
  "Sistema de bicicletas: ", seoul_bikes$name, "\n",
  "Número total de bicicletas disponíveis: ", seoul_bikes$total_bikes, "\n"
)

print(resultado_tarefa10)