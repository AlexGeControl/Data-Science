#
# Contents:
#   Plot1 for Assignment 1 for Exploratory Data Analysis from John Hopkins @ Coursera
# Author:
#   Alex Ge, alexgecontrol@qq.com
#

# Function:
#   generate_plot1
# Description:
#   generate histrogram for global active power
# Notice:
#   make sure that the dataset 'household_power_consumption.txt' is in the current working directory
generate_plot1 <- function( dataset_filename = "household_power_consumption.txt" , width = 480 , height = 480 )
{
  # read data:
  power_data <- read.table( dataset_filename , header = TRUE , stringsAsFactors = FALSE , sep = ";" )
  # Change format:
  dates <- strptime( power_data$Date , "%d/%m/%Y" )
  # Extract observations for Feburary 2007
  data <- power_data[ is_selected_date( dates , "2007" , "02" , c( "01" , "02" ) ) , ]
  # Create png file device:
  png( "figure/plot1.png" , width = width , height = height )
  # Create plot:
  hist( as.numeric( data$Global_active_power ) , col = "Red" , main = "Global Active Power" , xlab = "Global Active Power (kilowatts)" )
  # Save as png file:
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