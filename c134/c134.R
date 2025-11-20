library(readr)
library(ggplot2)
library(dplyr)

mono <- read.csv2("mono.csv") 
poli <- read.csv2("poli.csv") 
amo  <- read.csv2("amo.csv")  

# MONOKRYSTALICZNY
maxP_row <- mono[which.max(mono$P), ]

mpp_j <- maxP_row$j
mpp_Un <- maxP_row$Un
mpp_P <- maxP_row$P 

punkt_mpp <- data.frame(
  punkt = "MPP",
  j_coord = mpp_j,
  Un_coord = mpp_Un,
  P_val = mpp_P
)

ggplot(mono, aes(x = j, y = Un)) +
  geom_point() +
  geom_smooth() +
  labs(
    title = "I/S = f(U/n) ogniwo monokrystaliczne",
    x = expression(j = I/S ~ (A/m^2)),
    y = "U/n"
  ) +
  geom_point(
    data = punkt_mpp,
    aes(x = j_coord, y = Un_coord),
    color = "green"

  )

# POLIKRYSTALICZNY
maxP_row <- poli[which.max(poli$P), ]

mpp_j <- maxP_row$j
mpp_Un <- maxP_row$Un
mpp_P <- maxP_row$P 

punkt_mpp <- data.frame(
  punkt = "MPP",
  j_coord = mpp_j,
  Un_coord = mpp_Un,
  P_val = mpp_P
)

ggplot(poli, aes(x = j, y = Un)) +
  geom_point() +
  geom_smooth(color = "red") +
  labs(
    title = "I/S = f(U/n) ogniwo polikrystaliczne",
    x = expression(j = I/S ~ (A/m^2)),
    y = "U/n [V]"
  ) +
  geom_point(
    data = punkt_mpp,
    aes(x = j_coord, y = Un_coord),
    color = "green"
    
  )

# AMORFICZNY
maxP_row <- amo[which.max(amo$P), ]

mpp_j <- maxP_row$j
mpp_Un <- maxP_row$Un
mpp_P <- maxP_row$P 

punkt_mpp <- data.frame(
  punkt = "MPP",
  j_coord = mpp_j,
  Un_coord = mpp_Un,
  P_val = mpp_P
)

ggplot(amo, aes(x = j, y = Un)) +
  geom_point() +
  geom_smooth(color = "darkgreen") +
  labs(
    title = "I/S = f(U/n) ogniwo amorficzne",
    x = expression(j = I/S ~ (A/m^2)),
    y = "U/n [V]"
  )+
  geom_point(
    data = punkt_mpp,
    aes(x = j_coord, y = Un_coord),
    color = "green"
    
  )

library(dplyr)

dane <- bind_rows(
  mono %>% mutate(Typ = "Monokrystaliczne"),
  poli %>% mutate(Typ = "Polikrystaliczne"),
  amo  %>% mutate(Typ = "Amorficzne")
)


ggplot(dane, aes(x = j, y = Un, color = Typ)) +
  geom_point(alpha = 0.6, color = "black") +
  geom_smooth(se = TRUE, linewidth = 1.2) +
  scale_color_manual(
    name = "Rodzaj Ogniwa",
    values = c(
      "Monokrystaliczne" = "blue",      # Monokrystaliczne na niebiesko
      "Polikrystaliczne" = "red",         # Polikrystaliczne na czerwono
      "Amorficzne" = "darkgreen"        # Amorficzne na ciemnozielono
    )) +
  labs(
    title = "Porównanie charakterystyk I/S = f(U/n) ró¿nych typów ogniw",
    x = expression(j == I/S ~ (A/m^2)),
    y = "U/n [V]",
    color = "Rodzaj Ogniwa"
  ) 

