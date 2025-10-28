#!/bin/bash
# begin_generated_IBM_Teracloud_ApS_copyright_prolog               
#                                                                  
# This is an automatically generated copyright prolog.             
# After initializing,  DO NOT MODIFY OR MOVE                       
# **************************************************************** 
# Licensed Materials - Property of IBM                             
# (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2010, 2015     
# All Rights Reserved.                                             
# US Government Users Restricted Rights - Use, duplication or      
# disclosure restricted by GSA ADP Schedule Contract with          
# IBM Corp.                                                        
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 
#

SCRIPTDIR=$(dirname $0);

if [[ $STREAMS_DOMAIN_ID && $STREAMS_INSTANCE_ID ]]; then
    echo 
    echo "Starting the Commodity Purchasing application."
    echo 
    echo "Using STREAMS_DOMAIN_ID environment variable: $STREAMS_DOMAIN_ID"
    echo "Using STREAMS_INSTANCE_ID environment variable: $STREAMS_INSTANCE_ID"
else
    echo
    echo "Default domain and instance environment variables are not set."  
    echo "Please source the streamsprofile.sh script."
    echo "Exiting without starting the Commodity Purchasing application."
    echo
    exit
fi

if [ $STREAMS_ZKCONNECT ]; then
    echo "Using STREAMS_ZKCONNECT environment variable: $STREAMS_ZKCONNECT"
    zk_parameter="";
else
    echo "Using embedded ZooKeeper."
    zk_parameter="--embeddedzk";
fi

echo 
echo "Create the Streams domain: $STREAMS_DOMAIN_ID (if not already created)..."
streamtool mkdomain $zk_parameter --property rest.port=0 --property domain.sshAllowed=true --property sws.port=0 --property jmx.port=0 2>/dev/null

if [[ $? = 0 ]]; then
  # The Domain had to be created by this script.  
  # Record this so we can know to stop it when the app is stopped.
  touch $SCRIPTDIR/user_interface/DomainWasNotAlreadyCreated
  # Always do the genkey if we created the domain.
  echo "Generating automatic keys for the $STREAMS_DOMAIN_ID ..."
  streamtool genkey $zk_parameter
fi  

if [[ ! -e  $HOME/.streams/key/$STREAMS_DOMAIN_ID/$USER.pem ]]; then
  # Keep this check. We might not create the domain and still want to do the genkey check.
  echo
  echo "Generating automatic keys for the $STREAMS_DOMAIN_ID ..."
  streamtool genkey $zk_parameter
fi

echo
echo "Starting the Streams domain: $STREAMS_DOMAIN_ID (if not already running)..."
streamtool startdomain $zk_parameter 2>/dev/null 

echo
echo "Create the Streams instance: $STREAMS_INSTANCE_ID (if not already created)..."
streamtool mkinstance $zk_parameter 2>/dev/null

echo
echo "Starting the Streams instance: $STREAMS_INSTANCE_ID (if not already running)..."
streamtool startinstance $zk_parameter 2>/dev/null

echo
echo "Starting the CommodityPurchasing jobs in the Streams instance..."
streamtool submitjob $zk_parameter -f appset --outfile $SCRIPTDIR/user_interface/job_ids

if [[ $? != 0 ]]; then
  echo  
  echo "The submit job was not successfull.  See error messages above."
  echo
  echo "Exiting without starting the Commodity Purchasing application."
  echo
  exit
fi

if [[ ! -e  $SCRIPTDIR/user_interface/UIHelper.pid ]]; then
  echo
  echo "Launching the User Interface Helper for the CommodityPurchasing application..."
  xterm -geometry 72x2-10-30 -title "CommodityPurchasing User Interface Helper" -e "cd $SCRIPTDIR/user_interface; ./enable_user_interface.sh" 2>/dev/null &
  echo $!>$SCRIPTDIR/user_interface/UIHelper.pid
fi

if [[ ! -e  $SCRIPTDIR/user_interface/UIBuyPrompted.pid ]]; then
  echo
  echo "Launching the script for user-initiated commodity purchases..."
  xterm -geometry 72x3-10+40 -title "User-Initiated Purchasing" -e "cd $SCRIPTDIR/user_interface; ./buy_infoberries_prompted.sh" 2>/dev/null &
  echo $!>$SCRIPTDIR/user_interface/UIBuyPrompted.pid
fi

# Short delay before launching firefox, allowing the UI Helper to generate its first set of data files.
# The UI Helper also has a short delay to allow the SPL file sinks to be initialized.
# Without these delays, firefox can come up initially with data from a prior run.
sleep 4

echo
echo "Launching the CommodityPurchasing application UI in Firefox..."
firefox -url $SCRIPTDIR/user_interface/web_ui/purchasing.html -url -new_tab $SCRIPTDIR/user_interface/web_ui/app_metrics.html >/dev/null 2>/dev/null &

echo
echo "Start of the CommodityPurchasing application is now complete."
echo
