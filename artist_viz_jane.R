

setwd("/Users/johncmerfeld/Documents/Code/ee_analysis/data")
library(data.table)
library(ggplot2)
library(sqldf)
artists <- fread("jane_artists.csv")

artists_df <- data.table(sqldf("
      
SELECT

  AVG(`Years of Fandom`) AS avg_years_of_fandom,
  `Musical Style` AS musical_style

FROM artists
GROUP BY `Musical Style`
ORDER BY `Years of Fandom`
      
      "))

ggplot(artists,
       aes(x = history,
           y = volume)) +
  geom_point(alpha = 0.5,
             aes(color = as.numeric(live),
                 size = as.numeric(wmfo_plays),
                 shape = response),
             position = "jitter") +
  geom_text(data = subset(artists,
                          wmfo_plays > 10 |
                            history > 13 |
                            live > 70 | 
                            volume > 6),
            aes(label = artist),
            position = position_jitter(width = 0.25,
                                       height = 0.5)) +
  scale_size_continuous("WMFO plays*",
                        range = c(0.5,10),
                        trans = "identity") +
  scale_color_gradient("Live experience points**",
                       low = "red",
                       high = "blue") +
  scale_shape_discrete("Response") +
  labs(x = "Years of fandom",
       y = "Albums I'm familiar with",
       caption = "*WMFO plays extend beyond graduation because I continue to curate \"radio ready\" playlists\n**(Quality_of_show[1-10])^2 * n_shows",
       title = "My 58 favorite artists, scored on a few metrics")