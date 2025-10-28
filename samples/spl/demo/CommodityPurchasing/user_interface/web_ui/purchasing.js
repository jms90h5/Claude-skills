/* begin_generated_IBM_Teracloud_ApS_copyright_prolog               */
/*                                                                  */
/* This is an automatically generated copyright prolog.             */
/* After initializing,  DO NOT MODIFY OR MOVE                       */
/* **************************************************************** */
/* Licensed Materials - Property of IBM                             */
/* (C) Copyright Teracloud ApS 2024, 2024, IBM Corp. 2009, 2015     */
/* All Rights Reserved.                                             */
/* US Government Users Restricted Rights - Use, duplication or      */
/* disclosure restricted by GSA ADP Schedule Contract with          */
/* IBM Corp.                                                        */
/*                                                                  */
/* end_generated_IBM_Teracloud_ApS_copyright_prolog                 */
// Commodity Pruchasing sample application 
 
	
    // Constants

    var LOGGING_LEVEL = 2;           // Set logging level for logging debug/trace messages to console
    var NUMBER_OF_HISTORY_DAYS = 14; // Number of days of history to include in charts
    var MAX_SUPPLY_HISTORY = 100;    // Maximum number of supply history values to chart
    var MAX_PURCHASE_HISTORY = 100;  // Maximum number of purchase_averages values to chart
    var SUPPLY_THRESHOLD_1 = 15000;  // Optimal supply lower threshold in supply chart
    var SUPPLY_THRESHOLD_2 = 35000;  // Optimal supply upper threshold in supply chart
    var GRAPH_SERIES_COLORS =        // Colors to use fore differnt series data in charts
        [
        "#660000",
        "#660066", 
        "#000066", 
        "#006666", 
        "#006600", 
        "#666600", 
        "#FFFF00", 
        "#FF0000", 
        "#FF00FF", 
        "#0000FF", 
        "#00FFFF", 
        "#00FF00", 
        "#0066CC", 
        "#6600CC", 
        "#CC0066", 
        "#CC6600", 
        "#66CC00", 
        "#00CC66"
        ];

    var DATA_PATH = "data/"
    require([
	"dojo/ready",
	"dojo/fx",
	"dojo/dom",
	"dojo/parser",
	"dijit/form/Button",
	"dijit/registry",
	"dojox/data/CsvStore",
	"dojox/grid/DataGrid",
 	"dojox/charting/Chart2D",
     	"dojox/charting/action2d/Highlight",
     	"dojox/charting/action2d/Magnify",
      	"dojox/charting/action2d/Tooltip",
  	"dojox/charting/action2d/MoveSlice",
     	"dojox/charting/themes/PlotKit/blue"

     ], function(
	ready,
	fx,
	dom,
	parser,
	Button,
	registry,
	CsvStore,
	DataGrid,
	Chart2D,
	Highlight,
	Magnify,
	Tooltip,
	MoveSlice,
	blue	
	){

	ready(function(){	
    //
    // CVS file data stores
    //

    // Rankings_display.csv contains one record for each location being monitored
    // Fields:
    //     Location
    //     Score
    //     WeatherScore
    //     Warnings
    //     Station
    //     TempDelta
    //     AvgTemp
    //     RelativeHumidity
   rankings_display = new dojox.data.CsvStore({ url: DATA_PATH + "Rankings_display.csv", label: "Location" });

    // Register comparators for numeric values in CvsStore
    // This causes the Dojo DatGrid to correctly sort numeric columns
    rankings_display.comparatorMap = {};
    rankings_display.comparatorMap['Score'] = compareFloatString;
    rankings_display.comparatorMap['WeatherScore'] = compareFloatString;
    rankings_display.comparatorMap['Warnings'] = compareIntegerString;
    rankings_display.comparatorMap['TempDelta'] = compareFloatString;
    rankings_display.comparatorMap['AvgTemp'] = compareFloatString;
    rankings_display.comparatorMap['RelativeHumidity'] = compareFloatString;

    // Rankings_History.csv contains a history of rankiings. The schema is the same as rankings display
    // with the addition of a timestamp for each record
    // Fields:
    //     Location
    //     WeatherScore
    //     Station
    //     TempDelta
    //     AvgTemp
    //     RelativeHumidity
    //     Timestamp
   ratings_history =  new dojox.data.CsvStore({ url: DATA_PATH + "Ratings_History.csv",   label: "Station" });

    // Weather_History.csv contains a history of all weather readings. 
    // Fields:
    //     City
    //     State
    //     County
    //     Latitude
    //     Longitude
    //     Station
    //     Timestamp
    //     TempInC
    //     Temperature
    //     RelativeHumidity
    //     Dewpoint
    //     WindHeadingDegrees
    //     WindSpeedKnots
    //     WindGustKnots
    weather_history =  new dojox.data.CsvStore({ url: DATA_PATH + "WeatherHistory.csv" });

    // Supply history
    //
    // Contains one record every time the supply changes (decrease due to depletion or increases due to pruchase)
    // Each record contains the new supply level (no timestamp or indication of net change -- though net change can be inferred from one record to the next)
    // Fields: 
    //     Supply
    //     SupplyChange
    //     Timestamp
    supply_history =  new dojox.data.CsvStore({ url: DATA_PATH + "Supply_History.csv",   label: "Supply" });

    // Purchase averages
    //
    // Contains one record for every supply purchase
    // Each record contains the average weather rating at time of purchase
    // Fields:
    //     Average
    //     Timestamp
   purchase_averages =  new dojox.data.CsvStore({ url: DATA_PATH + "Purchase_Averages.csv" });

    // Purchase transactions
    //
    // Contains one record for every supply purchase
    // Each record contains the average weather rating at time of purchase
    // Fields:
    //     AmountPurchased
    //     Location
    //     WeatherScore
    //     Timestamp
   purchase_transactions =  new dojox.data.CsvStore({ url: DATA_PATH + "Purchase_Transactions.csv" });

    // Register comparators for numeric values in CvsStore
    // This causes the Dojo DatGrid to correctly sort numeric columns
    purchase_transactions.comparatorMap = {};
    purchase_transactions.comparatorMap['AmountPurchased'] = compareIntegerString;
    purchase_transactions.comparatorMap['WeatherScore'] = compareFloatString;
    purchase_transactions.comparatorMap['Timestamp'] = compareIntegerString;
    
    
    // Miscellaneous global variables
    
    // Station definitions
    // Array, keyed by station ID, containing one record for each station
    // Each record contains:
    //     Station
    //     City
    //     State
    //     County
    //     Latitude
    //     Longitude
    var stationDefinitions = new Array();

    // Number of stations found in the current rankings store
    var numberOfStations = 0;

    // Array of Arrays of rankings history
    // Outer array is indexed by Station (e.g. KTUP)
    // Inner array contains a record for each ranking for that station,
    // Filtered for the desired timestamp range and sorted by timetamp.
    var rankingsHistoryData = new Array();

    // Array of Arrays of weather history
    // Outer array is indexed by Station (e.g. KTUP)
    // Inner array contains a record for each weather reading for that station,
    var weatherHistoryData = new Array();
    
    // Array of records loaded from supply history store
    var supplyHistoryData = new Array();
    
    // Array of records loaded from purchase_averages store
    var purchaseAveragesData = new Array();
    
    // Array of Array of records loaded from purchase_averages store
    // Outer array is indexed by Location (City), 
    // Inner array contains a record for each perchase from that location
    var purchaseTransactionsData = new Array();
    var purchaseTransactionsAmountPurchased = 0;

    // Array of max and mins for each station from Ratings_History. Used in setting axes in charting
    var ratingsHistoryLimits = new Array();

    // Array of max and mins for each station from Weather_History store. Used in setting axes in charting
    var weatherHistoryLimits = new Array();

    
    // Color assigned to series data for each Station/Location
    // Ensures the same (randomly assigned) series color is used for the same location in all graphs
    var stationChartingColors = new Array();
    var locationChartingColors = new Array();

    var graphingLimits = {"minWeatherScore": 99999
                         ,"maxWeatherScore": 0
                         ,"minTempDelta": 99999
                         ,"maxTempDelta": 0
                         ,"minAvgTemp": 99999
                         ,"maxAvgTemp": 0
                         ,"minRelativeHumidity": 99999
                         ,"maxRelativeHumidity": 0
                         ,"minTempInC": 99999
                         ,"maxTempInC": 0
                         ,"minTemperature": 99999
                         ,"maxTemperature": 0
                         ,"minDewpoint": 99999
                         ,"maxDewpoint": 0
                         ,"minWindHeadingDegrees": 99999
                         ,"maxWindHeadingDegrees": 0
                         ,"minWindSpeedKnots": 99999
                         ,"maxWindSpeedKnots": 0
                         ,"minWindGustKnots": 99999
                         ,"maxWindGustKnots": 0
                         };
    

    var sortKeys = [{attribute: "Score", descending: true}];

    // Fetch all records from the rankings_display store
    // The onComplete handler will perform fetches on the other data stores
    rankings_display.fetch(
      {
      query: {Station: "*"},
      sort: sortKeys,
      onComplete: onRankingsDisplayComplete
      }
    );


    function setRatingsHistoryLimits(aRecord) {
      var aStation = aRecord.Station;
      var stationLimits = ratingsHistoryLimits[aStation];
      if (aRecord.WeatherScore < stationLimits.minWeatherScore) stationLimits.minWeatherScore = aRecord.WeatherScore;
      if (aRecord.WeatherScore > stationLimits.maxWeatherScore) stationLimits.maxWeatherScore = aRecord.WeatherScore;
      if (aRecord.TempDelta < stationLimits.minTempDelta) stationLimits.minTempDelta = aRecord.TempDelta;
      if (aRecord.TempDelta > stationLimits.maxTempDelta) stationLimits.maxTempDelta = aRecord.TempDelta;
      if (aRecord.AvgTemp < stationLimits.minAvgTemp) stationLimits.minAvgTemp = aRecord.AvgTemp;
      if (aRecord.AvgTemp > stationLimits.maxAvgTemp) stationLimits.maxAvgTemp = aRecord.AvgTemp;
      if (aRecord.RelativeHumidity < stationLimits.minRelativeHumidity) stationLimits.minRelativeHumidity = aRecord.RelativeHumidity;
      if (aRecord.RelativeHumidity > stationLimits.maxRelativeHumidity) stationLimits.maxRelativeHumidity = aRecord.RelativeHumidity;
    }

    function setWeatherHistoryLimits(aRecord) {
      var aStation = aRecord.Station;
      var stationLimits = weatherHistoryLimits[aStation];
      if (aRecord.TempInC < stationLimits.minTempInC) stationLimits.minTempInC = aRecord.TempInC;
      if (aRecord.TempInC > stationLimits.maxTempInC) stationLimits.maxTempInC = aRecord.TempInC;
      if (aRecord.Temperature < stationLimits.minTemperature) stationLimits.minTemperature = aRecord.Temperature;
      if (aRecord.Temperature > stationLimits.maxTemperature) stationLimits.maxTemperature = aRecord.Temperature;
      if (aRecord.RelativeHumidity < stationLimits.minRelativeHumidity) stationLimits.minRelativeHumidity = aRecord.RelativeHumidity;
      if (aRecord.RelativeHumidity > stationLimits.maxRelativeHumidity) stationLimits.maxRelativeHumidity = aRecord.RelativeHumidity;
      if (aRecord.Dewpoint < stationLimits.minDewpoint) stationLimits.minDewpoint = aRecord.Dewpoint;
      if (aRecord.Dewpoint > stationLimits.maxDewpoint) stationLimits.maxDewpoint = aRecord.Dewpoint;
      if (aRecord.WindHeadingDegrees < stationLimits.minWindHeadingDegrees) stationLimits.minWindHeadingDegrees = aRecord.WindHeadingDegrees;
      if (aRecord.WindHeadingDegrees > stationLimits.maxWindHeadingDegrees) stationLimits.maxWindHeadingDegrees = aRecord.WindHeadingDegrees;
      if (aRecord.WindSpeedKnots < stationLimits.minWindSpeedKnots) stationLimits.minWindSpeedKnots = aRecord.WindSpeedKnots;
      if (aRecord.WindSpeedKnots > stationLimits.maxWindSpeedKnots) stationLimits.maxWindSpeedKnots = aRecord.WindSpeedKnots;
      if (aRecord.WindGustKnots < stationLimits.minWindGustKnots) stationLimits.minWindGustKnots = aRecord.WindGustKnots;
      if (aRecord.WindGustKnots > stationLimits.maxWindGustKnots) stationLimits.maxWindGustKnots = aRecord.WindGustKnots;
    }

    // Callback function to handle a single record fetched from the rankings history store
    // If the timestamp for the record is within the selection range, create a record object
    // and store it in the history array for the Station
    // Only store a single reocrd for each hour, keeping the record with the most recent timestamp
    function onRatingsHistoryItem(item, request) {
       var aStation = ratings_history.getValue(item, "Station")
       var aTimestamp =  parseInt(ratings_history.getValue(item, "Timestamp")) * 1000 ;

       var aRecord = createHistoryRecord(item, ratings_history);
       rankingsHistoryData[aStation].push(aRecord);
    }

    // Callback function to handle onComplete event when all items have been fetched from the history store
    // for a given Station
    // Because we registered an onItem handler, the items array passed to
    // this function will be null (because we already handled the items)
    function onRatingsHistoryComplete(items, request) {
      // Extract the Station from the fetch query parameters
      var myQuery = request.query;
      var myStation = myQuery.Station;

      // Get the array of history data for this station
      // This array was created by onRankingsDisplayComplete before calling fetch on the ratings_history store
      var myHistoryData = rankingsHistoryData[myStation];
      logToConsole(1, 'onRatingsHistoryComplete - for ' + myStation + ' with ' + myHistoryData.length + ' records');

      // Sort the array of history records for this Station
      // They should already be in order by timestamp, but this will ensure it
      myHistoryData.sort(sortTimestamps);

      for (var i=0; i < myHistoryData.length; i++) {
        setRatingsHistoryLimits(myHistoryData[i]);
      }

      // Calculate overall limits for graph (x-axis start and end values)
      var stationLimits = ratingsHistoryLimits[myStation];
      if (stationLimits.minWeatherScore < graphingLimits.minWeatherScore) graphingLimits.minWeatherScore = stationLimits.minWeatherScore;
      if (stationLimits.maxWeatherScore > graphingLimits.maxWeatherScore) graphingLimits.maxWeatherScore = stationLimits.maxWeatherScore;
      if (stationLimits.minTempDelta < graphingLimits.minTempDelta) graphingLimits.minTempDelta = stationLimits.minTempDelta;
      if (stationLimits.maxTempDelta > graphingLimits.maxTempDelta) graphingLimits.maxTempDelta = stationLimits.maxTempDelta;
      if (stationLimits.minAvgTemp < graphingLimits.minAvgTemp) graphingLimits.minAvgTemp = stationLimits.minAvgTemp;
      if (stationLimits.maxAvgTemp > graphingLimits.maxAvgTemp) graphingLimits.maxAvgTemp = stationLimits.maxAvgTemp;
      if (stationLimits.minRelativeHumidity < graphingLimits.minRelativeHumidity) graphingLimits.minRelativeHumidity = stationLimits.minRelativeHumidity;
      if (stationLimits.maxRelativeHumidity > graphingLimits.maxRelativeHumidity) graphingLimits.maxRelativeHumidity = stationLimits.maxRelativeHumidity;

    }

    // Callback function to handle onComplete event when items have been fetched from 
    // the Weather_History.csv store for a given Station
    function onWeatherHistoryComplete(items, request) {

      // Extract the Station from the fetch query parameters
      var myQuery = request.query;
      var myStation = myQuery.Station;
      

      // Get the array of history data for this station
      // This array was
      var myWeatherHistoryData = weatherHistoryData[myStation];
      
      // Get the station definition, if one exists already
      var myStationDefinition = stationDefinitions[myStation];
      
      var numberOfRecords = items.length;
      logToConsole(1, "onWeatherHistoryComplete - Number of weather history records for station " + myStation + ": " + numberOfRecords);
      for (var i = 0; i < numberOfRecords; i++){
        var item = items[i];

        if (myStationDefinition == null) {
          myStationDefinition = createStationDefinitionRecord(item, weather_history);
          stationDefinitions[myStation] = myStationDefinition;
        }

        var aRecord = createWeatherHistoryRecord(item, weather_history);
        setWeatherHistoryLimits(aRecord);
        myWeatherHistoryData.push(aRecord);
      }

      // Sort the array of history records for this Station
      // They should already be in order by timestamp, but this will ensure it
      myWeatherHistoryData.sort(sortTimestamps);
      
      
      // Calculate overall limits for graph (x-axis start and end values)
      var stationLimits = weatherHistoryLimits[myStation];
      if (stationLimits.minTempInC < graphingLimits.minTempInC) graphingLimits.minTempInC = stationLimits.minTempInC;
      if (stationLimits.maxTempInC > graphingLimits.maxTempInC) graphingLimits.maxTempInC = stationLimits.maxTempInC;
      if (stationLimits.minTemperature < graphingLimits.minTemperature) graphingLimits.minTemperature = stationLimits.minTemperature;
      if (stationLimits.maxTemperature > graphingLimits.maxTemperature) graphingLimits.maxTemperature = stationLimits.maxTemperature;
      if (stationLimits.minRelativeHumidity < graphingLimits.minRelativeHumidity) graphingLimits.minRelativeHumidity = stationLimits.minRelativeHumidity;
      if (stationLimits.maxRelativeHumidity > graphingLimits.maxRelativeHumidity) graphingLimits.maxRelativeHumidity = stationLimits.maxRelativeHumidity;
      if (stationLimits.minDewpoint < graphingLimits.minDewpoint) graphingLimits.minDewpoint = stationLimits.minDewpoint;
      if (stationLimits.maxDewpoint > graphingLimits.maxDewpoint) graphingLimits.maxDewpoint = stationLimits.maxDewpoint;
      if (stationLimits.minWindHeadingDegrees < graphingLimits.minWindHeadingDegrees) graphingLimits.minWindHeadingDegrees = stationLimits.minWindHeadingDegrees;
      if (stationLimits.maxWindHeadingDegrees > graphingLimits.maxWindHeadingDegrees) graphingLimits.maxWindHeadingDegrees = stationLimits.maxWindHeadingDegrees;
      if (stationLimits.minWindSpeedKnots < graphingLimits.minWindSpeedKnots) graphingLimits.minWindSpeedKnots = stationLimits.minWindSpeedKnots;
      if (stationLimits.maxWindSpeedKnots > graphingLimits.maxWindSpeedKnots) graphingLimits.maxWindSpeedKnots = stationLimits.maxWindSpeedKnots;
      if (stationLimits.minWindGustKnots < graphingLimits.minWindGustKnots) graphingLimits.minWindGustKnots = stationLimits.minWindGustKnots;
      if (stationLimits.maxWindGustKnots > graphingLimits.maxWindGustKnots) graphingLimits.maxWindGustKnots = stationLimits.maxWindGustKnots;

    }


    // Callback function to handle onComplete event when all items have been fetched from the current rankings store
    //
    // The current rankings store has a single record for each Station (location).
    // Here, we will fetch the rankings history for each station
    function onRankingsDisplayComplete(items, request) {
      numberOfStations = items.length;
      logToConsole(1, "onRankingsDisplayComplete - Number of Stations found: " + numberOfStations);
      for (var i = 0; i < numberOfStations; i++){
        var item = items[i];
        logToConsole(1, "onRankingsDisplayComplete - Location: " + rankings_display.getLabel(item));
        var aStation = rankings_display.getValue(item, "Station");
        var aLocation = rankings_display.getValue(item, "Location");
        rankingsHistoryData[aStation] = new Array();
        weatherHistoryData[aStation] = new Array();
        var stationLimits = {"Station":aStation
                           ,"minWeatherScore": 99999
                           ,"maxWeatherScore": 0
                           ,"minTempDelta": 99999
                           ,"maxTempDelta": 0
                           ,"minAvgTemp": 99999
                           ,"maxAvgTemp": 0
                           ,"minRelativeHumidity": 99999
                           ,"maxRelativeHumidity": 0
                           };
        ratingsHistoryLimits[aStation] = stationLimits;
        stationLimits = {"Station":aStation
                           ,"minTempInC": 99999
                           ,"maxTempInC": 0
                           ,"minTemperature": 99999
                           ,"maxTemperature": 0
                           ,"minRelativeHumidity": 99999
                           ,"maxRelativeHumidity": 0
                           ,"minDewpoint": 99999
                           ,"maxDewpoint": 0
                           ,"minWindHeadingDegrees": 99999
                           ,"maxWindHeadingDegrees": 0
                           ,"minWindSpeedKnots": 99999
                           ,"maxWindSpeedKnots": 0
                           ,"minWindGustKnots": 99999
                           ,"maxWindGustKnots": 0
                           };
        weatherHistoryLimits[aStation] = stationLimits;

        stationChartingColors[aStation] = GRAPH_SERIES_COLORS[i % GRAPH_SERIES_COLORS.length];
        locationChartingColors[aLocation] = stationChartingColors[aStation];

        ratings_history.fetch(
          {
          query: {Station: aStation}, 
          onItem: onRatingsHistoryItem, 
          onComplete: onRatingsHistoryComplete
          }
        );

        weather_history.fetch(
          {
          query: {Station: aStation}, 
          onComplete: onWeatherHistoryComplete
          }
        );

      }
    
      supply_history.fetch(
        {
        query: {Supply: "*"},
        onComplete: onSupplyHistoryComplete
        }
      );

      purchase_averages.fetch(
        {
        query: {Timestamp: "*"},
        onComplete: onPurchaseAveragesComplete
        }
      );

      purchase_transactions.fetch(
        {
        query: {Timestamp: "*"},
        onComplete: onPurchaseTransactionsComplete
        }
      );


    }



    // Callback function to handle onComplete event when all items have been fetched from the supply history store
    //
    // The supply history store has a record every time the supply value changes
    function onSupplyHistoryComplete(items, request) {
      logToConsole(1, "onSupplyHistoryComplete - Number of values found: " + items.length);
      var start = 0;
      if (items.length > MAX_SUPPLY_HISTORY) {
        start = items.length - MAX_SUPPLY_HISTORY;
      }
      for (var i = start; i < items.length; i++) {
        var item = items[i];
        var supplyValue = parseInt(supply_history.getValue(item, "Supply"));
        var supplyRecord = {"Supply": parseInt(supply_history.getValue(item, "Supply"))
                     ,"SupplyChange": parseInt(supply_history.getValue(item, "SupplyChange"))
                     ,"Timestamp": parseInt(supply_history.getValue(item, "Timestamp"))
                     };
        supplyHistoryData.push(supplyRecord);
      }
      buildSupplyChart("SupplyHistory");
    }
    



    // Callback function to handle onComplete event when all items have been fetched from the Purchase_Averages store
    //
    // The purchase averages store has a record every time the a supply purchase is made
    function onPurchaseAveragesComplete(items, request) {
      logToConsole(1, "onPurchaseAveragesComplete - Number of values found: " + items.length);
      var start = 0;
      if (items.length > MAX_PURCHASE_HISTORY) {
        start = items.length - MAX_PURCHASE_HISTORY;
      }
      for (var i = start; i < items.length; i++) {
        var item = items[i];
        var purchaseAveragesRecord = {"Average":   parseInt(purchase_averages.getValue(item, "Average"))
                                      ,"Timestamp": parseInt(purchase_averages.getValue(item, "Timestamp"))
                     };
        purchaseAveragesData.push(purchaseAveragesRecord);
      }
      buildPurchaseAveragesChart("PurchaseAverages");
    }

    // Callback function to handle onComplete event when all items have been fetched from the Purchase_Transactions store
    //
    // The purchase transactions store has a record every time the a supply purchase is made
    function onPurchaseTransactionsComplete(items, request) {
      logToConsole(1, "onPurchaseTransactionsComplete - Number of values found: " + items.length);
      var start = 0;
      for (var i = start; i < items.length; i++) {
        var item = items[i];
        var purchaseTransactionRecord = {"AmountPurchased":   parseInt(purchase_transactions.getValue(item, "AmountPurchased"))
                                        ,"Location":          purchase_transactions.getValue(item, "Location")
                                        ,"WeatherScore":      parseInt(purchase_transactions.getValue(item, "AmountPurchased"))
                                        ,"Timestamp":         parseInt(purchase_transactions.getValue(item, "Timestamp"))
                                        };
        // Get array of records for this location. If array does not exist yet, create it
        var locationRecords = purchaseTransactionsData[purchaseTransactionRecord.Location];
        if (locationRecords == null) {
           locationRecords = new Array();
           purchaseTransactionsData[purchaseTransactionRecord.Location] = locationRecords;
        }
        purchaseTransactionsAmountPurchased += purchaseTransactionRecord.AmountPurchased;
        locationRecords.push(purchaseTransactionRecord);
      }
      buildPurchaseDistributionChart("PurchaseDistribution");
    }


    
    //
    // Rebuild charts including showing data series for selected rows in table
    //
    chartSelectedLocations = function(items) {
      if(items.length) {
        var stations = new Array();
        dojo.forEach(items, function(selectedItem) {
          if(selectedItem !== null) {
            stations.push(rankingGrid.store.getValue(selectedItem, "Station"));
          }
        }); // end forEach

        buildRatingsHistoryChart("WeatherScore", function(aRecord) {return aRecord.WeatherScore}, null, 1200, stations);
        buildWeatherHistoryChart("Temperature", function(aRecord) {return aRecord.Temperature}, formatDegrees, graphingLimits.maxTemperature, stations);
        buildWeatherHistoryChart("RelativeHumidity", function(aRecord) {return aRecord.RelativeHumidity}, formatHumidityFromPercent, graphingLimits.maxRelativeHumidity, stations);
      }
    };

    //
    // Build a line graph from the supply history data
    //
    // The X axis in the chart will be relative time (with indeterminate points and scale)
    // The Y axis in the chart will be the current supply level
   
    // 
    // @param id The id of the graph will be used to name elements in the chart2d elements
    //           and will be used to construct the following <div> ids:
    //           - "{id}Graph" will be the id of the div into which the chart will be rendered
    function buildSupplyChart(id) {
     
      logToConsole(1, "buildSupplyChart - Building " + id + " line chart");

      var chartDiv = id + "Graph";
      
      // Delete old chart, if any
      var list = dojo.byId(chartDiv);
      if (list) {
        while (list.firstChild) {
          list.removeChild(list.firstChild);
        }
      }


      var chart1 = new dojox.charting.Chart2D(chartDiv);
      chart1.setTheme(dojox.charting.themes.PlotKit.blue);
      var xAxis = id + " x";
      var yAxis = id + " y";

      var thresholdPlot = id + "Threshold";
      var thresholdXAxis = xAxis;
      var thresholdYAxis = yAxis;

      chart1.addPlot(id, {type: "Lines", hAxis: xAxis, vAxis: yAxis, markers: true, tension:5});
      chart1.addAxis(xAxis, {labels: false, majorLabels: false, minorLabels: false, minorTicks: false, minorTicks: false });
      chart1.addAxis(yAxis, {vertical: true, fixLower: "major", fixUpper: "major", min:0, max:50000});

      var aSeries = new Array();
      for (var i = 0; i < supplyHistoryData.length; i++) {
        var supplyRecord = supplyHistoryData[i];
        var xValue = i;
        var yValue = supplyRecord.Supply;
        var toolTipTxt = "Supply: " + yValue + ", ";
        if (supplyRecord.SupplyChange > 0) {
          toolTipTxt += "Increase: " + supplyRecord.SupplyChange;
        } else {
          toolTipTxt += "Decrease: " + (supplyRecord.SupplyChange * -1);
        }
        toolTipTxt += " at " + formatTimestamp(supplyRecord.Timestamp);
        aSeries.push({x: xValue, y: yValue, tooltip: toolTipTxt});
      }
      var seriesColor = "#385fad";
      chart1.addSeries("Supply", aSeries, {plot: id, stroke: {color:seriesColor, width:1}});
      
      new dojox.charting.action2d.Highlight(chart1, id);
      new dojox.charting.action2d.Magnify(chart1, id);
      new dojox.charting.action2d.Tooltip(chart1, id);

      chart1.addPlot(thresholdPlot, {type: "Areas", lines: false, areas: true, markers: false, hAxis: thresholdXAxis, vAxis: thresholdYAxis, tension:0});
      var thresholdSeries = new Array();
      thresholdSeries.push({x: 0, y: SUPPLY_THRESHOLD_1});
      thresholdSeries.push({x: supplyHistoryData.length, y: SUPPLY_THRESHOLD_1});
      chart1.addSeries("SupplyThreshold1", thresholdSeries, {plot: thresholdPlot, stroke: {color:"#808080", width:0}, fill: "#ff8282"});
      thresholdSeries = new Array();
      thresholdSeries.push({x: 0, y: SUPPLY_THRESHOLD_2});
      thresholdSeries.push({x: supplyHistoryData.length, y: SUPPLY_THRESHOLD_2});
      chart1.addSeries("SupplyThreshold2", thresholdSeries, {plot: thresholdPlot, stroke: {color:"#808080", width:0}, fill: "lightblue"});

      chart1.render();
      
    }


    //
    // Build a bar graph from the Purchase_Averages store data
    //
    // The X axis in the chart will be raltive time (with indeterminate points and scale)
    // The Y axis in the chart will be the average weather score at time of purchase
   
    // 
    // @param id The id of the graph will be used to name elements in the chart2d elements
    //           and will be used to construct the following <div> ids:
    //           - "{id}Graph" will be the id of the div into which the chart will be rendered
    function buildPurchaseAveragesChart(id) {
    

      logToConsole(1, "buildPurchaseAveragesChart - Building " + id + " bar chart");

      var chartDiv = id + "Graph";
      
      // Delete old chart, if any
      var list = dojo.byId(chartDiv);
      if (list) {
        while (list.firstChild) {
          list.removeChild(list.firstChild);
        }
      }


      var chart1 = new dojox.charting.Chart2D(chartDiv);
      chart1.setTheme(dojox.charting.themes.PlotKit.blue);

      chart1.addAxis("y", {vertical: true, min: 0, max:1200});
      chart1.addPlot("default", {type: "Columns", gap: 2});

      var aSeries = new Array();
      for (var i = 0; i < purchaseAveragesData.length; i++) {
        var yValue = purchaseAveragesData[i].Average;
        aSeries.push(yValue);
      }
      chart1.addSeries("Averages", aSeries, {stroke: {color: "black"}, fill: "green"});
      
      new dojox.charting.action2d.Highlight(chart1, "default");
      new dojox.charting.action2d.Tooltip(chart1, "default");
      
      chart1.render();
    }
    

    //
    // Build a pie chart from the Purchase_Transactions store data
    //
    // 
    // @param id The id of the graph will be used to name elements in the chart2d elements
    //           and will be used to construct the following <div> ids:
    //           - "{id}Graph" will be the id of the div into which the chart will be rendered
    function buildPurchaseDistributionChart(id) {

      logToConsole(1, "buildPurchaseDistributionChart - Building " + id + " pie chart");

      var chartDiv = id + "Graph";
      
      // Delete old chart, if any
      var list = dojo.byId(chartDiv);
      if (list) {
        while (list.firstChild) {
          list.removeChild(list.firstChild);
        }
      }


      var chart1 = new dojox.charting.Chart2D(chartDiv);
      chart1.addPlot("default", {
        type: "Pie",
        font: "normal normal 9pt san-serif",
        fontColor: "black",
        labelOffset: -30,
        radius: 50
      });
      var aSeries = new Array();
      for (aLocation in purchaseTransactionsData) {
        var locationRecords = purchaseTransactionsData[aLocation];
        var totalAmount = 0; 
        for (var i = 0; i < locationRecords.length; i++) {
           totalAmount += locationRecords[i].AmountPurchased;
        }

        if (totalAmount > 0 && purchaseTransactionsAmountPurchased > 0) {
          var percent = (Math.round((totalAmount / purchaseTransactionsAmountPurchased) * 1000)/10);
          var toolTipText = aLocation + ": " + totalAmount + " - " + percent + "%";
          var seriesColor = locationChartingColors[aLocation];
          aSeries.push({
                      y: totalAmount, text: aLocation, color: seriesColor, stroke: "black", tooltip: toolTipText
                      });
        }
                    
      }
      
      chart1.addSeries("Series A", aSeries);
      
      new dojox.charting.action2d.MoveSlice(chart1, "default");
      new dojox.charting.action2d.Highlight(chart1, "default");
      new dojox.charting.action2d.Tooltip(chart1, "default");
      
      chart1.render();
    }


    //
    // Build a line graph from the ratings_history store data
    //
    // The X axis in the chart will be time
    // The Y axis in the chart will be supplied by the caller in the fieldGetter parameter
   
    // 
    // @param id The id of the graph will be used to name elements in the chart2d elements
    //           and will be used to construct the following <div> ids:
    //           - "{id}Graph" will be the id of the div into which the chart will be rendered
    // @param fieldGetter - a function to return a history data value from a record
    // @param fieldFormatter - a function to format the field value or null
    // @param maxYValue - the maximum value on the Y axis
    // @param includeStations - an array of Station IDs to be included in the chart, or null to include all
    function buildRatingsHistoryChart(id, fieldGetter, fieldFormatter, maxYValue, includeStations) {
      var chartDiv = id + "Graph";
      
      var chartNode = dojo.byId(chartDiv);
      if (chartNode) {
        while (chartNode.firstChild) {
          chartNode.removeChild(chartNode.firstChild);
        }
      }

      var xAxis = id + " x";
      var yAxis = id + " y";
      logToConsole(1, "buildRatingsHistoryChart - Building " + id + " line chart");
      

      var chart1 = new dojox.charting.Chart2D(chartDiv);
      chart1.setTheme(dojox.charting.themes.PlotKit.blue);

      chart1.addPlot(id, {type: "Lines", hAxis: xAxis, vAxis: yAxis, markers: true, tension:5});
      
      chart1.addAxis(xAxis, {labels: false, majorLabels: false, includeZero: false });
      chart1.addAxis(yAxis, {vertical: true, fixLower: "false", fixUpper: "false", min:0, max: maxYValue});
      
      var seriesNbr = 0;
      var aLocation;
      for (aStation in rankingsHistoryData) {
        if (includeStations == null || in_array(includeStations, aStation) ) {
          var historyData = rankingsHistoryData[aStation];
          if (historyData.length > 1) {
            var aSeries = new Array();
            for (var i = 0; i < historyData.length; i++) {
              aLocation = historyData[i].Location;
              var xValue = historyData[i].Timestamp;
              var yValue = fieldGetter(historyData[i]);
              var yTipValue = yValue;
              if (fieldFormatter != null) {
                yTipValue = fieldFormatter(yValue);
              }
              var toolTipTxt = historyData[i].Location + " " + yTipValue + ", " + formatTimestamp(new Date(historyData[i].Timestamp));
              aSeries.push({x: xValue, y: yValue, tooltip: toolTipTxt});
            }
            var seriesColor = stationChartingColors[aStation];
            chart1.addSeries(aLocation, aSeries, {plot: id, stroke: {color:seriesColor, width:1}});
            seriesNbr++;
          }
        }
      }

      new dojox.charting.action2d.Magnify(chart1, id);
      new dojox.charting.action2d.Highlight(chart1, id);
      new dojox.charting.action2d.Tooltip(chart1, id);
      
      if (seriesNbr > 0) {
        chart1.render();
      } else {
        var para = document.createElement("p");
        para.appendChild(document.createTextNode("Not enough history data is available."));
        while (chartNode.firstChild) {
          chartNode.removeChild(chartNode.firstChild);
        }
        chartNode.appendChild(para);
      }

    }

    //
    // Build a line graph from the weather history data
    //
    // The X axis in the chart will be time 
    // The Y axis in the chart will be supplied by the caller in the fieldGetter parameter
   
    // 
    // @param id The id of the graph will be used to name elements in the chart2d elements
    //           and will be used to construct the following <div> ids:
    //           - "{id}Graph" will be the id of the div into which the chart will be rendered
    // @param fieldGetter - a function to return a history data value from a record
    // @param fieldFormatter - a function to format the field value or null
    // @param maxYValue - the maximum value on the Y axis
    // @param includeStations - an array of Station IDs to be included in the chart, or null to include all
    function buildWeatherHistoryChart(id, fieldGetter, fieldFormatter, maxYValue, includeStations) {
      var chartDiv = id + "Graph";
      
      var chartNode = dojo.byId(chartDiv);
      if (chartNode) {
        while (chartNode.firstChild) {
          chartNode.removeChild(chartNode.firstChild);
        }
      }

      var xAxis = id + " x";
      var yAxis = id + " y";
      logToConsole(1, "buildWeatherHistoryChart - Building " + id + " chart");
      
     

      var chart1 = new dojox.charting.Chart2D(chartDiv);
      chart1.setTheme(dojox.charting.themes.PlotKit.blue);

      chart1.addPlot(id, {type: "Lines", hAxis: xAxis, vAxis: yAxis, markers: true, tension:5});

      chart1.addAxis(xAxis, {labels: false, majorLabels: false, minorLabels: false, minorTicks: false, includeZero: false });
      chart1.addAxis(yAxis, {vertical: true, fixLower: "major", fixUpper: "major", min:0, max: maxYValue});
      
      var seriesNbr = 0;
      var aLocation;
      for (aStation in weatherHistoryData) {
        if (includeStations == null || in_array(includeStations, aStation) ) {
          var historyData = weatherHistoryData[aStation];
          if (historyData.length > 1) {
            var stationDefinition = stationDefinitions[aStation];
            var aSeries = new Array();
            for (var i = 0; i < historyData.length; i++) {
              aLocation = stationDefinition.City;
              var xValue = historyData[i].Timestamp;
              var yValue = fieldGetter(historyData[i]);
              var yTipValue = yValue;
              if (fieldFormatter != null) {
                yTipValue = fieldFormatter(yValue);
              }
              var toolTipTxt = aLocation + " " + yTipValue + ", " + formatTimestamp(historyData[i].Timestamp);
              aSeries.push({x: xValue, y: yValue, tooltip: toolTipTxt});
            }
            var seriesColor = stationChartingColors[aStation];
            chart1.addSeries(aLocation, aSeries, {plot: id, stroke: {color:seriesColor, width:1}});
            seriesNbr++;
          }
        }
      }

      new dojox.charting.action2d.Magnify(chart1, id);
      new dojox.charting.action2d.Highlight(chart1, id);
      new dojox.charting.action2d.Tooltip(chart1, id);
      
      if (seriesNbr > 0) {
        chart1.render();
      } else {
        var para = document.createElement("p");
        para.appendChild(document.createTextNode("Not enough history data is available."));
        while (chartNode.firstChild) {
          chartNode.removeChild(chartNode.firstChild);
        }
        chartNode.appendChild(para);
      }

    }


    // Helper function to create a record object from data
    // in the ratings_history cvs data store.
    function createHistoryRecord(item, store) {
      var aRecord = {"Location":store.getValue(item, "Location")
                     ,"WeatherScore": parseInt(store.getValue(item, "WeatherScore"))
                     ,"Station": store.getValue(item, "Station")
                     ,"TempDelta": parseFloat(store.getValue(item, "TempDelta"))
                     ,"AvgTemp": parseFloat(store.getValue(item, "AvgTemp"))
                     ,"RelativeHumidity": parseFloat(store.getValue(item, "RelativeHumidity"))
                     ,"Timestamp": parseInt(store.getValue(item, "Timestamp"))
                     };
      return aRecord;
    }

    // Helper function to create a record object from detail data
    // in the weather_history cvs data store.
    function createWeatherHistoryRecord(item, store) {
      var aRecord = {"Station": store.getValue(item, "Station")
                    ,"Timestamp": parseInt(store.getValue(item, "Timestamp"))
                    ,"TempInC": parseFloat(store.getValue(item, "TempInC"))
                    ,"Temperature": parseFloat(store.getValue(item, "Temperature"))
                    ,"RelativeHumidity": parseFloat(store.getValue(item, "RelativeHumidity")) * 100.0
                    ,"Dewpoint": parseFloat(store.getValue(item, "Dewpoint"))
                    ,"WindHeadingDegrees": parseInt(store.getValue(item, "WindHeadingDegrees"))
                    ,"WindSpeedKnots": parseInt(store.getValue(item, "WindSpeedKnots"))
                    ,"WindGustKnots": parseInt(store.getValue(item, "WindGustKnots"))
                    };
      return aRecord;
    }

    // Helper function to create a record object from station-related data
    // in the weather_history cvs data store.
    function createStationDefinitionRecord(item, store) {
      var aRecord = {"Station": store.getValue(item, "Station")
                    ,"City":store.getValue(item, "City")
                    ,"State": store.getValue(item, "State")
                    ,"County": store.getValue(item, "County")
                    ,"Latitude": parseFloat(store.getValue(item, "Latitude"))
                    ,"Longitude": parseFloat(store.getValue(item, "Longitude"))
                    };
      return aRecord;
    }

    // Helper function to format a degrees value for display
	// LAW
	formatDegrees = function(value) {
      var floatValue = parseFloat(value);
      floatValue = (Math.round(floatValue * 10)/10); // Round to 1 decimal place
      return floatValue + '&deg;';
    } 

    // Helper function to format a relative humidity value (from fractional) for display
	// LAW
    formatHumidity = function(value){
      var floatValue = parseFloat(value);
      return (Math.round(floatValue * 10000)/100) + '%';  // Round to two decimal places
    }

     // Helper function to format a relative humidity value (from percentage) for display
    function formatHumidityFromPercent(value){
      var floatValue = parseFloat(value);
      return (Math.round(floatValue * 100)/100) + '%';  // Round to two decimal places
    }

    // Helper function to format a date for display in the format:
    //     mm/dd  hh:mm[am|pm]
    function formatMonthDayHourMinute(aDate) {
      var label = (aDate.getMonth()+1) + "/" +  aDate.getDate() + " ";
      var mins = aDate.getMinutes();
      if (mins < 10) {
        mins = "0" + mins;
      }
      var ampm = "am";
      var hours = aDate.getHours();
      if (hours == 0) {
        hours = 12;
      } else if (hours == 12) {
        ampm = "pm";
      } else if (hours > 12) {
        ampm = "pm";
        hours -= 12; 
      }
      label += hours + ":" + mins + ampm
      return label;
    }
    
    // Given a timestamp, return a formated date/time
	//LAW
    formatTimestamp = function(aTimestamp) {
      return formatMonthDayHourMinute(new Date(aTimestamp * 1000)); // Timestamps in csv files do not includ millis
    }

    function logToConsole(level, line) {
      if (console && (level <= LOGGING_LEVEL)) {
        console.log(line);
      } else if (level <= LOGGING_LEVEL) {
        alert(line);
      }
    }
    
    function in_array(array, obj) {
      if (array.constructor != Array) return false;
      for (i in array) {
        if (array[i] == obj) return true;
      }
      return false;
    }
    

    // Callback comparator function for sorting an array of history records based on timestamp
    function sortTimestamps(a, b) {
      if (a.Timestamp == b.Timestamp) return 0;
      if (a.Timestamp < b.Timestamp) return -1;
      return 1;
    }

    function toggleHistory(divId, imgId, expandImg, collapseImg) {
      var div = document.getElementById(divId);
      var img = document.getElementById(imgId);
      if (img.src.indexOf(expandImg) >= 0) {
        img.src = collapseImg;
        dojo.fx.wipeIn({
          node: dojo.byId(divId),
          duration: 300
        }).play();
      } else {
        img.src = expandImg;
        dojo.fx.wipeOut({
          node: dojo.byId(divId),
          duration: 300
        }).play();

      }
    }

    // CsvStore return all values as strings, so they are compared alphabetically, not numerically
    // This function compares two strings after converting them to integer values
    function compareIntegerString(value1, value2) {
      var integer1 = parseInt(value1);
      var integer2 = parseInt(value2);
      if (integer1 == integer2) return 0;
      if (integer1 < integer2) return -1;
      return 1;
    }

    // CsvStore return all values as strings, so they are compared alphabetically, not numerically
    // This function compares two strings after converting them to float values
    function compareFloatString(value1, value2) {
      var float1 = parseFloat(value1);
      var float2 = parseFloat(value2);
      if (float1 == float2) return 0;
      if (float1 < float2) return -1;
      return 1;
    }

      parser.parse();
});//end of ready
});
