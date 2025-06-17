
raw_seoul_bike_sharing <- read.csv("C:/Users/sense/Desktop/sad_project/dados_brutos/raw_seoul_bike_sharing.csv", stringsAsFactors = FALSE)

raw_seoul_bike_sharing$Season <- factor(raw_seoul_bike_sharing$Season,
                                        levels = c("winter", "spring", "summer", "fall"))

unique_seasons <- unique(raw_seoul_bike_sharing$Season)
print(unique_seasons)