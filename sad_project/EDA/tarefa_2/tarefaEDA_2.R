library(readxl)
library(writexl)  

dados <- read_excel("tarefa_1.xlsx")


dados$Date <- format(as.Date(dados$Date), "%d/%m/%Y")


write_xlsx(dados, "tarefa_2.xlsx")
