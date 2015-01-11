#
# Contents:
#   Plot3 for Assignment 1 for Exploratory Data Analysis from John Hopkins @ Coursera
# Author:
#   Alex Ge, alexgecontrol@qq.com
#

# Function:
#   generate_plot3
# Description:
#   generate plot for time series of sub metering 1,2 and 3
# Notice:
#   make sure that the dataset 'household_power_consumption.txt' is in the current working directory
generate_plot3 <- function( dataset_filename = "household_power_consumption.txt" , width = 480 , height = 480 )
{
  # read data:
  power_data <- read.table( dataset_filename , header = TRUE , stringsAsFactors = FALSE , sep = ";" )
  # Change format:
  dates <- strptime( paste( power_data$Date , power_data$Time , sep="--"), "%d/%m/%Y--%H:%M:%S" )
  # Extract observations for Feburary 2007
  data <- power_data[ is_selected_date( dates , "2007" , "02" , c( "01" , "02" ) ) , ]
  # Create png file device:
  png( "figure/plot3.png" , width = width , height = height )
  # Create plot:
  times <- strptime( paste( data$Date , data$Time , sep="--") , "%d/%m/%Y--%H:%M:%S" )
  plot( times , data$Sub_metering_1 , type = "l" , col = "Black" , xlab = "Weekday" , ylab = "Energy Sub Metering" )
  lines( times , data$Sub_metering_2 , type = "l" , col="Red" )
  lines( times , data$Sub_metering_3 , type = "l" , col="Blue" )
  legend( "topright" , legend=c( "Sub Metering 1" , "Sub Metering 2" , "Sub Metering 3" ) , lwd=2 , col=c( "Black", "Red", "Blue" ) )
  # Save file:
  dev.off( )
}

# Function:
#   is_selected_date
# Description:
#   generate logic indices for data extraction
is_selected_date <- function( dates , selected_years , selected_months , selected_days )
{
  # Year:
  years <- format( dates , "%Y" )
  # Month:
  months <- format( dates , "%m" )
  # Date:
  days <- format( dates , "%d" )
  
  return( ( years %in% selected_years ) & ( months %in% selected_months ) & ( days %in% selected_days ) )
}