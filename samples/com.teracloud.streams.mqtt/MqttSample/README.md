## Basic MQTT sample

This sample is a basic application that generates some messages, publishes them to a topic within an MQTT server, 
reads the messages from the same MQTT server and writes them into a file. You must specify the MQTT server URI as
the `serverUri` submission time parameter in the form *<server name>:<tcp port>*, for example *messagesight-01.mydomain:1884*.

### Building the sample

`make`

### Launching the application to a Streams instance

Provided you have a running Streams instance, submit the job to your default Streams instance with

`streamtool submitjob ./output/application.MqttSample.sab -P serverUri=<your server URI>`

### Cleaning the build artifacts

`make clean`
