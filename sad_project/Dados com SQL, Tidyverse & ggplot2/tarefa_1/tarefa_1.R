
file_path <- "C:/Users/sense/Desktop/SAD_project/dados_brutos/raw_seoul_bike_sharing.csv"

seoul_data <- read.csv(file_path)

num_registos <- nrow(seoul_data)

print(paste("Número de registos no seoul_bike_sharing:", num_registos))
