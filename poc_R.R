install.packages('corrplot')
library(corrplot)
install.packages('tidyverse')
library(tidyverse)
install.packages('ggpubr')
library(ggpubr)

#Open CSV
data <- read.csv('data/prices.csv')
head(data)

#Matrice Corrélation
mcor <- cor(data)
corrplot(mcor, tl.col="black")

#Visualisation du prix par rapport à la surface 
ggplot(data, aes(x = squareMeters, y = price)) +
  geom_point() +
  stat_smooth()

#Formation du modèle
model <- lm(price ~ squareMeters, data=data)
model


#Evaluation du modèle
summary(model)
error <- sigma(model)*100/mean(data$price)
cat("Le pourcentage d'erreur du modèle est de",error,"%")

#Enregistrement du modèle
save(model, file="model.Rdata")
