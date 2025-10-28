<!-- begin_generated_IBM_Teracloud_ApS_copyright_prolog               -->
<!--                                                                  -->
<!-- This is an automatically generated copyright prolog.             -->
<!-- After initializing,  DO NOT MODIFY OR MOVE                       -->
<!-- **************************************************************** -->
<!-- THIS SAMPLE CODE IS PROVIDED ON AN "AS IS" BASIS.                -->
<!-- TERACLOUD APS AND IBM MAKES NO REPRESENTATIONS OR WARRANTIES,    -->
<!-- EXPRESS OR IMPLIED, CONCERNING  USE OF THE SAMPLE CODE, OR THE   -->
<!-- COMPLETENESS OR ACCURACY OF THE SAMPLE CODE. TERACLOUD APS       -->
<!-- AND IBM DOES NOT WARRANT UNINTERRUPTED OR ERROR-FREE OPERATION   -->
<!-- OF THIS SAMPLE CODE. TERACLOUD APS AND IBM IS NOT RESPONSIBLE FOR THE -->
<!-- RESULTS OBTAINED FROM THE USE OF THE SAMPLE CODE OR ANY PORTION  -->
<!-- OF THIS SAMPLE CODE.                                             -->
<!--                                                                  -->
<!-- LIMITATION OF LIABILITY. IN NO EVENT WILL IBM BE LIABLE TO ANY   -->
<!-- PARTY FOR ANY DIRECT, INDIRECT, SPECIAL OR OTHER CONSEQUENTIAL   -->
<!-- DAMAGES FOR ANY USE OF THIS SAMPLE CODE, THE USE OF CODE FROM    -->
<!-- THIS [ SAMPLE PACKAGE,] INCLUDING, WITHOUT LIMITATION, ANY LOST  -->
<!-- PROFITS, BUSINESS INTERRUPTION, LOSS OF PROGRAMS OR OTHER DATA   -->
<!-- ON YOUR INFORMATION HANDLING SYSTEM OR OTHERWISE.                -->
<!--                                                                  -->
<!-- (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2023, 2023     -->
<!-- All Rights reserved.                                             -->
<!--                                                                  -->
<!-- end_generated_IBM_Teracloud_ApS_copyright_prolog                 -->
This sample demonstrates how you can display geospatial data in a map using the HTTPTupleView operator, and OpenLayer APIs.

The application has a custom operator that randomly generates geospatial locations around Berlin, Germany. The
data sets are then put through a SpatialRouter operator that distributes them to three different nodes
in which the data is enriched with information that show in which stream it was processed.
 
To see this sample in action, compile and submit the main application to a streams instance.
 
To compile the application, you need:
- Streams 3.2.2 Beta - for the new com.teracloud.streams.geospatial toolkit
- com.teracloud.streams.inetserver toolkit
  
In a browser, open the following URL:  http://PEHost:8080/map/map.html
To see popup on the map, open the following URL:  http://PEHost:8080/map/map.html?popup=true


If you use the sample on your local machine with your local Streams instance, you may use the following links:
http://localhost:8080/map/map.html
and 
http://localhost:8080/map/map.html?popup=true
