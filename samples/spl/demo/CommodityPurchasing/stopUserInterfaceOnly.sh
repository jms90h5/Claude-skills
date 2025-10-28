#!/bin/bash
# begin_generated_IBM_Teracloud_ApS_copyright_prolog               
#                                                                  
# This is an automatically generated copyright prolog.             
# After initializing,  DO NOT MODIFY OR MOVE                       
# **************************************************************** 
# Licensed Materials - Property of IBM                             
# (C) Copyright Teracloud ApS 2024, 2024, IBM Corp. 2010, 2010     
# All Rights Reserved.                                             
# US Government Users Restricted Rights - Use, duplication or      
# disclosure restricted by GSA ADP Schedule Contract with          
# IBM Corp.                                                        
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 
# 

SCRIPTDIR=$(dirname $0);

echo "Stopping the Commodity Purchasing user interface."

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

rm -f $FILENAME

echo
echo "Stop of the Commodity Purchasing user interface is now complete."
echo "You may close the Firefox UI browser at your convenience."
echo
