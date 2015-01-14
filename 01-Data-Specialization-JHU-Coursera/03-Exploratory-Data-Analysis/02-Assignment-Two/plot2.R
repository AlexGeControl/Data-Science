#
# Contents:
#   Plot2 for Assignment 2 for Exploratory Data Analysis from John Hopkins @ Coursera
# Author:
#   Alex Ge, alexgecontrol@qq.com
#

# Function:
#   generate_plot
# Description:
#   generate plot for problem 2, assignment2
# Notice:
#   make sure that the dataset is in the current working directory
generate_plot <- function( cwd = "C:/Users/thinkpad/Desktop/00-Mathematics/03-Statistics/01-Basic Statistics/Projects/01-Data-Specialization-JHU-Coursera/03-Exploratory-Data-Analysis/02-Assignment-Two" , 
                           image_width = 640 , 
                           image_height = 640 )
{
  #
  # 0. Set up R session:
  #
  # Set current working directory:
  setwd( cwd )
  # Package for data mungling:
  library( data.table )
  
  #
  # 1. Data mungling:
  #
  # Load datasets:
  NEI <- readRDS( "summarySCC_PM25.rds" )
  # Total emissions of US:
  data_table <- data.table( NEI[ "24510" == NEI$fips , ] )
  total_emissions_of_Baltimore <- data_table[ , sum( Emissions ) , by = year ]
  setnames( total_emissions_of_Baltimore , "V1" , "total.emissions" )
  
  #
  # 2. Data Visualization:
  #
  # Create png file device:
  png( "figure/plot2.png" , width = image_width , height = image_height )
  # Create plot:
  plot( total_emissions_of_Baltimore$year , total_emissions_of_Baltimore$total.emissions , type = "l" , col = "black" , xlab = "Year" , ylab = "Total Emissions" , main = "Total Emissions of Baltimore, 1999-2008" )
  # Save file:
  dev.off( )
}