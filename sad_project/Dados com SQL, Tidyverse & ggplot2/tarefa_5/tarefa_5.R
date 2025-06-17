
raw_seoul_bike_sharing$date <- as.Date(raw_seoul_bike_sharing$date_time)

data_minima <- min(raw_seoul_bike_sharing$date, na.rm = TRUE)
data_maxima <- max(raw_seoul_bike_sharing$date, na.rm = TRUE)

resultado_texto <- paste0("Primeira data: ", data_minima, "\nÚltima data: ", data_maxima, "\n")

cat(resultado_texto)

