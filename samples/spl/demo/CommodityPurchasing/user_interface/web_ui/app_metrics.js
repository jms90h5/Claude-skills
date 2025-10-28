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
// Javascript for Commodity Purchasing application metrics


// Constants

    var LOGGING_LEVEL = 2;           // Set logging level for logging debug/trace messages to console
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
	"dojox/data/CsvStore",
 	"dojox/charting/Chart2D",
	"dojox/charting/widget/Legend",
     	"dojox/charting/action2d/Highlight",
     	"dojox/charting/action2d/Magnify",
      	"dojox/charting/action2d/Tooltip",
  	"dojox/charting/action2d/MoveSlice",
     	"dojox/charting/themes/PlotKit/blue"

     ], function(
	ready,
	fx,
	dom,
	CsvStore,
	Chart2D,
	Legend,
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

    // Total Tuples
    //
    // Fields: 
    //     TotalTuples
    //     Timestamp
    var total_tuples =  new dojox.data.CsvStore({ url: DATA_PATH + "Total_Weather_Tuples.csv",   label: "TotalTuples" });

    // Tuples Per Minute
    //
    // Fields:
    //     TotalTuples
    //     Timestamp
    var tuples_minute =  new dojox.data.CsvStore({ url: DATA_PATH + "Weather_Tuples_Per_Minute.csv" });   

    // Filtered Tuples
    //
    // Fields: 
    //     TotalTuples
    //     Timestamp
    var filtered_tuples =  new dojox.data.CsvStore({ url: DATA_PATH + "Filtered_Weather_Tuples.csv",   label: "FilteredTuples" });

    // Filtered Per Minute
    //
    // Fields:
    //     TotalTuples
    //     Timestamp
    var filtered_minute =  new dojox.data.CsvStore({ url: DATA_PATH + "Filtered_Tuples_Per_Minute.csv" });   

    // W&W
    //
    // Fields: 
    //     TotalTuples
    //     Timestamp
    var total_ww =  new dojox.data.CsvStore({ url: DATA_PATH + "Total_WatchesAndWarnings.csv",   label: "TotalTuples" });

    // W&W Per Minute
    //
    // Fields:
    //     TotalTuples
    //     Timestamp
    var ww_minute =  new dojox.data.CsvStore({ url: DATA_PATH + "WatchesAndWarnings_Per_Minute.csv" });   

    // Total Scores
    //
    // Fields: 
    //     TotalTuples
    //     Timestamp
    var total_scores =  new dojox.data.CsvStore({ url: DATA_PATH + "Total_Weather_Scores.csv",   label: "TotalTuples" });



    
   
    // Array of records loaded from total tuples store
    var totalTuplesData = new Array();

    // Array of records loaded from tuples_minute store
    var tuplesMinuteData = new Array();
    
    // Array of records loaded from filtered tuples store
    var filteredTuplesData = new Array();

    // Array of records loaded from filtered_minute store
    var filteredMinuteData = new Array();

    // Array of records loaded from total W&W store
    var totalwwData = new Array();

    // Array of records loaded from total W&W store
    var wwMinuteData = new Array();

    // Array of records loaded from total scores store
    var totalScoresData = new Array();

    
    
      total_tuples.fetch(
        {
        query: {TotalTuples: "*"},
        onComplete: onTotalTuplesComplete
        }
      );

      tuples_minute.fetch(
        {
        query: {Timestamp: "*"},
        onComplete: onTuplesMinuteComplete
        }
      );

      filtered_tuples.fetch(
        {
        query: {TotalTuples: "*"},
        onComplete: onFilteredTuplesComplete
        }
      );

      filtered_minute.fetch(
        {
        query: {Timestamp: "*"},
        onComplete: onFilteredMinuteComplete
        }
      );

      total_ww.fetch(
        {
        query: {TotalTuples: "*"},
        onComplete: onWwComplete
        }
      );

      ww_minute.fetch(
        {
        query: {Timestamp: "*"},
        onComplete: onWwMinuteComplete
        }
      );

      total_scores.fetch(
        {
        query: {TotalTuples: "*"},
        onComplete: onTotalScoresComplete
        }
      );



    // Callback function to handle onComplete event when all items have been fetched from the total tuples store
    //
    // The total tuples store has a record every minute
    function onTotalTuplesComplete(items, request) {
      logToConsole(1, "onTotalTuplesComplete - Number of values found: " + items.length);
      var start = 0;
      for (var i = start; i < items.length; i++) {
        var item = items[i];
        var totalTuplesValue = parseInt(total_tuples.getValue(item, "TotalTuples"));
        var totalTuplesRecord = {"TotalTuples": parseInt(total_tuples.getValue(item, "TotalTuples"))
                     ,"Timestamp": parseInt(total_tuples.getValue(item, "Timestamp"))
                     };
        totalTuplesData.push(totalTuplesRecord);
      }
      buildTotalTuplesChart("TotalTuples");
    }
    

    // Callback function to handle onComplete event when all items have been fetched from the Tuples_Minute store
    //
    function onTuplesMinuteComplete(items, request) {
      logToConsole(1, "onTuplesMinuteComplete - Number of values found: " + items.length);
      var start = 0;
      for (var i = start; i < items.length; i++) {
        var item = items[i];

        if (i > 0) {
          var h = i - 1;
          var latestTS = parseInt(tuples_minute.getValue(item, "Timestamp"));
          var prevTS = parseInt(tuples_minute.getValue(items[h], "Timestamp"));
          var timeDiff = latestTS - prevTS;
          while (timeDiff > 60) {
            prevTS = prevTS + 60;
            var fillInRecord = {"TotalTuples": 0,
                                "Timestamp": prevTS};
            tuplesMinuteData.push(fillInRecord);
            timeDiff = latestTS - prevTS;
          }

        }

        var tuplesMinuteRecord = {"TotalTuples":   parseInt(tuples_minute.getValue(item, "TotalTuples"))
                                   ,"Timestamp": parseInt(tuples_minute.getValue(item, "Timestamp"))
                     };
        tuplesMinuteData.push(tuplesMinuteRecord);
      }
      buildTuplesMinuteChart("TuplesMinute");
    }



    // Callback function to handle onComplete event when all items have been fetched from the total tuples store
    //
    // The total tuples store has a record every minute
    function onFilteredTuplesComplete(items, request) {
      logToConsole(1, "onFilteredTuplesComplete - Number of values found: " + items.length);
      var start = 0;
      for (var i = start; i < items.length; i++) {
        var item = items[i];
        var filteredTuplesValue = parseInt(filtered_tuples.getValue(item, "TotalTuples"));
        var filteredTuplesRecord = {"TotalTuples": parseInt(filtered_tuples.getValue(item, "TotalTuples"))
                     ,"Timestamp": parseInt(filtered_tuples.getValue(item, "Timestamp"))
                     };
        filteredTuplesData.push(filteredTuplesRecord);
      }
      buildFilteredTuplesChart("FilteredTuples");
    }
    

    // Callback function to handle onComplete event when all items have been fetched from the Tuples_Minute store
    //
    function onFilteredMinuteComplete(items, request) {
      logToConsole(1, "onFilteredMinuteComplete - Number of values found: " + items.length);
      var start = 0;
      for (var i = start; i < items.length; i++) {
        var item = items[i];

        if (i > 0) {
          var h = i - 1;
          var latestTS = parseInt(filtered_minute.getValue(item, "Timestamp"));
          var prevTS = parseInt(filtered_minute.getValue(items[h], "Timestamp"));
          var timeDiff = latestTS - prevTS;
          while (timeDiff > 60) {
            prevTS = prevTS + 60;
            var fillInRecord = {"TotalTuples": 0,
                                "Timestamp": prevTS};
            filteredMinuteData.push(fillInRecord);
            timeDiff = latestTS - prevTS;
          }

        }

        var filteredMinuteRecord = {"TotalTuples":   parseInt(filtered_minute.getValue(item, "TotalTuples"))
                                   ,"Timestamp": parseInt(filtered_minute.getValue(item, "Timestamp"))
                     };
        filteredMinuteData.push(filteredMinuteRecord);
      }
      buildFilteredMinuteChart("FilteredMinute");
    }


    // Callback function to handle onComplete event when all items have been fetched from the ww store
    //
    // The total tuples store has a record every minute
    function onWwComplete(items, request) {
      logToConsole(1, "onWwComplete - Number of values found: " + items.length);
      var start = 0;
      for (var i = start; i < items.length; i++) {
        var item = items[i];
        var wwTuplesValue = parseInt(total_ww.getValue(item, "TotalTuples"));
        var wwTuplesRecord = {"TotalTuples": parseInt(total_ww.getValue(item, "TotalTuples"))
                     ,"Timestamp": parseInt(total_ww.getValue(item, "Timestamp"))
                     };
        totalwwData.push(wwTuplesRecord);
      }
      buildwwTuplesChart("WWTotal");
    }
    

    // Callback function to handle onComplete event when all items have been fetched from the Tuples_Minute store
    //
    function onWwMinuteComplete(items, request) {
      logToConsole(1, "onWwMinuteComplete - Number of values found: " + items.length);
      var start = 0;
      for (var i = start; i < items.length; i++) {
        var item = items[i];

        if (i > 0) {
          var h = i - 1;
          var latestTS = parseInt(ww_minute.getValue(item, "Timestamp"));
          var prevTS = parseInt(ww_minute.getValue(items[h], "Timestamp"));
          var timeDiff = latestTS - prevTS;
          while (timeDiff > 60) {
            prevTS = prevTS + 60;
            var fillInRecord = {"TotalTuples": 0,
                                "Timestamp": prevTS};
            wwMinuteData.push(fillInRecord);
            timeDiff = latestTS - prevTS;
          }

        }

        var wwMinuteRecord = {"TotalTuples":   parseInt(ww_minute.getValue(item, "TotalTuples"))
                                   ,"Timestamp": parseInt(ww_minute.getValue(item, "Timestamp"))
                     };
        wwMinuteData.push(wwMinuteRecord);
      }
      buildwwMinuteChart("WWMinute");
    }

    // Callback function to handle onComplete event when all items have been fetched from the total scores store
    //
    // The total scores store has a record every minute
    function onTotalScoresComplete(items, request) {
      logToConsole(1, "onTotalScoresComplete - Number of values found: " + items.length);
      var start = 0;
      for (var i = start; i < items.length; i++) {
        var item = items[i];
        var totalScoresValue = parseInt(total_scores.getValue(item, "TotalTuples"));
        var totalScoresRecord = {"TotalTuples": parseInt(total_scores.getValue(item, "TotalTuples"))
                     ,"Timestamp": parseInt(total_scores.getValue(item, "Timestamp"))
                     };
        totalScoresData.push(totalScoresRecord);
      }
      buildTotalScoresChart("TotalScores");
    }






    //
    // Build a line graph from the total tuples data
    //
   
    // 
    // @param id The id of the graph will be used to name elements in the chart2d elements
    //           and will be used to construct the following <div> ids:
    //           - "{id}Graph" will be the id of the div into which the chart will be rendered
    //           - "{id}Legend" will be the id of the div into which the chart legend will be rendered
    function buildTotalTuplesChart(id) {

      logToConsole(1, "buildTotalTuplesChart - Building " + id + " line chart");

      var chartDiv = id + "Graph";
      
      // Delete old chart, if any
      var list = dom.byId(chartDiv);
			if (list) {
			  while (list.firstChild) {
			    list.removeChild(list.firstChild);
			  }
			}


      var chart1 = new dojox.charting.Chart2D(chartDiv);
      chart1.setTheme(dojox.charting.themes.PlotKit.blue);
      var xAxis = id + " x";
      var yAxis = id + " y";

      chart1.addPlot(id, {type: "Lines", hAxis: xAxis, vAxis: yAxis, markers: true, tension:5});
      chart1.addAxis(xAxis, {includeZero: false, majorLabels: false, minorLabels: false, minorTicks: false, minorTicks: false });
      chart1.addAxis(yAxis, {vertical: true, fixLower: "major", fixUpper: "major", min:0});

			var aSeries = new Array();
			for (var i = 0; i < totalTuplesData.length; i++) {
			  var totalTuples = totalTuplesData[i];
				var xValue = totalTuples.Timestamp;
				var yValue = totalTuples.TotalTuples;
				var toolTipTxt = "Weather Tuples: " + yValue + ", ";
			  toolTipTxt += " at " + formatTimestamp(totalTuples.Timestamp);
				aSeries.push({x: xValue, y: yValue, tooltip: toolTipTxt});
			}
   		var seriesColor = "#385fad";
			chart1.addSeries("TotalTuples", aSeries, {plot: id, stroke: {color:seriesColor, width:1}});
      var anim1a = new dojox.charting.action2d.Highlight(chart1, id);
      var anim1b = new dojox.charting.action2d.Magnify(chart1, id);
      var anim1Tooltip = new dojox.charting.action2d.Tooltip(chart1, id);

      chart1.render();
      
    }



    function buildTuplesMinuteChart(id) {

      logToConsole(1, "buildTuplesMinuteChart - Building " + id + " line chart");

      var chartDiv = id + "Graph";
      
      // Delete old chart, if any
      var list = dom.byId(chartDiv);
			if (list) {
			  while (list.firstChild) {
			    list.removeChild(list.firstChild);
			  }
			}


      var chart1 = new dojox.charting.Chart2D(chartDiv);
      chart1.setTheme(dojox.charting.themes.PlotKit.blue);

      var xAxis = id + " x";
      var yAxis = id + " y";

      chart1.addPlot(id, {type: "Lines", hAxis: xAxis, vAxis: yAxis, markers: true, tension:5});
      chart1.addAxis(xAxis, {includeZero: false, majorLabels: false, minorLabels: false, minorTicks: false, minorTicks: false });
      chart1.addAxis(yAxis, {vertical: true, fixLower: "major", fixUpper: "major", min:0});

			var aSeries = new Array();
			for (var i = 0; i < tuplesMinuteData.length; i++) {
			  var tuplesMinute = tuplesMinuteData[i];
				var xValue = tuplesMinute.Timestamp;
				var yValue = tuplesMinute.TotalTuples;
				var toolTipTxt = "Weather Tuples: " + yValue + ", ";
			  toolTipTxt += " at " + formatTimestamp(tuplesMinute.Timestamp);
				aSeries.push({x: xValue, y: yValue, tooltip: toolTipTxt});
			}
   		var seriesColor = "#385fad";
			chart1.addSeries("TotalTuples", aSeries, {plot: id, stroke: {color:seriesColor, width:1}});
      var anim1a = new dojox.charting.action2d.Highlight(chart1, id);
      var anim1b = new dojox.charting.action2d.Magnify(chart1, id);
      var anim1Tooltip = new dojox.charting.action2d.Tooltip(chart1, id);

      chart1.render();
      
    }


    //
    // Build a line graph from the filtered tuples data
    //
   
    // 
    // @param id The id of the graph will be used to name elements in the chart2d elements
    //           and will be used to construct the following <div> ids:
    //           - "{id}Graph" will be the id of the div into which the chart will be rendered
    //           - "{id}Legend" will be the id of the div into which the chart legend will be rendered

    function buildFilteredTuplesChart(id) {

      logToConsole(1, "buildFilteredTuplesChart - Building " + id + " line chart");

      var chartDiv = id + "Graph";
      
      // Delete old chart, if any
      var list = dom.byId(chartDiv);
			if (list) {
			  while (list.firstChild) {
			    list.removeChild(list.firstChild);
			  }
			}


      var chart1 = new dojox.charting.Chart2D(chartDiv);
      chart1.setTheme(dojox.charting.themes.PlotKit.blue);
      var xAxis = id + " x";
      var yAxis = id + " y";

      chart1.addPlot(id, {type: "Lines", hAxis: xAxis, vAxis: yAxis, markers: true, tension:5});
      chart1.addAxis(xAxis, {includeZero: false, majorLabels: false, minorLabels: false, minorTicks: false, minorTicks: false });
      chart1.addAxis(yAxis, {vertical: true, fixLower: "major", fixUpper: "major", min:0});

			var aSeries = new Array();
			for (var i = 0; i < filteredTuplesData.length; i++) {
			  var filteredTuples = filteredTuplesData[i];
				var xValue = filteredTuples.Timestamp;
				var yValue = filteredTuples.TotalTuples;
				var toolTipTxt = "Weather Tuples: " + yValue + ", ";
			  toolTipTxt += " at " + formatTimestamp(filteredTuples.Timestamp);
				aSeries.push({x: xValue, y: yValue, tooltip: toolTipTxt});
			}
   		var seriesColor = "#385fad";
			chart1.addSeries("TotalTuples", aSeries, {plot: id, stroke: {color:seriesColor, width:1}});
      var anim1a = new dojox.charting.action2d.Highlight(chart1, id);
      var anim1b = new dojox.charting.action2d.Magnify(chart1, id);
      var anim1Tooltip = new dojox.charting.action2d.Tooltip(chart1, id);

      chart1.render();
      
    }



    function buildFilteredMinuteChart(id) {

      logToConsole(1, "buildFilteredMinuteChart - Building " + id + " line chart");

      var chartDiv = id + "Graph";
      
      // Delete old chart, if any
      var list = dom.byId(chartDiv);
			if (list) {
			  while (list.firstChild) {
			    list.removeChild(list.firstChild);
			  }
			}


      var chart1 = new dojox.charting.Chart2D(chartDiv);
      chart1.setTheme(dojox.charting.themes.PlotKit.blue);

      var xAxis = id + " x";
      var yAxis = id + " y";

      chart1.addPlot(id, {type: "Lines", hAxis: xAxis, vAxis: yAxis, markers: true, tension:5});
      chart1.addAxis(xAxis, {includeZero: false, majorLabels: false, minorLabels: false, minorTicks: false, minorTicks: false });
      chart1.addAxis(yAxis, {vertical: true, fixLower: "major", fixUpper: "major", min:0});

			var aSeries = new Array();
			for (var i = 0; i < filteredMinuteData.length; i++) {
			  var filteredMinute = filteredMinuteData[i];
				var xValue = filteredMinute.Timestamp;
				var yValue = filteredMinute.TotalTuples;
				var toolTipTxt = "Weather Tuples: " + yValue + ", ";
			  toolTipTxt += " at " + formatTimestamp(filteredMinute.Timestamp);
				aSeries.push({x: xValue, y: yValue, tooltip: toolTipTxt});
			}
   		var seriesColor = "#385fad";
			chart1.addSeries("TotalTuples", aSeries, {plot: id, stroke: {color:seriesColor, width:1}});
      var anim1a = new dojox.charting.action2d.Highlight(chart1, id);
      var anim1b = new dojox.charting.action2d.Magnify(chart1, id);
      var anim1Tooltip = new dojox.charting.action2d.Tooltip(chart1, id);

      chart1.render();
      
    }



    //
    // Build a line graph from the ww tuples data
    //
   
    // 
    // @param id The id of the graph will be used to name elements in the chart2d elements
    //           and will be used to construct the following <div> ids:
    //           - "{id}Graph" will be the id of the div into which the chart will be rendered
    //           - "{id}Legend" will be the id of the div into which the chart legend will be rendered

    function buildwwTuplesChart(id) {

      logToConsole(1, "buildwwTuplesChart - Building " + id + " line chart");

      var chartDiv = id + "Graph";
      
      // Delete old chart, if any
      var list = dom.byId(chartDiv);
			if (list) {
			  while (list.firstChild) {
			    list.removeChild(list.firstChild);
			  }
			}


      var chart1 = new dojox.charting.Chart2D(chartDiv);
      chart1.setTheme(dojox.charting.themes.PlotKit.blue);
      var xAxis = id + " x";
      var yAxis = id + " y";

      chart1.addPlot(id, {type: "Lines", hAxis: xAxis, vAxis: yAxis, markers: true, tension:5});
      chart1.addAxis(xAxis, {includeZero: false, majorLabels: false, minorLabels: false, minorTicks: false, minorTicks: false });
      chart1.addAxis(yAxis, {vertical: true, fixLower: "major", fixUpper: "major", min:0});

			var aSeries = new Array();
			for (var i = 0; i < totalwwData.length; i++) {
			  var wwTuples = totalwwData[i];
				var xValue = wwTuples.Timestamp;
				var yValue = wwTuples.TotalTuples;
				var toolTipTxt = "Watches and Warnings: " + yValue + ", ";
			  toolTipTxt += " at " + formatTimestamp(wwTuples.Timestamp);
				aSeries.push({x: xValue, y: yValue, tooltip: toolTipTxt});
			}
   		var seriesColor = "#385fad";
			chart1.addSeries("TotalTuples", aSeries, {plot: id, stroke: {color:seriesColor, width:1}});
      var anim1a = new dojox.charting.action2d.Highlight(chart1, id);
      var anim1b = new dojox.charting.action2d.Magnify(chart1, id);
      var anim1Tooltip = new dojox.charting.action2d.Tooltip(chart1, id);

      chart1.render();
      
    }



    function buildwwMinuteChart(id) {

      logToConsole(1, "buildwwMinuteChart - Building " + id + " line chart");

      var chartDiv = id + "Graph";
      
      // Delete old chart, if any
      var list = dom.byId(chartDiv);
			if (list) {
			  while (list.firstChild) {
			    list.removeChild(list.firstChild);
			  }
			}


      var chart1 = new dojox.charting.Chart2D(chartDiv);
      chart1.setTheme(dojox.charting.themes.PlotKit.blue);

      var xAxis = id + " x";
      var yAxis = id + " y";

      chart1.addPlot(id, {type: "Lines", hAxis: xAxis, vAxis: yAxis, markers: true, tension:5});
      chart1.addAxis(xAxis, {includeZero: false, majorLabels: false, minorLabels: false, minorTicks: false, minorTicks: false });
      chart1.addAxis(yAxis, {vertical: true, fixLower: "major", fixUpper: "major", min:0});

			var aSeries = new Array();
			for (var i = 0; i < wwMinuteData.length; i++) {
			  var wwMinute = wwMinuteData[i];
				var xValue = wwMinute.Timestamp;
				var yValue = wwMinute.TotalTuples;
				var toolTipTxt = "Watches and Warnings: " + yValue + ", ";
			  toolTipTxt += " at " + formatTimestamp(wwMinute.Timestamp);
				aSeries.push({x: xValue, y: yValue, tooltip: toolTipTxt});
			}
   		var seriesColor = "#385fad";
			chart1.addSeries("TotalTuples", aSeries, {plot: id, stroke: {color:seriesColor, width:1}});
      var anim1a = new dojox.charting.action2d.Highlight(chart1, id);
      var anim1b = new dojox.charting.action2d.Magnify(chart1, id);
      var anim1Tooltip = new dojox.charting.action2d.Tooltip(chart1, id);

      chart1.render();
      
    }


    //
    // Build a line graph from the total scores data
    //
   
    // 
    // @param id The id of the graph will be used to name elements in the chart2d elements
    //           and will be used to construct the following <div> ids:
    //           - "{id}Graph" will be the id of the div into which the chart will be rendered
    //           - "{id}Legend" will be the id of the div into which the chart legend will be rendered
    function buildTotalScoresChart(id) {
  

      logToConsole(1, "buildTotalScoresChart - Building " + id + " line chart");

      var chartDiv = id + "Graph";
      
      // Delete old chart, if any
      var list = dom.byId(chartDiv);
			if (list) {
			  while (list.firstChild) {
			    list.removeChild(list.firstChild);
			  }
			}


      var chart1 = new dojox.charting.Chart2D(chartDiv);
      chart1.setTheme(dojox.charting.themes.PlotKit.blue);
      var xAxis = id + " x";
      var yAxis = id + " y";

      chart1.addPlot(id, {type: "Lines", hAxis: xAxis, vAxis: yAxis, markers: true, tension:5});
      chart1.addAxis(xAxis, {includeZero: false, majorLabels: false, minorLabels: false, minorTicks: false, minorTicks: false });
      chart1.addAxis(yAxis, {vertical: true, fixLower: "major", fixUpper: "major", min:0});

			var aSeries = new Array();
			for (var i = 0; i < totalScoresData.length; i++) {
			  var totalScores = totalScoresData[i];
				var xValue = totalScores.Timestamp;
				var yValue = totalScores.TotalTuples;
				var toolTipTxt = "Weather Scores: " + yValue + ", ";
			  toolTipTxt += " at " + formatTimestamp(totalScores.Timestamp);
				aSeries.push({x: xValue, y: yValue, tooltip: toolTipTxt});
			}
   		var seriesColor = "#385fad";
			chart1.addSeries("TotalScores", aSeries, {plot: id, stroke: {color:seriesColor, width:1}});
      var anim1a = new dojox.charting.action2d.Highlight(chart1, id);
      var anim1b = new dojox.charting.action2d.Magnify(chart1, id);
      var anim1Tooltip = new dojox.charting.action2d.Tooltip(chart1, id);

      chart1.render();
      
    }









    // Helper function to format a date for display inthe format:
    //     mm/dd  hh[am|pm]
    function formatMonthDayHour(aDate) {
      var label = (aDate.getMonth()+1) + "/" +  aDate.getDate() + " ";
      if (aDate.getHours() == 0) {
        label += "12am";
      } else if (aDate.getHours() <= 11) {
        label += aDate.getHours() + "am";
      } else if (aDate.getHours() == 12) {
        label += "12pm";
      } else {
        label += (aDate.getHours() - 12) + "pm";
      }
      return label;
    }

    // Helper function to format a date for display inthe format:
    //     mm/dd  hh:mm[am|pm]
    function formatMonthDayHourMinute(aDate) {
      var label = (aDate.getMonth()+1) + "/" +  aDate.getDate() + " ";
      var mins = aDate.getMinutes();
      if (mins < 10) {
        mins = "0" + mins;
      }
      if (aDate.getHours() == 0) {
        label += "12:00am";
      } else if (aDate.getHours() <= 11) {
        label += aDate.getHours() + ":" + mins + "am";
      } else if (aDate.getHours() == 12) {
        label += "12:00pm";
      } else {
        label += (aDate.getHours() - 12) + ":" + mins + "pm";
      }
      return label;
    }
    
    // Given a timestamp, return a formated date/time
    function formatTimestamp(aTimestamp) {
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
          node: dom.byId(divId),
          duration: 300
        }).play();
      } else {
        img.src = expandImg;
        dojo.fx.wipeOut({
          node: dom.byId(divId),
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
});
});
