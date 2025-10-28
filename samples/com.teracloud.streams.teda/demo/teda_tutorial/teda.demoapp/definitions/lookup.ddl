-- begin_generated_IBM_Teracloud_ApS_copyright_prolog               
--                                                                  
-- This is an automatically generated copyright prolog.             
-- After initializing,  DO NOT MODIFY OR MOVE                       
-- **************************************************************** 
-- Licensed Materials - Property of IBM                             
-- (C) Copyright Teracloud ApS 2025, 2025, IBM Corp. 2011, 2015     
-- All Rights Reserved.                                             
-- US Government Users Restricted Rights - Use, duplication or      
-- disclosure restricted by GSA ADP Schedule Contract with          
-- IBM Corp.                                                        
--                                                                  
-- end_generated_IBM_Teracloud_ApS_copyright_prolog                 
--------------------------------------------------
-- create Table CELL_SITE_ID_TO_REGION_ID_MAP
--------------------------------------------------
create table CELL_SITE_ID_TO_REGION_ID_MAP (
    CELL_SITE_ID                   integer           not null    ,  
    REGION_ID                      integer                       )
;

--------------------------------------------------
-- create Table IMSI_CRM
--------------------------------------------------
create table IMSI_CRM (
    IMSI                          varchar(15)       not null ,
    CUSTOMER_ID                   integer                    ,
    CUSTOMER_TYPE                 integer                    )
;
