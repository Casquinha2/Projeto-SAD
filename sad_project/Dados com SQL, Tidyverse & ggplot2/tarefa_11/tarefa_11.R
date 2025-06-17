
library(dplyr)

cidades_escalas_semelhantes <- bike_systems %>%
  filter(total_bikes >= 15000 & total_bikes <= 20000)

resultado_tarefa11 <- cidades_escalas_semelhantes %>%
  left_join(world_cities, by = c("city_region" = "city")) %>%
  select(city_region, country, lat, lng, population, total_bikes)

print(head(resultado_tarefa11))

