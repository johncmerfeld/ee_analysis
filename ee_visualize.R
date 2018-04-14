setwd("~/Documents/Code/ee_analysis/")
library(ggplot2)
library(data.table)
library(reshape2)
library(scales)

# load in data, coerce to date format
ee_data <- fread("ee_data.csv")
ee_data$date = as.Date(ee_data$date)

# add cumulative sums from count data
ee_data <- within(ee_data, Hypothermia <- cumsum(hypo_plays))
ee_data <- within(ee_data, Sparks <- cumsum(sparks_plays))
ee_data <- within(ee_data, Moth <- cumsum(moth_plays))
ee_data <- within(ee_data, Sail <- cumsum(sail_plays))
ee_data <- within(ee_data, Messier <- cumsum(mess_plays))
ee_data <- within(ee_data, Corpses <- cumsum(corpse_plays))
ee_data <- within(ee_data, ESA <- cumsum(esa_plays))
ee_data <- within(ee_data, Dakin <- cumsum(dakin_plays))
ee_data <- within(ee_data, BrenGlea <- cumsum(bren_plays))
ee_data <- within(ee_data, Debt <- cumsum(debt_plays))
ee_data <- within(ee_data, Dime <- cumsum(dime_plays))
ee_data <- within(ee_data, October <- cumsum(oct_plays))
ee_data <- within(ee_data, Later <- cumsum(later_plays))

# ignore Moth single
ee_totals <- ee_data[21:60,c("date","Hypothermia","Sparks","Moth","Sail",
                             "Messier","Corpses","ESA","Dakin","BrenGlea",
                             "Debt","Dime","October","Later")]

# reshape and plot
ee_melt <- melt(ee_totals,id="date")
ggplot(ee_melt,aes(x=date,
                   y=value,
                   colour=variable,
                   group=variable)) + 
 geom_line(size = 1.5) + 
 labs(color = "Song",
       title = "EE song performance over time",
       x = "Date",
       y = "Total listens") +
  scale_x_date(breaks = date_breaks(width = "1 week"))
