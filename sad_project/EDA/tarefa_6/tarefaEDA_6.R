dados$Holiday <- gsub('\"', '', dados$Holiday)

num_feriados <- sum(dados$Holiday == "Feriado")

total_registos <- nrow(dados)

percentagem_feriados <- (num_feriados / total_registos) * 100

print(round(percentagem_feriados, 2))
library(ggplot2)

dados$Holiday <- gsub('\"', '', dados$Holiday)

df_feriados <- as.data.frame(table(dados$Holiday))
colnames(df_feriados) <- c("Tipo", "Contagem")

df_feriados$Percentagem <- round(df_feriados$Contagem / sum(df_feriados$Contagem) * 100, 2)

df_feriados$Label <- paste0(df_feriados$Tipo, ": ", df_feriados$Percentagem, "%")

ggplot(df_feriados, aes(x = "", y = Contagem, fill = Tipo)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y") +
  theme_void() +
  labs(title = "Distribuição de Registos: Feriado vs. Sem Feriado") +
  geom_text(aes(label = Label), 
            position = position_stack(vjust = 0.5),
            color = "white", size = 5) +
  scale_fill_manual(values = c("Feriado" = "pink", "Sem feriado" = "lightblue"))
