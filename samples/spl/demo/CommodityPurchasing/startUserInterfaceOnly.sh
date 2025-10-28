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

echo "Starting the Commodity Purchasing user interface."
echo "The Commodity Purchasing Streams application is assumed to be already running."
echo

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
echo "Start of the CommodityPurchasing user interface is complete."
echo
