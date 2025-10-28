#!/usr/bin/bash
#
#--------------------------------------------------------------------
# First created on: May/10/2020
# Last modified on: Aug/31/2020
#
# This is a script that I used to test the WebSocketSendReceive operator in
# our Streams lab in New York. You can make minor changes here and
# use it in your test environment. It allows to run the WebSocketSendReceiveTester
# application along with a test server application running on 
# different Streams instances. That will test the WebSocketSendReceive 
# operator's capabilities.
#
# IMPORTANT
# ---------
# Before using this script, you must first build all the examples provided in
# the samples sub-directory of this toolkit. You should first run 'make' from 
# every example directory to complete the build process and then you can use 
# this particular script by customizing it to suit your Streams test environment.
#--------------------------------------------------------------------
#
echo Starting WebSocketServerApp.
# Start the test server application (WebSocketServerApp) on instance i1
# [Please note that this application offers many submission time parameters. We are using only a few here.]
streamtool submitjob -d d1 -i i1 ~/workspace32/WebSocketSendReceiveTester/output/com.teracloud.streams.websocket.sample.WebSocketServerApp.sab -P certificatePassword=  -P nonTlsEndpointNeeded=true -P clientWhitelist='["10.6.33.13", "10.6.33.17", "10.6.100.124", "10.6.100.168", "10.6.100.169", "10.6.100.170", "10.6.100.171"]' -P urlContextPath='["MyServices/Banking/Deposit", "", "Love/Is/God"]'

# Wait for 10 seconds
echo Sleeping for 10 seconds before starting a copy of the WebSocketSendReceiveTester application...
sleep 10

echo Starting WebSocketSendReceiveTester.
# Start a copy of the WebSocketSendReceiveTester on instance i2
# [Please note that this application offers many submission time parameters. We are using only a few here.]
streamtool submitjob -d d1 -i i2 ~/workspace32/WebSocketSendReceiveTester/output/com.teracloud.streams.websocket.sample.WebSocketSendReceiveTester.sab -P url=wss://b0513:8443/Love/Is/God
