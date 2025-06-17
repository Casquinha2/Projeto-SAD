library(readxl)

dados <- read_excel("tarefa_3.xlsx")

sink("tarefa_4_resumo.txt")

cat("Resumo do Conjunto de Dados - Tarefa 4\n")
cat("===============================\n\n")

cat("1. Estrutura do dataset:\n")
str(dados)
cat("\n\n")

cat("2. Estatísticas descritivas:\n")
print(summary(dados))
cat("\n\n")

cat("3. Valores únicos de variáveis categóricas:\n")
cat("Season:\n"); print(unique(dados$Season))
cat("Holiday:\n"); print(unique(dados$Holiday))
cat("Functioning Day:\n"); print(unique(dados$Functioning_Day))
cat("Hour:\n"); print(unique(dados$Hour))

sink()
