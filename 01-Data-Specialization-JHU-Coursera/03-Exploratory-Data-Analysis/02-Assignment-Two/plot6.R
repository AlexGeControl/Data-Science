#
# Contents:
#   Plot6 for Assignment 2 for Exploratory Data Analysis from John Hopkins @ Coursera
# Author:
#   Alex Ge, alexgecontrol@qq.com
#

# Function:
#   generate_plot
# Description:
#   generate plot for problem 6, assignment2
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
  vehicle_related_SCCs_level_two <- levels( SCC$SCC.Level.Two )[ grep( "Motor|Vehicle" , levels( SCC$SCC.Level.Two ) ) ]
  vehicle_related_SCCs_level_three <- levels( SCC$SCC.Level.Three )[ grep( "Motor|Vehicle" , levels( SCC$SCC.Level.Three ) ) ]
  indices <- ( SCC$SCC.Level.Two %in% vehicle_related_SCCs_level_two ) & ( SCC$SCC.Level.Three %in% vehicle_related_SCCs_level_three )
  vehicle_related_SCCs <- SCC$SCC[ indices ]
  # Total motor vehicle related emissions of Baltimore:
  data_table <- data.table( NEI[ "24510" == NEI$fips , ] )
  total_emissions_of_Baltimore <- data_table[ SCC %in% vehicle_related_SCCs , sum( Emissions ) , by = year ]
  total_emissions_of_Baltimore$County <- "Baltimore"
  setnames( total_emissions_of_Baltimore , "V1" , "total.emissions" )
  # Total motor vehicle related emissions of LA:
  data_table <- data.table( NEI[ "06037" == NEI$fips , ] )
  total_emissions_of_LA <- data_table[ SCC %in% vehicle_related_SCCs , sum( Emissions ) , by = year ]
  total_emissions_of_LA$County <- "LA County"
  setnames( total_emissions_of_LA , "V1" , "total.emissions" )
  # Merged total motor vehicle related emissions:
  total_emissions <- rbind( total_emissions_of_Baltimore , total_emissions_of_LA )
  total_emissions$County <- factor( total_emissions$County )
  print( total_emissions )
  
  #
  # 2. Data Visualization:
  #
  # Create png file device:
  png( "figure/plot6.png" , width = image_width , height = image_height )
  # Create plot:
  p <- qplot( year , total.emissions , data = total_emissions , colour = County ,
              geom = "line" ,
              xlab = "Year" , ylab = "Total Emissions" , main = "Total Motor Vehicle Related Emissions of Baltimore and LA County, 1999-2008" )
  print( p )
  # Save file:
  dev.off( )
}