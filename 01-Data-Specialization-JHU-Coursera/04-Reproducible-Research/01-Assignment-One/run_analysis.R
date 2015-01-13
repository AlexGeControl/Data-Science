#
# Content:
#   Assignment 1 of Reproducible Research from JHU @ Coursera
# Author:
#   Alex Ge, alexgecontrol@qq.com
#

#
# 0. Config R session:
#
setwd( "C:/Users/thinkpad/Desktop/00-Mathematics/03-Statistics/01-Basic Statistics/Projects/01-Data-Specialization-JHU-Coursera/04-Reproducible-Research/01-Assignment-One" )
# Package for graphing:
library( ggplot2 )
# Package for data mungling:
library( data.table )

#
# 1. Data Mungling:
#
# Raw data:
raw_data <- read.csv( "activity.csv" , header = TRUE , stringsAsFactors = FALSE )
raw_data_table <- data.table( raw_data )
# Imputed data(fill NA with median since the data is highly skewed):
imputed_data <- raw_data
imputed_data$steps[ is.na( imputed_data$steps ) ] <- median( imputed_data$steps , na.rm = TRUE )
imputed_data_table <- data.table( imputed_data )
# Total steps by day:
total_steps_by_day_raw <- raw_data_table[ , sum( steps ), by = date ]
total_steps_by_day_raw$Imputed <- "False"
total_steps_by_day_imputed <- imputed_data_table[ , sum( steps ), by = date ]
total_steps_by_day_imputed$Imputed <- "True"
total_steps_by_day <- rbind( total_steps_by_day_imputed , total_steps_by_day_raw )
setnames( total_steps_by_day , "V1" , "total.steps" )
total_steps_by_day$Imputed = factor( total_steps_by_day$Imputed , levels = c( "True" , "False" ) )
# b. Average steps by interval:
mean_steps_by_interval <- imputed_data_table[ , mean( steps ), by = interval ]
setnames( mean_steps_by_interval , "V1" , "average.steps" )
# c. Average steps by interval faceted by day type:
date <- strptime( imputed_data$date , "%Y-%m-%d" )
days <- weekdays( date , abbreviate = TRUE )
is_weekend <- days %in% c( "ÖÜÁù" , "ÖÜÈÕ" )
mean_steps_by_weekdays <- imputed_data_table[ !is_weekend , mean( steps ), by = interval ]
mean_steps_by_weekdays$Day <- "Weekdays"
mean_steps_by_weekend <- imputed_data_table[ is_weekend , mean( steps ), by = interval ]
mean_steps_by_weekend$Day <- "Weekend"
mean_steps_by_day <- rbind( mean_steps_by_weekdays , mean_steps_by_weekend )
setnames( mean_steps_by_day , "V1" , "average.steps" )
mean_steps_by_day$Day = factor( mean_steps_by_day$Day , levels = c( "Weekdays" , "Weekend" ) )

#
# 2. Data Analysis for Total Steps by Day Data:
#
# Histogram:
qplot( total.steps , data = total_steps_by_day , 
       geom = "histogram" , fill = Imputed , position = "dodge" ,
       xlab = "Total Steps" , ylab = "Frequency" , main = "Histogram for Raw/Imputed \'Total Steps by Day\' Data" )

#
# 3. Data Analysis for Average Steps by Interval Data:
#
qplot( interval , average.steps , data = mean_steps_by_interval , colour = "red" ,
       geom = "line" ,
       xlab = "Interval" , ylab = "Average Steps" , main = "Average Steps by Time Intervals within A Day" ) + 
       guides( colour = FALSE )

#
# 4. Data Analysis for Average Steps by Interval Faceted by Day Data:
#
qplot( interval , average.steps , data = mean_steps_by_day , colour = "red" , facets = Day ~ . ,
       geom = "line" ,
       xlab = "Interval" , ylab = "Average Steps" , main = "Average Steps by Time Intervals Faceted by Day" ) + 
       guides( colour = FALSE )