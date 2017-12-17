setwd("Documents/Code/ee_analysis/")
library(ggplot2)
library(data.table)
library(reshape2)
ee_data <- fread("ee_data.csv")
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

ee_totals <- ee_data[22:60,c("date","Hypothermia","Sparks","Moth","Sail",
                             "Messier","Corpses","ESA","Dakin","BreGlea",
                             "Debt","Dime","October","Later")]

ee_melt <- melt(ee_totals,id="date")
ggplot(ee_melt,aes(x=date,
                   y=value,
                   colour=variable,
                   group=variable)) + 
 geom_line() + 
 labs(color = "Song",
       title = "EE song performance over time",
       x = "Date",
       y = "Total listens")