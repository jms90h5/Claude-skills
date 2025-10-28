#!/bin/bash
# begin_generated_IBM_Teracloud_ApS_copyright_prolog               
#                                                                  
# This is an automatically generated copyright prolog.             
# After initializing,  DO NOT MODIFY OR MOVE                       
# **************************************************************** 
# Licensed Materials - Property of IBM                             
# (C) Copyright Teracloud ApS 2024, 2024, IBM Corp. 2009, 2010     
# All Rights Reserved.                                             
# US Government Users Restricted Rights - Use, duplication or      
# disclosure restricted by GSA ADP Schedule Contract with          
# IBM Corp.                                                        
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 

purchase_string="2500 bushels purchased at: "
echo "Waiting 10 minutes before user-initiated purchases are allowed..."
sleep 600

while true; do

echo "Press the enter key (with this window active) to purchase 2500 bushels.";
read junk;
purchase_date_utime=`date +%s`;
purchase_date_htime=`date +%c`;
echo $purchase_string $purchase_date_utime >> purchase_history;
echo;
echo $purchase_string $purchase_date_htime;
sleep 10;

done
