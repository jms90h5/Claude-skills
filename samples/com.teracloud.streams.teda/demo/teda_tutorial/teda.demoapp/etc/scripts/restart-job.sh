#!/bin/sh
# begin_generated_IBM_Teracloud_ApS_copyright_prolog               
#                                                                  
# This is an automatically generated copyright prolog.             
# After initializing,  DO NOT MODIFY OR MOVE                       
# **************************************************************** 
# Licensed Materials - Property of IBM                             
# (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2023, 2023     
# All Rights Reserved.                                             
# US Government Users Restricted Rights - Use, duplication or      
# disclosure restricted by GSA ADP Schedule Contract with          
# IBM Corp.                                                        
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 
echo RESTARTING APPLICATION
echo jobID: $1
echo domainID: $2
echo instanceID: $3
echo STREAMS_INSTALL: $4
echo sabFile: $5

# add further parameters like -User or --zkconnect if required for the streamtool commands below

$4/bin/streamtool canceljob -j $1 -d $2 -i $3 --force
$4/bin/streamtool submitjob -d $2 -i $3 $5 



