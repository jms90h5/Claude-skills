This sample aggregates data volumes of various call types to hourly seen data volumes per type, which is
treated as a regular time series with one sample point every hour.

This sample uses the BoundedAnomalyDetector operator to detect anomalies (outliers) within the timeseries.

To compile the application, by invoking 'make'. Then, submit the Streams application with
'streamtool submitjob output/sample.OutliersInSeasonalDataMain.sab

The output files can be found in directory /tmp:

OutliersMarkedHourly_DATA.csv
OutliersMarkedHourly_VIDEO.csv
OutliersMarkedHourly_VOICE.csv


