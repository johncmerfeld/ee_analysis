setwd("/Users/johncmerfeld/Documents/Code/R")
library(data.table)
library(ggplot2)
songs <- fread("song_data.csv")

ggplot(songs,
       aes(x = streams,
           y = saves)) +
  geom_point(alpha = 0.5,
             aes(color = as.factor(release_date),
                 size = as.numeric(listeners))) +
  scale_size_continuous("Unique listeners",
                        range = c(1,10),
                        trans = "identity") +
  scale_color_discrete("Release Date")
 