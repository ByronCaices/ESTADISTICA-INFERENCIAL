library(tidyverse)
library(RVAideMemoire)
library(rcompanion)

datosCSV <- read_csv2("EP04 Datos.csv")

set.seed(102)

alfa <- 0.05

personas <- 1:50
muestra <- datosCSV[sample(nrow(datosCSV), 50), ]
estrategia1 <- muestra$estrategia_1
estrategia2 <- muestra$estrategia_2
estrategia3 <- muestra$estrategia_3

datos <- data.frame(personas, estrategia1, estrategia2, estrategia3)

datos <- datos %>% pivot_longer(c("estrategia1", "estrategia2", "estrategia3"),
                                names_to = "estrategias",
                                values_to = "resultado")

datos[["personas"]] <- factor(datos[["personas"]])
datos[["estrategias"]] <- factor(datos[["estrategias"]])

prueba <- cochran.qtest(resultado ~ estrategias | personas,
                        data = datos, alpha = alfa)

print(prueba)

post_hoc <- pairwiseMcnemar(resultado ~ estrategias | personas,
                            data = datos, method = "holm")

print(post_hoc)