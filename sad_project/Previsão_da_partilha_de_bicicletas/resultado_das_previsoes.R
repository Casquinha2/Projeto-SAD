library(glmnet)
library(dplyr)
library(writexl)

dados_treino <- dados_treino
dados_teste <- dados_teste

# ========== MODELOS REFINADOS ==========

modelo_poly <- lm(Bike_Rentals ~ poly(Temperature, 2) + Humidity + Wind_Speed + 
                    Precipitation + Snowfall, data = dados_treino)

modelo_interacao <- lm(Bike_Rentals ~ Temperature * Humidity + Wind_Speed + 
                         Precipitation + Snowfall, data = dados_treino)

x_treino <- model.matrix(Bike_Rentals ~ Temperature + Humidity + Wind_Speed + 
                           Precipitation + Snowfall + Hour + Season + Holiday + Functioning_Day,
                         data = dados_treino)[, -1]
y_treino <- dados_treino$Bike_Rentals

x_teste <- model.matrix(Bike_Rentals ~ Temperature + Humidity + Wind_Speed + 
                          Precipitation + Snowfall + Hour + Season + Holiday + Functioning_Day,
                        data = dados_teste)[, -1]

# Ridge
modelo_ridge <- cv.glmnet(x_treino, y_treino, alpha = 0)
pred_ridge <- predict(modelo_ridge, newx = x_teste, s = "lambda.min")

# Lasso
modelo_lasso <- cv.glmnet(x_treino, y_treino, alpha = 1)
pred_lasso <- predict(modelo_lasso, newx = x_teste, s = "lambda.min")

# ========== PREDIÇÕES ==========

pred_poly <- predict(modelo_poly, newdata = dados_teste)
pred_interacao <- predict(modelo_interacao, newdata = dados_teste)

# ========== RESULTADOS ==========

rmse <- function(actual, predicted) {
  sqrt(mean((actual - predicted)^2))
}

rmse_poly <- rmse(dados_teste$Bike_Rentals, pred_poly)
rmse_interacao <- rmse(dados_teste$Bike_Rentals, pred_interacao)
rmse_ridge <- rmse(dados_teste$Bike_Rentals, pred_ridge)
rmse_lasso <- rmse(dados_teste$Bike_Rentals, pred_lasso)

rmse_resultados <- data.frame(
  Modelo = c("Polinomial", "Interação", "Ridge", "Lasso"),
  RMSE = c(rmse_poly, rmse_interacao, rmse_ridge, rmse_lasso)
)

tabela_predicoes <- dados_teste %>%
  select(Bike_Rentals) %>%
  mutate(Pred_Polinomial = as.numeric(pred_poly),
         Pred_Interacao = as.numeric(pred_interacao),
         Pred_Ridge = as.numeric(pred_ridge),
         Pred_Lasso = as.numeric(pred_lasso))
