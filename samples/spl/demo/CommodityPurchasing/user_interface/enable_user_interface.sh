#!/bin/csh -f
# begin_generated_IBM_Teracloud_ApS_copyright_prolog               
#                                                                  
# This is an automatically generated copyright prolog.             
# After initializing,  DO NOT MODIFY OR MOVE                       
# **************************************************************** 
# Licensed Materials - Property of IBM                             
# (C) Copyright Teracloud ApS 2024, 2024, IBM Corp. 2009, 2013     
# All Rights Reserved.                                             
# US Government Users Restricted Rights - Use, duplication or      
# disclosure restricted by GSA ADP Schedule Contract with          
# IBM Corp.                                                        
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 

# This script takes the file sink output of the SPL sample application application and
# produces files that the web user interface can consume.  The web user interface, this 
# script, and anything else involving the display of data is provided to enable observation 
# of the SPL sample application.  It is not provided as a recommended example of how to 
# build a user interface.  It was built with facilities already being used in the Streams
# product, to enable running of the sample application without requiring additional products 
# or packages.

# Delete the purchase history file associated with manual purchases to prevent any 
# purchases from prior runs being reprocessed.  Then recreate as an empty file.
  rm -f purchase_history
  touch purchase_history

echo "Checking if required directories are present..."

if ( -e web_ui/data ) then
  echo "  Data directory exists."
  # Short delay to allow the sink files to be initialized before we process them
  # This will prevent us from initially showing the data from a prior run in firefox
  sleep 4
else
  echo "  Creating data directory."
  mkdir web_ui/data
endif

if ( -e web_ui/dojo ) then
  echo "  Toolkit directory exists."
else
  echo "  Creating toolkit directory."
  cp -r $STREAMS_INSTALL/ext/dojo web_ui/dojo
endif



set SINK_FILE_PATH=../data
set CREATED_FILE_PATH=web_ui/data

# Delete the old display files.  When we start a new run of the application, we don't
# want the old data files to be displayed initially.
  rm -f $CREATED_FILE_PATH/Ratings_History.csv
  rm -f $CREATED_FILE_PATH/Rankings_display.csv
  rm -f $CREATED_FILE_PATH/WeatherHistory.csv
  rm -f $CREATED_FILE_PATH/Supply_History.csv
  rm -f $CREATED_FILE_PATH/Purchase_Transactions.csv
  rm -f $CREATED_FILE_PATH/Purchase_Averages.csv

while (1)

# Since creating the rankings file is a multi-step process, we use temporary files for
# the steps to reduce that chance that the app will display incomplete data if the 
# web user interfaces refreshes in the middle of these steps.

#######################
# Rankings Display File
#######################

  # Delete old temporary files
  rm -f $CREATED_FILE_PATH/temp_head
  rm -f $CREATED_FILE_PATH/temp_rank
  rm -f $CREATED_FILE_PATH/temp_rank1

  # Create the new temp rankings file
  echo "Location,Score,WeatherScore,Warnings,Station,TempDelta,AvgTemp,RelativeHumidity" > $CREATED_FILE_PATH/temp_head
 
  # Append the data to a temp the rankings file.  The approach used below is very data dependent,
  # but since the sample user interface is only to enable observation of the execution of the
  # application, its not necessary to do something more elegant.

  # Append the last ranking for each location to the file
  grep Abilene $SINK_FILE_PATH/TopSupplier/Rankings.result | tail -1 >> $CREATED_FILE_PATH/temp_rank  
  grep Bozeman $SINK_FILE_PATH/TopSupplier/Rankings.result | tail -1 >> $CREATED_FILE_PATH/temp_rank  
  grep Chimney $SINK_FILE_PATH/TopSupplier/Rankings.result | tail -1 >> $CREATED_FILE_PATH/temp_rank  
  grep Delacroix $SINK_FILE_PATH/TopSupplier/Rankings.result | tail -1 >> $CREATED_FILE_PATH/temp_rank  
  grep Escondido $SINK_FILE_PATH/TopSupplier/Rankings.result | tail -1 >> $CREATED_FILE_PATH/temp_rank  
  grep Klickitat $SINK_FILE_PATH/TopSupplier/Rankings.result | tail -1 >> $CREATED_FILE_PATH/temp_rank  
  grep Tupelo $SINK_FILE_PATH/TopSupplier/Rankings.result | tail -1 >> $CREATED_FILE_PATH/temp_rank  
  grep Tygart $SINK_FILE_PATH/TopSupplier/Rankings.result | tail -1 >> $CREATED_FILE_PATH/temp_rank  
  grep Vero $SINK_FILE_PATH/TopSupplier/Rankings.result | tail -1 >> $CREATED_FILE_PATH/temp_rank  
  grep Hallo $SINK_FILE_PATH/TopSupplier/Rankings.result | tail -1 >> $CREATED_FILE_PATH/temp_rank
  grep Yucca $SINK_FILE_PATH/TopSupplier/Rankings.result | tail -1 >> $CREATED_FILE_PATH/temp_rank
  grep Zwingle $SINK_FILE_PATH/TopSupplier/Rankings.result | tail -1 >> $CREATED_FILE_PATH/temp_rank

  sort -t',' -r -n -k2,2 $CREATED_FILE_PATH/temp_rank > $CREATED_FILE_PATH/temp_rank1

  cp $CREATED_FILE_PATH/temp_head $CREATED_FILE_PATH/Rankings_display.csv
  cat $CREATED_FILE_PATH/temp_rank1 >> $CREATED_FILE_PATH/Rankings_display.csv

#############################
# Rating History Display File
#############################

 # Create the rating history file
 echo "Location,WeatherScore,Station,TempDelta,AvgTemp,RelativeHumidity,Timestamp" > $CREATED_FILE_PATH/Ratings_History.csv

 tail -1000 $SINK_FILE_PATH/TopSupplier/RatingHistory.result >> $CREATED_FILE_PATH/Ratings_History.csv

#####################
# Supply Display File
#####################
 # Supply file
 echo "Supply,SupplyChange,Timestamp" > $CREATED_FILE_PATH/Supply_History.csv

 tail -50 $SINK_FILE_PATH/SupplyAndPurchase/CurrentStock.result >> $CREATED_FILE_PATH/Supply_History.csv

####################################
# Purchase Transactions Display File
####################################
 # Purchase transactions file
 echo "AmountPurchased,Location,WeatherScore,Timestamp" > $CREATED_FILE_PATH/Purchase_Transactions.csv

 tail -40 $SINK_FILE_PATH/SupplyAndPurchase/PurchaseTransactions.result >> $CREATED_FILE_PATH/Purchase_Transactions.csv

#####################################
# Average Purchase Score Display File
#####################################
 # Average purchase score file
 echo "Average,Timestamp" > $CREATED_FILE_PATH/Purchase_Averages.csv

tail -20 $SINK_FILE_PATH/SupplyAndPurchase/PurchaseScoreAvg.result >> $CREATED_FILE_PATH/Purchase_Averages.csv

##############################
# Weather History Display File
##############################

 # Delete the old temp files
  rm -f $CREATED_FILE_PATH/temp_hist
  rm -f $CREATED_FILE_PATH/temp_hist1

 # Copy only the last part of the LocationWeather file (since it is ever-growing)
 tail -600 $SINK_FILE_PATH/WeatherConditions/LocationWeather.result > $CREATED_FILE_PATH/temp_hist

 # Sort by timestamp, because we are going to reduce it further
 sort -t',' -n -k7,7 $CREATED_FILE_PATH/temp_hist > $CREATED_FILE_PATH/temp_hist1

 # Put the header line in the display file
 echo "City,State,County,Latitude,Longitude,Station,Timestamp,TempInC,Temperature,RelativeHumidity,Dewpoint,WindHeadingDegrees,WindSpeedKnots,WindGustKnots" > $CREATED_FILE_PATH/WeatherHistory.csv

 # Take the last part of the sorted file and append it to the display file.
 tail -300 $CREATED_FILE_PATH/temp_hist1 >> $CREATED_FILE_PATH/WeatherHistory.csv


##############################
# Application Metrics
##############################


#####################
# Total Tuples Display File
#####################
 echo "TotalTuples,Timestamp" > $CREATED_FILE_PATH/Total_Weather_Tuples.csv

 tail -45 $SINK_FILE_PATH/WeatherConditions/TotalWeatherTuples.result >> $CREATED_FILE_PATH/Total_Weather_Tuples.csv

#####################
# Total Tuples Per Minute Display File
#####################
 echo "TotalTuples,Timestamp" > $CREATED_FILE_PATH/Weather_Tuples_Per_Minute.csv

 tail -7 $SINK_FILE_PATH/WeatherConditions/WeatherTuplesPerMinute.result >> $CREATED_FILE_PATH/Weather_Tuples_Per_Minute.csv

#####################
# Filtered Tuples Display File
#####################
 echo "TotalTuples,Timestamp" > $CREATED_FILE_PATH/Filtered_Weather_Tuples.csv

 tail -45 $SINK_FILE_PATH/WeatherConditions/TotalFilteredTuples.result >> $CREATED_FILE_PATH/Filtered_Weather_Tuples.csv

#####################
# Filtered Tuples Per Minute Display File
#####################
 echo "TotalTuples,Timestamp" > $CREATED_FILE_PATH/Filtered_Tuples_Per_Minute.csv

 tail -7 $SINK_FILE_PATH/WeatherConditions/FilteredTuplesPerMinute.result >> $CREATED_FILE_PATH/Filtered_Tuples_Per_Minute.csv

#####################
# Total Warnings Display File
#####################
 echo "TotalTuples,Timestamp" > $CREATED_FILE_PATH/Total_WatchesAndWarnings.csv

 tail -45 $SINK_FILE_PATH/WatchesAndWarnings/TotalWatchesWarnings.result >> $CREATED_FILE_PATH/Total_WatchesAndWarnings.csv

#####################
# Total Warnings Per Minute Display File
#####################
 echo "TotalTuples,Timestamp" > $CREATED_FILE_PATH/WatchesAndWarnings_Per_Minute.csv

 tail -7 $SINK_FILE_PATH/WatchesAndWarnings/WatchesWarningsTimestampedReadingsPerMinute.result >> $CREATED_FILE_PATH/WatchesAndWarnings_Per_Minute.csv

#####################
# Total Scores Display File
#####################
 echo "TotalTuples,Timestamp" > $CREATED_FILE_PATH/Total_Weather_Scores.csv

 tail -45 $SINK_FILE_PATH/TopSupplier/TotalWeatherScores.result >> $CREATED_FILE_PATH/Total_Weather_Scores.csv





# Display a message indicating that a new set of display files have been generated.
 echo "Data files for the user interface have been regenerated at `date +%X`."

# Go to sleep for some interval prior to generating the next set of display files.
 sleep 10s
end

