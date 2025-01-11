# Se importan las librerías a utilizar.

library(ggplot2)
library(ggpubr)
library(dplyr)
library(purrr)

# Se leen los datos del archivo .csv, y se genera un dataframe de nombre "datos".

datos <- read.csv2("EP01 Datos Casen 2017.csv")

# La pregunta planteada en base a los datos es la siguiente:
# ¿Se encuestaron más o menos la misma cantidad de gente en cada provincia de la RM?

# Para ello, será necesario obtener la cantidad de encuestados por cada provincia —lo que se 
# corresponde con la medida estadística de la frecuencia de los datos— por lo que se trabajará
# con la variable categórica "provincia", de tipo nominal.

# Primero, se obtienen las provincias de la RM del dataframe anterior, y se almacenan en un vector.

provincias_RM <- levels(as.factor(datos[["provincia"]]))

# Luego, se utiliza dicho vector para obtener las frecuencias por provincia...

prov1 <- nrow(datos %>% filter(provincia == provincias_RM[1]))
prov2 <- nrow(datos %>% filter(provincia == provincias_RM[2]))
prov3 <- nrow(datos %>% filter(provincia == provincias_RM[3]))
prov4 <- nrow(datos %>% filter(provincia == provincias_RM[4]))
prov5 <- nrow(datos %>% filter(provincia == provincias_RM[5]))
prov6 <- nrow(datos %>% filter(provincia == provincias_RM[6]))

#  ... y se muestran por pantalla.

paste("Frecuencia en", provincias_RM[1], ":", prov1)
paste("Frecuencia en", provincias_RM[2], ":", prov2)
paste("Frecuencia en", provincias_RM[3], ":", prov3)
paste("Frecuencia en", provincias_RM[4], ":", prov4)
paste("Frecuencia en", provincias_RM[5], ":", prov5)
paste("Frecuencia en", provincias_RM[6], ":", prov6)

# Por último, se genera un gráfico de barras de la frecuencia de encuestados por provincia... 

f_provincias <- as.data.frame(xtabs(~ provincia, data=datos))

grafico <- ggbarplot(f_provincias, 
               x="provincia",
               y="Freq",
               fill="provincia",
               title="Frecuencia de población provincial",
               xlab="Provincias",
               ylab="Frecuencia")

# ... y se muestra dicho gráfico.
print(grafico)

# En base a lo presentado, se puede concluir que NO se encuestó a la misma cantidad de personas
# en todas las provincias, lo cuál se ve reforzado por la medida estadística y la gráfica antes 
# mencionadas, donde Santiago cuenta con la mayor cantidad de encuestados.