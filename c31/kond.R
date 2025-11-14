library(readr)
library(ggplot2)
library(reshape2)
library(viridis)

macierz <- read_csv2("dane.csv", col_names = FALSE)

# Wymiary macierzy
nrows <- nrow(macierz)
ncols <- ncol(macierz)

# X i Y zmieniajace sie w skali
x_vals <- seq(0, by = 0.02, length.out = ncols)  
y_vals <- seq(0, by = 0.01, length.out = nrows)

# Nazwy kolumn
colnames(macierz) <- x_vals
macierz$y <- y_vals

# Zmiana na format (x,y,V)
dane_long <- melt(macierz, id.vars = "y", variable.name = "x", value.name = "V")
dane_long$x <- as.numeric(as.character(dane_long$x))

# Wykres linii ekwipotencjalnych
ggplot(dane_long, aes(x, y, z = V)) +
  geom_contour_filled(bins = 20) +
  scale_fill_viridis_d(option = "plasma") +
  labs(title = "Linie ekwipotencjalne kondensatora płaskiego",
       x = "x [m]", y = "y [m]", fill = "Potencjał [V]") +
  theme_minimal(base_size = 14)

# CYLINDRYCZNY
library(tidyr)
library(akima)
library(dplyr)

dane <- read_csv2("cylind.csv")
dane_long <- dane %>%
  pivot_longer(cols = c("a", "b", "c"),
               names_to = "os",
               values_to = "V") %>%
  mutate(V = as.numeric(V))

# Zamiana osi na numeryczne dla interpolacji
# a -> 1, b -> 2, c -> 3
dane_long <- dane_long %>%
  mutate(os_num = case_when(
    os == "a" ~ 1,
    os == "b" ~ 2,
    os == "c" ~ 3
  ))

# Interpolacja na prostokątną siatkę
interp_data <- with(dane_long, akima::interp(x = x, y = os_num, z = V, duplicate = "mean"))

df_interp <- data.frame(
  x = rep(interp_data$x, times = length(interp_data$y)),
  os_num = rep(interp_data$y, each = length(interp_data$x)),
  V = as.vector(interp_data$z)
)

# Wykres konturowy
ggplot(df_interp, aes(x = x, y = os_num, z = V)) +
  geom_contour_filled(bins = 20) +
  scale_y_continuous(breaks = c(1,2,3), labels = c("a","b","c")) +
  scale_fill_viridis_d(option = "plasma") +
  labs(title = "Linie ekwipotencjalne kondensatora cylindrycznego",
       x = "Odległość od środka [m]",
       y = "Oś pomiarowa",
       fill = "Potencjał [V]") +
  theme_minimal(base_size = 14)

