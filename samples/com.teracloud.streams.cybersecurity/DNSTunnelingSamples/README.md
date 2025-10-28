<!-- begin_generated_Teracloud_ApS_copyright_prolog                   -->
<!--                                                                  -->
<!-- This is an automatically generated copyright prolog.             -->
<!-- After initializing,  DO NOT MODIFY OR MOVE                       -->
<!-- **************************************************************** -->
<!-- THIS SAMPLE CODE IS PROVIDED ON AN "AS IS" BASIS.                -->
<!-- TERACLOUD APS MAKES NO REPRESENTATIONS OR WARRANTIES,            -->
<!-- EXPRESS OR IMPLIED, CONCERNING  USE OF THE SAMPLE CODE, OR THE   -->
<!-- COMPLETENESS OR ACCURACY OF THE SAMPLE CODE. TERACLOUD APS       -->
<!-- DOES NOT WARRANT UNINTERRUPTED OR ERROR-FREE OPERATION           -->
<!-- OF THIS SAMPLE CODE. TERACLOUD APS AND IBM IS NOT RESPONSIBLE FOR THE -->
<!-- RESULTS OBTAINED FROM THE USE OF THE SAMPLE CODE OR ANY PORTION  -->
<!-- OF THIS SAMPLE CODE.                                             -->
<!--                                                                  -->
<!-- LIMITATION OF LIABILITY. IN NO EVENT WILL TERACLOUD APS BE LIABLE -->
<!-- TO ANY PARTY FOR ANY DIRECT, INDIRECT, SPECIAL OR OTHER CONSEQUENTIAL -->
<!-- DAMAGES FOR ANY USE OF THIS SAMPLE CODE, THE USE OF CODE FROM    -->
<!-- THIS [ SAMPLE PACKAGE,] INCLUDING, WITHOUT LIMITATION, ANY LOST  -->
<!-- PROFITS, BUSINESS INTERRUPTION, LOSS OF PROGRAMS OR OTHER DATA   -->
<!-- ON YOUR INFORMATION HANDLING SYSTEM OR OTHERWISE.                -->
<!--                                                                  -->
<!-- (C) Copyright Teracloud ApS 2024, 2025                           -->
<!-- All Rights reserved.                                             -->
<!--                                                                  -->
<!-- end_generated_Teracloud_ApS_copyright_prolog                     -->
## DNSTunnelingSample

This sample demonstrates how you can use the DNSTunneling operator from the `com.teracloud.streams.cybersecurity` toolkit.

## Use with local Streams installation

Build the application:

`ant`

The application is build using the cybersecurity and network toolkit from the local Streams installation ("$STREAMS_INSTALL/toolkits").

Launch:

`./output/DNSTunnelingBasic_Output/bin/standalone`

or 

`ant standalone`

Alternative you can submit the `./output/DNSTunnelingBasic_Output/com.teracloud.streams.cybersecurity.sample.DNSTunnelingBasic.sab` file to your Streams instance.
In the Streams Console, go to the Log Viewer and Click on the PE's Console Log to view the output.

Clean:

`ant clean`
