setwd("Documents/Code/R")
library(ggplot2)
library(data.table)
library(reshape2)
library(scales)

numYears <- 2

outcomes <- data.frame(name = c(), correlation = c(), year = c())

for (i in 1:numYears) {
  # read in data
  bowl_data <- fread(paste0("bowlpool", i, ".csv"))
  
  # process data
  bowl_data$Bettors <- c(1:25)
  
  tomMod <- glm(Bettors ~ Tom, data = bowl_data)
  annMod <- glm(Bettors ~ Ann, data = bowl_data)
  andMod <- glm(Bettors ~ Andy, data = bowl_data)
  kevMod <- glm(Bettors ~ Kevin, data = bowl_data)
  sarMod <- glm(Bettors ~ Sarah, data = bowl_data)
  johMod <- glm(Bettors ~ John, data = bowl_data)
  
  year <- data.frame(name = c(1:6), correlation = c(1:6), year = c(rep(i, 6)))
  
  year$name <- c("Tom", "Ann", "Andy", "Kevin", "Sarah", "John")
  year$correlation <- c(tomMod$coefficients[2], annMod$coefficients[2],
                        andMod$coefficients[2], kevMod$coefficients[2],
                        sarMod$coefficients[2], johMod$coefficients[2])

  outcomes <- rbind(outcomes, year)
  
}


# reshape and plot
bowl_melt <- melt(bowl_data)
ggplot(bowl_melt,
       aes(x = rep(1:25, 
                   times = 7),
           y = value,
           colour = variable,
           group = variable)) + 
  geom_point(size = 1.5) +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(title = "Which Merfeld goes hardest against the grain?",
       x = "Bettors weight on favorite",
       y = "Merfelds weight on favorite")


ggplot(outcomes,
       aes(x = year,
           y = correlation,
           colour = name,
           group = name)) + 
  geom_point(size = 1.5) +
  geom_line() + 
  geom_point(data=outcomes[1, ],
             aes(x = year, y = correlation),
             colour = "red", size = 3) + 
  labs(title = "Historical betting strategies (red circle indicates victory)",
       x = "Year",
       y = "Correlation with Bettor pick") +
  scale_color_brewer(palette = "Dark2")