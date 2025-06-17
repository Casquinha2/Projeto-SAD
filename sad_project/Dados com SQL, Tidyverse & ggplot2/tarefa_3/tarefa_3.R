
forecast_path <- "C:/Users/sense/Desktop/SAD_project/dados_brutos/raw_cities_weather_forecast.csv"


forecast_data <- read.csv(forecast_path)

seoul_forecast <- forecast_data %>%
  filter(city == "Seoul") %>%
  arrange(dt_txt) %>%
  slice(1)

print(seoul_forecast)

