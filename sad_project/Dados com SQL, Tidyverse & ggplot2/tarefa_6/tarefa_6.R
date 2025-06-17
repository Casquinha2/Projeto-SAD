max_index <- which.max(raw_seoul_bike_sharing_5dias$bikes_rented)
max_data_hora <- raw_seoul_bike_sharing_5dias$date_time[max_index]
max_alugueres <- raw_seoul_bike_sharing_5dias$bikes_rented[max_index]

resultado_tarefa6 <- paste0(
  "Tarefa 6 - Máximo histórico de alugueres\n",
  "Data e hora: ", max_data_hora, "\n",
  "Número de bicicletas alugadas: ", max_alugueres, "\n"
)
cat(resultado_tarefa6)

