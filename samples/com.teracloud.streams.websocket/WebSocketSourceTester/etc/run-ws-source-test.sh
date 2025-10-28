#!/usr/bin/bash
#
#--------------------------------------------------------------------
# First created on: Apr/23/2020
# Last modified on: Aug/31/2020
#
# This is a script that I used to test the WebSocketSource operator in
# our Streams lab in New York. You can make minor changes here and
# use it in your test environment. It allows to run the WebSocketSourceTester
# application along with 3 other test client applications running on 
# different Streams instances. That will test the WebSocketSource 
# operator's capabilities.
#
# This script also runs another application containing both the 
# client side and server side logic inside of it. It is a self contained 
# application that includes both the HTTP POST client and the 
# WebSocketSource server to demonstrate the one way data transfer of 
# binary data from a HTTP Client to a WebSocket endpoint.
# Here, the client side will read the contents of the /usr/bin/tar file and send it
# via HTTP POST to the server side where the WebSocketSource operator will
# receive it and write it to a binary file in the data directory.
#
# IMPORTANT
# ---------
# Before using this script, you must first build all the examples provided in
# the samples sub-directory of this toolkit. You should first run 'make' from 
# every example directory to complete the build process and then you can use 
# this particular script by customizing it to suit your Streams test environment.
#--------------------------------------------------------------------
#
# ===================================================
echo Starting the WebSocketSourceTester.
# Start the WebSocketSourceTester on instance i1
# [Please note that this application offers many submission time parameters. We are using only a few here.]
streamtool submitjob -d d1 -i i1 ~/workspace32/WebSocketSourceTester/output/com.teracloud.streams.websocket.sample.WebSocketSourceTester.sab -P certificatePassword=  -P nonTlsEndpointNeeded=true -P allowHttpPost=true -P clientWhitelist='["10.6.33.13", "10.6.33.17", "10.6.100.124", "10.6.100.168", "10.6.100.169", "10.6.100.170", "10.6.100.171"]' -P numberOfMessagesToReceiveBeforeAnAck=100 -P urlContextPath='["MyServices/Banking/Deposit", "", "Love/Is/God", "Work/Is/Worship"]'

# Wait for 10 seconds
echo Sleeping for 10 seconds before starting different kinds of client applications...
sleep 10

echo Starting the WebSocketSendReceiveTester.
# Start an SPL based WebSocket client application on instance i2
# [Please note that this application offers many submission time parameters. We are using only a few here.]
streamtool submitjob -d d1 -i i2 ~/workspace32/WebSocketSendReceiveTester/output/com.teracloud.streams.websocket.sample.WebSocketSendReceiveTester.sab -P url=ws://b0513:8080/MyServices/Banking/Deposit

echo Starting the HttpPostTester.
# Start a Java based HTTP POST client application on instance i3
streamtool submitjob -d d1 -i i3 ~/workspace32/HttpPostTester/output/com.teracloud.streams.websocket.sample.HttpPostTester.sab -P Url=http://b0513:8080/ -P NumSenders=1 -P createPersistentHttpConnection=true -P LogHttpPostActions=true -P MaxMessageRate=50.0 -P MessageBatchingTime=6.0 -P httpTimeout=30 -P delayBetweenConsecutiveHttpPosts=0 -P tlsAcceptAllCertificates=true

echo Starting the WSClientDataSimulator.
# Start a C++ based WebSocket client as standalone
~/workspace32/WebSocketSourceTester/WSClientDataSimulator/wsclient.o https://b0513:8443/Love/Is/God ./creating-a-self-signed-certificate.txt txt 4096 3 100 10000
# ===================================================
echo Starting the HttpBinarySendToWebSocketSource.
# Start the other application to showcase the binary data transfer from a 
# HTTP client to a WebSocketSource (server).
streamtool submitjob -d d1 -i i1 ~/workspace32/WebSocketSourceTester/output/com.teracloud.streams.websocket.sample.HttpBinarySendToWebSocketSource.sab -P certificatePassword=  -P nonTlsEndpointNeeded=true -P allowHttpPost=true -P tlsPort=8444 -P nonTlsPort=8081 -P urlContextPath='["MyServices/Banking/Deposit", "Work/Is/Worship", ""]' -P Url=https://b0513:8444/Work/Is/Worship -P tlsAcceptAllCertificates=true -P createPersistentHttpConnection=true
# ===================================================
