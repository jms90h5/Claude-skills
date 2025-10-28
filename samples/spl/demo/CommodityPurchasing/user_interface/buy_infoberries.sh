#!/bin/csh -f
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

set purchase_string = "2500 bushels purchased at: "
set purchase_date_utime = `date +%s`
set purchase_date_htime = `date +%c`
echo $purchase_string $purchase_date_utime >> purchase_history
echo "Purchasing..."
sleep 5
echo $purchase_string $purchase_date_htime
