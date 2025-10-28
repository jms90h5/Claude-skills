#!/bin/bash
# begin_generated_IBM_Teracloud_ApS_copyright_prolog               
#                                                                  
# This is an automatically generated copyright prolog.             
# After initializing,  DO NOT MODIFY OR MOVE                       
# **************************************************************** 
# Licensed Materials - Property of IBM                             
# (C) Copyright Teracloud ApS 2024, 2024, IBM Corp. 2010, 2015     
# All Rights Reserved.                                             
# US Government Users Restricted Rights - Use, duplication or      
# disclosure restricted by GSA ADP Schedule Contract with          
# IBM Corp.                                                        
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 
# 

SCRIPTDIR=$(dirname $0);

echo "Stopping the CommodityPurchasing application."
echo 
echo "Using STREAMS_DOMAIN_ID environment variable: $STREAMS_DOMAIN_ID"
echo "Using STREAMS_INSTANCE_ID environment variable: $STREAMS_INSTANCE_ID"

if [ $STREAMS_ZKCONNECT ]; then
    echo "Using STREAMS_ZKCONNECT environment variable: $STREAMS_ZKCONNECT"
    zk_parameter="";
else
    echo "Using embedded ZooKeeper."
    zk_parameter="--embeddedzk";
fi

echo
echo "Stopping the UI Helper script and User-Initiated Purchasing script..."
FILENAME=$SCRIPTDIR/user_interface/UIHelper.pid;
if [[ -e  $FILENAME ]]; then
  while read pid
  do
    kill $pid
  done < $FILENAME
  rm -f $FILENAME
fi

FILENAME=$SCRIPTDIR/user_interface/UIBuyPrompted.pid;
if [[ -e  $FILENAME ]]; then
  while read pid
  do
    kill $pid
  done < $FILENAME
  rm -f $FILENAME
fi

FILENAME=$SCRIPTDIR/user_interface/DomainWasNotAlreadyCreated;
echo
if [[ -e $FILENAME ]]; then
  echo "Stopping the Streams instance (and its CommodityPurchasing jobs)..."
  streamtool stopinstance $zk_parameter
  echo "Stopping the Streams domain ..."
  streamtool stopdomain $zk_parameter --force
  echo
  echo "If you want to delete the Domain and Instance, run this command:"
  echo
  echo "streamtool rmdomain -d $STREAMS_DOMAIN_ID $zk_parameter"
else
  echo "Stopping the CommodityPurchasing jobs in the Streams instance..."
  streamtool canceljob $zk_parameter -f $SCRIPTDIR/user_interface/job_ids
  echo
  echo "The Streams domain was detected to be running prior to startup of this application,"
  echo "so the domain and instance was not stopped here."
  echo
  echo "If you want to delete the Domain and Instance, run the following commands:"
  echo 
  echo "streamtool stopinstance -i $STREAMS_INSTANCE_ID -d $STREAMS_DOMAIN_ID $zk_parameter"
  echo "streamtool stopdomain -d $STREAMS_DOMAIN_ID $zk_parameter"
  echo "streamtool rmdomain -d $STREAMS_DOMAIN_ID $zk_parameter"
fi
rm -f $FILENAME
rm -f $SCRIPTDIR/user_interface/job_ids

echo
echo "Stop of CommodityPurchasing artifacts is now complete."
echo "You may close the Firefox UI browser at your convenience."
echo
