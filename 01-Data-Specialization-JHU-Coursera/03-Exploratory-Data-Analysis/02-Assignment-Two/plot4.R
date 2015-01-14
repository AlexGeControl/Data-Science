#
# Contents:
#   Plot4 for Assignment 2 for Exploratory Data Analysis from John Hopkins @ Coursera
# Author:
#   Alex Ge, alexgecontrol@qq.com
#

# Function:
#   generate_plot
# Description:
#   generate plot for problem 4, assignment2
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
  SCC <- readRDS( "Source_Classification_Code.rds" )
  # Extract SCCs for coal combustion related sources:
  coal_related_SCCs <- levels( SCC$SCC.Level.Three )[ grep( "Coal" , levels( SCC$SCC.Level.Three ) ) ]
  combustion_related_SCCs <- levels( SCC$SCC.Level.One )[ grep( "Combustion" , levels( SCC$SCC.Level.One ) ) ]
  indices <- ( SCC$SCC.Level.Three %in% coal_related_SCCs ) & ( SCC$SCC.Level.One %in% combustion_related_SCCs )
  coal_combustion_related_SCCs <- SCC$SCC[ indices ]
  # Total coal combustion related emissions of US:
  data_table <- data.table( NEI )
  total_emissions_of_US <- data_table[ SCC %in% coal_combustion_related_SCCs , sum( Emissions ) , by = year ]
  setnames( total_emissions_of_US , "V1" , "total.emissions" )
  
  #
  # 2. Data Visualization:
  #
  # Create png file device:
  png( "figure/plot4.png" , width = image_width , height = image_height )
  # Create plot:
  p <- qplot( year , total.emissions , data = total_emissions_of_US ,
              geom = "line" ,
              xlab = "Year" , ylab = "Total Emissions" , main = "Total Coal Combustion Related Emissions of US, 1999-2008" )
  print( p )
  # Save file:
  dev.off( )
}