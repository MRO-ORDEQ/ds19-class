# first attempt at reviewing hermiston data

library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)

# monitoring data from DEQ's website

hermiston_ozone <- read.csv("data/Hermiston_Municipal_Airport_stationReport4_5_2019.csv")

summary(hermiston_ozone)
tail(hermiston_ozone)

colnames(hermiston_ozone)
head(hermiston_ozone)

# slice observations that occured when monitor was off

hermiston_ozone_2 <- slice(hermiston_ozone, 2800:6660)

hermiston_ozone_2 <- hermiston_ozone_2 %>% c(x = "date", x.1 = "wind_dir", x.2 = "wind_spd", 
                                             x.3 = "ozone_spd", x.4 = "ozone_ppb")

tail(hermiston_ozone_2)



