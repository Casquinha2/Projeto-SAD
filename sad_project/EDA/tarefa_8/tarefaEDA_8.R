dados$Functioning_Day <- gsub('\"', '', dados$Functioning_Day)

# Contar os registos em que o sistema estava a funcionar
registos_funcionamento <- sum(dados$Functioning_Day == "Diversão")

print(registos_funcionamento)
library(ggplot2)

dados$Functioning_Day <- gsub('\"', '', dados$Functioning_Day)

df_funcionamento <- as.data.frame(table(dados$Functioning_Day))
colnames(df_funcionamento) <- c("Estado", "Contagem")

ggplot(df_funcionamento, aes(x = Estado, y = Contagem, fill = Estado)) +
  geom_bar(stat = "identity") +
  labs(title = "Registos por Estado de Funcionamento do Sistema",
       x = "Estado do Dia",
       y = "Número de Registos") +
  scale_fill_manual(values = c("Diversão" = "pink", "NoFunc" = "lightblue")) +
  theme_minimal()
