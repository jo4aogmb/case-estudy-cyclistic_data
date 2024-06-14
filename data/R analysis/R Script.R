# Instalar e carregar pacotes necessários
install.packages("tidyverse")
install.packages("lubridate")
library(readr)
library(dplyr)
library(lubridate)

# Definir o diretório de trabalho
setwd("/cloud/project")

#=====================
# STEP 1: COLETAR DADOS
#=====================
# Carregar os datasets (arquivos CSV)
q2_2019 <- read_csv("Divvy_Trips_2019_Q2.csv")
q4_2019 <- read_csv("Divvy_Trips_2019_Q4.csv")
q1_2020 <- read_csv("Divvy_Trips_2020_Q1.csv")

#====================================================
# STEP 2: LIMPAR OS DADOS E COMBINÁ-LOS EM UM ÚNICO ARQUIVO
#====================================================
# Comparar os nomes das colunas de cada arquivo
colnames(q2_2019)
colnames(q4_2019)
colnames(q1_2020)

# Renomear as colunas para torná-las consistentes com q1_2020
q4_2019 <- rename(q4_2019,
                  ride_id = trip_id,
                  rideable_type = bikeid,
                  started_at = start_time,
                  ended_at = end_time,
                  start_station_name = from_station_name,
                  start_station_id = from_station_id,
                  end_station_name = to_station_name,
                  end_station_id = to_station_id,
                  member_casual = usertype)

# Renomear as colunas para torná-las consistentes com q1_2020
q2_2019 <- rename(q2_2019,
                  ride_id = "01 - Rental Details Rental ID",
                  rideable_type = "01 - Rental Details Bike ID",
                  started_at = "01 - Rental Details Local Start Time",
                  ended_at = "01 - Rental Details Local End Time",
                  start_station_name = "03 - Rental Start Station Name",
                  start_station_id = "03 - Rental Start Station ID",
                  end_station_name = "02 - Rental End Station Name",
                  end_station_id = "02 - Rental End Station ID",
                  member_casual = "User Type")

# Visualizar a estrutura dos dados
str(q2_2019)
str(q4_2019)
str(q1_2020)

# Converter ride_id e rideable_type para character
q2_2019 <- mutate(q2_2019, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type))
q4_2019 <- mutate(q4_2019, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type))

# Juntar os data frames individuais em um único data frame
all_trips <- bind_rows(q2_2019, q4_2019, q1_2020)

# Remover algumas colunas
all_trips <- all_trips %>%
  select(-c(start_lat, start_lng, end_lat, end_lng, birthyear, gender, "01 - Rental Details Duration In Seconds Uncapped", "05 - Member Details Member Birthday Year", "Member Gender", "tripduration"))

#======================================================
# STEP 3: LIMPAR E ADICIONAR DADOS PARA ANÁLISE
#======================================================
# Adicionar colunas de data, mês, dia e ano
all_trips$date <- as.Date(all_trips$started_at) 
all_trips$month <- format(as.Date(all_trips$date), "%m")
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$year <- format(as.Date(all_trips$date), "%Y")
all_trips$day_of_week <- format(as.Date(all_trips$date), "%A")

# Adicionar um cálculo de "ride_length" para todo o data frame
all_trips$ride_length <- difftime(all_trips$ended_at, all_trips$started_at)

# Converter "ride_length" de Factor para numeric
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))

# Remover dados "ruins"
all_trips_v2 <- all_trips[!(all_trips$start_station_name == "HQ QR" | all_trips$ride_length < 0),]

#=====================================
# STEP 4: CONDUZIR ANÁLISE DESCRITIVA
#=====================================
# Análise descritiva do ride_length (todos os valores em segundos)
mean(all_trips_v2$ride_length) 
median(all_trips_v2$ride_length) 
max(all_trips_v2$ride_length) 
min(all_trips_v2$ride_length) 

# Comparar membros e usuários casuais
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)

# Verificar a duração média da viagem por dia para membros vs usuários casuais
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)

# Visualizar o número de viagens por tipo de usuário e dia da semana
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  
  group_by(member_casual, weekday) %>%  
  summarise(number_of_rides = n(),  
            average_duration = mean(ride_length)) %>%  
  arrange(member_casual, weekday) 

# Criar visualização para o número de viagens por tipo de usuário e dia da semana
all_trips_v2 %>%  
  mutate(weekday = wday(started_at, label = TRUE)) %>%  
  group_by(member_casual, weekday) %>%  
  summarise(number_of_rides = n(),  
            average_duration = mean(ride_length)) %>%  
  arrange(member_casual, weekday)  %>%  
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")

# Visualização para a duração média das viagens por tipo de usuário e dia da semana
all_trips_v2 %>%  
  mutate(weekday = wday(started_at, label = TRUE)) %>%  
  group_by(member_casual, weekday) %>%  
  summarise(number_of_rides = n(),  
            average_duration = mean(ride_length)) %>%  
  arrange(member_casual, weekday)  %>%  
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")

#=================================================
# STEP 5: EXPORTAR ARQUIVO DE RESUMO PARA ANÁLISE ADICIONAL
#=================================================
# Criar um arquivo CSV para visualização posterior
counts <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)
write.csv(counts, file = '/cloud/project/avg_ride_length.csv')

#Você terminou! Parabéns!
