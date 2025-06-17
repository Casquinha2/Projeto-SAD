
seoul_data$hour_only <- substr(seoul_data$date_time, 1, 13) 


horas_com_alugueres <- seoul_data %>% 
  filter(bikes_rented > 0) %>% 
  distinct(hour_only)


num_horas_funcionamento <- nrow(horas_com_alugueres)

print(paste("Número de horas com alugueres > 0:", num_horas_funcionamento))
