#
# Contents:
#   Plot3 for Assignment 2 for Exploratory Data Analysis from John Hopkins @ Coursera
# Author:
#   Alex Ge, alexgecontrol@qq.com
#

# Function:
#   generate_plot
# Description:
#   generate plot for problem 3, assignment2
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
  # Package for data visualization:
  library( ggplot2 )
  
  #
  # 1. Data mungling:
  #
  # Load datasets:
  NEI <- readRDS( "summarySCC_PM25.rds" )
  # Total emissions of Baltimore:
  data_table <- data.table( NEI )
  total_emissions_of_Baltimore <- data_table[ "24510" == fips , sum( Emissions ) , by = list( year , type ) ]
  setnames( total_emissions_of_Baltimore , "V1" , "total.emissions" )
  
  #
  # 2. Data Visualization:
  #
  # Create png file device:
  png( "figure/plot3.png" , width = image_width , height = image_height )
  # Create plot:
  p <- qplot( year , total.emissions , data = total_emissions_of_Baltimore , facets = type ~ . ,
         geom = "line" ,
         xlab = "Year" , ylab = "Total Emissions" , main = "Total Emissions of Baltimore, 1999-2008" )
  print( p )
  # Save file:
  dev.off( )
}