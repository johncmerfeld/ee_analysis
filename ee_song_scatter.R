setwd("Documents/Code/ee_analysis/")
library(ggplot2)
library(data.table)
library(reshape2)
library(scales)

song_data <- fread("song_overall.csv")
song_data <- song_data[order(song_data$track),]

stream0 <- song_data[1]$streams
streamN <- song_data[13]$streams

listen_model <- glm(streams ~ exp(track), data = song_data)

ggplot(data = song_data, aes(x = track,
                      y = streams)) +
  geom_point()
  