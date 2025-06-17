dados$Holiday <- gsub('\"', '', dados$Holiday)

num_feriados <- sum(dados$Holiday == "Feriado")

print(num_feriados)
library(ggplot2)

dados$Holiday <- gsub('\"', '', dados$Holiday)

contagem_feriados <- table(dados$Holiday)

df_feriados <- as.data.frame(contagem_feriados)
colnames(df_feriados) <- c("Holiday", "Count")

ggplot(df_feriados, aes(x = Holiday, y = Count, fill = Holiday)) +
  geom_bar(stat = "identity") +
  labs(title = "Contagem de Dias com e sem Feriado",
       x = "Tipo de Dia",
       y = "Número de Dias") +
  theme_minimal() +
  scale_fill_manual(values = c("Feriado" = "pink", "Sem feriado" = "lightblue"))
