install.packages('corrplot')
library(corrplot)
install.packages('tidyverse')
library(tidyverse)
install.packages('ggpubr')
library(ggpubr)

#Open CSV
data <- read.csv('data/prices.csv')
head(data)

#Matrice Corr�lation
mcor <- cor(data)
corrplot(mcor, tl.col="black")

#Visualisation du prix par rapport � la surface 
ggplot(data, aes(x = squareMeters, y = price)) +
  geom_point() +
  stat_smooth()

#Formation du mod�le
model <- lm(price ~ squareMeters, data=data)
model


#Evaluation du mod�le
summary(model)
error <- sigma(model)*100/mean(data$price)
cat("Le pourcentage d'erreur du mod�le est de",error,"%")

#Enregistrement du mod�le
save(model, file="model.Rdata")
