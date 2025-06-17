library(readxl)
library(dplyr)
library(Metrics)
library(writexl)

set.seed(123)

dados <- read_excel("C:/Users/sense/Desktop/sad_project/EDA/tarefa_3/tarefa_3.xlsx")

dados <- dados %>%
  mutate(ID = row_number())

dados_treino <- dados %>%
  group_by(Season) %>%
  sample_frac(0.8)

dados_teste <- anti_join(dados, dados_treino, by = "ID")

dados_treino <- dados_treino %>% ungroup() %>% select(-ID)
dados_teste <- dados_teste %>% ungroup() %>% select(-ID)

dados_treino <- dados_treino %>%
  mutate(
    Bike_Rentals = as.numeric(Bike_Rentals),
    Temperature = as.numeric(Temperature),
    Humidity = as.numeric(Humidity),
    Wind_Speed = as.numeric(Wind_Speed),
    Precipitation = as.numeric(Precipitation),
    Snowfall = as.numeric(Snowfall),
    Hour = factor(Hour, levels = 0:23, ordered = TRUE),
    Season = factor(Season),
    Holiday = factor(Holiday),
    Functioning_Day = factor(Functioning_Day)
  )

dados_teste <- dados_teste %>%
  mutate(
    Bike_Rentals = as.numeric(Bike_Rentals),
    Temperature = as.numeric(Temperature),
    Humidity = as.numeric(Humidity),
    Wind_Speed = as.numeric(Wind_Speed),
    Precipitation = as.numeric(Precipitation),
    Snowfall = as.numeric(Snowfall),
    Hour = factor(Hour, levels = 0:23, ordered = TRUE),
    Season = factor(Season),
    Holiday = factor(Holiday),
    Functioning_Day = factor(Functioning_Day)
  )

modelo_meteorologico <- lm(Bike_Rentals ~ Temperature + Humidity + Wind_Speed + Precipitation + Snowfall,
                           data = dados_treino)

modelo_tempo <- lm(Bike_Rentals ~ Hour + Season + Holiday + Functioning_Day, data = dados_treino)

pred_meteorologico <- predict(modelo_meteorologico, newdata = dados_teste)
pred_tempo <- predict(modelo_tempo, newdata = dados_teste)

rmse_meteorologico <- rmse(dados_teste$Bike_Rentals, pred_meteorologico)
rmse_tempo <- rmse(dados_teste$Bike_Rentals, pred_tempo)

cat("RMSE Modelo Meteorológico:", rmse_meteorologico, "\n")
cat("RMSE Modelo Tempo/Data:", rmse_tempo, "\n")

resultados <- dados_teste %>%
  select(Bike_Rentals, Temperature, Humidity, Wind_Speed, Precipitation, Snowfall,
         Hour, Season, Holiday, Functioning_Day) %>%
  mutate(Pred_Meteorologico = pred_meteorologico,
         Pred_Tempo = pred_tempo)

#GRAFICO 1

library(ggplot2)

ggplot(resultados, aes(x = Bike_Rentals)) +
  geom_point(aes(y = Pred_Meteorologico, color = "Modelo Meteorológico"), alpha = 0.6) +
  geom_point(aes(y = Pred_Tempo, color = "Modelo Tempo/Data"), alpha = 0.6) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black") +
  labs(title = "Comparação: Valores Reais vs. Preditos",
       x = "Bike Rentals (Reais)",
       y = "Bike Rentals (Preditos)",
       color = "Modelo") +
  theme_minimal()

resultados$Index <- 1:nrow(resultados)

amostra <- resultados[1:200, ]

ggplot(amostra, aes(x = Index)) +
  geom_line(aes(y = Bike_Rentals, color = "Real"), linewidth = 1) +
  geom_line(aes(y = Pred_Meteorologico, color = "Meteorológico"), linetype = "dotted") +
  geom_line(aes(y = Pred_Tempo, color = "Tempo/Data"), linetype = "dashed") +
  labs(title = "Comparação temporal das predições (amostra)",
       x = "Observações",
       y = "Bike Rentals",
       color = "Série") +
  theme_minimal()

#GRAFICO 2

library(ggplot2)

# 1. Bike Rentals vs. Temperature
ggplot(dados_treino, aes(x = Temperature, y = Bike_Rentals)) +
  geom_point(alpha = 0.4, color = "red") +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(title = "Regressão Linear: Bike Rentals vs Temperature",
       x = "Temperatura (°C)", y = "Bicicletas Alugadas") +
  theme_minimal()

#GRAFICO 3

library(ggplot2)

# 2. Bike Rentals vs. Humidity
ggplot(dados_treino, aes(x = Humidity, y = Bike_Rentals)) +
  geom_point(alpha = 0.4, color = "blue") +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(title = "Regressão Linear: Bike Rentals vs Humidity",
       x = "Humidade (%)", y = "Bicicletas Alugadas") +
  theme_minimal()

#GRAFICO 4

library(ggplot2)

# 3. Bike Rentals vs. Wind Speed
ggplot(dados_treino, aes(x = Wind_Speed, y = Bike_Rentals)) +
  geom_point(alpha = 0.4, color = "yellow") +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(title = "Regressão Linear: Bike Rentals vs Wind Speed",
       x = "Velocidade do Vento (m/s)", y = "Bicicletas Alugadas") +
  theme_minimal()

