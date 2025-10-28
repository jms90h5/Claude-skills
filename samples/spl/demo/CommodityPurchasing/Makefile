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
.PHONY: all AutomatedBuyer SupplyAndPurchase TopSupplier WatchesAndWarnings WeatherConditions clean-AutomatedBuyer clean-SupplyAndPurchase clean-TopSupplier clean-WatchesAndWarnings clean-WeatherConditions clean-appset check-tk

CPAPPWD=$(shell pwd)

SPLC_FLAGS                    ?= -a
SPLC_FLAGS_AutomatedBuyer     ?= $(SPLC_FLAGS) 
SPLC_FLAGS_SupplyAndPurchase  ?= $(SPLC_FLAGS)
SPLC_FLAGS_TopSupplier        ?= $(SPLC_FLAGS)
SPLC_FLAGS_WatchesAndWarnings ?= $(SPLC_FLAGS)
SPLC_FLAGS_WeatherConditions  ?= $(SPLC_FLAGS)
SPLC = $(STREAMS_INSTALL)/bin/sc
INET_TOOLKIT = $(STREAMS_INSTALL)/toolkits/com.teracloud.streams.inet

SPL_CMD_ARGS                    ?= 
SPL_CMD_ARGS_AutomatedBuyer     ?= $(SPL_CMD_ARGS) 
SPL_CMD_ARGS_AutomatedBuyer	+= -t $(INET_TOOLKIT)
SPL_CMD_ARGS_SupplyAndPurchase  ?= $(SPL_CMD_ARGS)
SPL_CMD_ARGS_SupplyAndPurchase  += -t $(INET_TOOLKIT)
SPL_CMD_ARGS_TopSupplier        ?= $(SPL_CMD_ARGS)
SPL_CMD_ARGS_TopSupplier	+= -t $(INET_TOOLKIT)
SPL_CMD_ARGS_WatchesAndWarnings ?= $(SPL_CMD_ARGS)
SPL_CMD_ARGS_WatchesAndWarnings += -t $(INET_TOOLKIT)
SPL_CMD_ARGS_WeatherConditions  ?= $(SPL_CMD_ARGS)
SPL_CMD_ARGS_WeatherConditions  += -t $(INET_TOOLKIT)


# The NOAA weather station identifier codes for the locations where the commodity suppliers are.
# Abilene, Bozeman, Chimney Rock, Delacroix, etc. 
SPL_CMD_ARGS_WeatherConditions  += S0=KABI S1=KBZN S2=KDRO S3=KNBG S4=KRNM  S5=KDLS 
SPL_CMD_ARGS_WeatherConditions  += S6=KAUG S7=KTUP S8=KHTS S9=KVRB S10=KEED S11=KDBQ 

SPL_MAIN_COMPOSITE_AutomatedBuyer     = sample.CommodityPurchasing::AutomatedBuyer
SPL_MAIN_COMPOSITE_SupplyAndPurchase  = sample.CommodityPurchasing::SupplyAndPurchase
SPL_MAIN_COMPOSITE_TopSupplier        = sample.CommodityPurchasing::TopSupplier
SPL_MAIN_COMPOSITE_WatchesAndWarnings = sample.CommodityPurchasing::WatchesAndWarnings
SPL_MAIN_COMPOSITE_WeatherConditions  = sample.CommodityPurchasing::WeatherConditions

SPL_OUTPUT_DIR_AutomatedBuyer     = output/AutomatedBuyer
SPL_OUTPUT_DIR_SupplyAndPurchase  = output/SupplyAndPurchase
SPL_OUTPUT_DIR_TopSupplier        = output/TopSupplier
SPL_OUTPUT_DIR_WatchesAndWarnings = output/WatchesAndWarnings
SPL_OUTPUT_DIR_WeatherConditions  = output/WeatherConditions

SPL_DATA_DIR_AutomatedBuyer     = $(CPAPPWD)/data/AutomatedBuyer
SPL_DATA_DIR_SupplyAndPurchase  = $(CPAPPWD)/data/SupplyAndPurchase
SPL_DATA_DIR_TopSupplier        = $(CPAPPWD)/data/TopSupplier
SPL_DATA_DIR_WatchesAndWarnings = $(CPAPPWD)/data/WatchesAndWarnings
SPL_DATA_DIR_WeatherConditions  = $(CPAPPWD)/data/WeatherConditions

SPL_SUBMIT_APPSET = appset

all: AutomatedBuyer SupplyAndPurchase TopSupplier WatchesAndWarnings WeatherConditions $(SPL_SUBMIT_APPSET)

AutomatedBuyer: check-tk
	mkdir -p $(SPL_DATA_DIR_AutomatedBuyer)
	$(SPLC) $(SPLC_FLAGS_AutomatedBuyer) -M $(SPL_MAIN_COMPOSITE_AutomatedBuyer) \
          --output-dir=$(SPL_OUTPUT_DIR_AutomatedBuyer) --data-dir=$(SPL_DATA_DIR_AutomatedBuyer) $(SPL_CMD_ARGS_AutomatedBuyer)

SupplyAndPurchase: check-tk
	mkdir -p $(SPL_DATA_DIR_SupplyAndPurchase)
	$(SPLC) $(SPLC_FLAGS_SupplyAndPurchase) -M $(SPL_MAIN_COMPOSITE_SupplyAndPurchase) \
          --output-dir=$(SPL_OUTPUT_DIR_SupplyAndPurchase) --data-dir=$(SPL_DATA_DIR_SupplyAndPurchase) $(SPL_CMD_ARGS_SupplyAndPurchase)

TopSupplier: check-tk
	mkdir -p $(SPL_DATA_DIR_TopSupplier)
	$(SPLC) $(SPLC_FLAGS_TopSupplier) -M $(SPL_MAIN_COMPOSITE_TopSupplier) \
          --output-dir=$(SPL_OUTPUT_DIR_TopSupplier) --data-dir=$(SPL_DATA_DIR_TopSupplier) $(SPL_CMD_ARGS_TopSupplier)

WatchesAndWarnings: check-tk
	mkdir -p $(SPL_DATA_DIR_WatchesAndWarnings)
	$(SPLC) $(SPLC_FLAGS_WatchesAndWarnings) -M $(SPL_MAIN_COMPOSITE_WatchesAndWarnings) \
          --output-dir=$(SPL_OUTPUT_DIR_WatchesAndWarnings) --data-dir=$(SPL_DATA_DIR_WatchesAndWarnings) $(SPL_CMD_ARGS_WatchesAndWarnings)

WeatherConditions: check-tk
	mkdir -p $(SPL_DATA_DIR_WeatherConditions)
	$(SPLC) $(SPLC_FLAGS_WeatherConditions) -M $(SPL_MAIN_COMPOSITE_WeatherConditions) \
          --output-dir=$(SPL_OUTPUT_DIR_WeatherConditions) --data-dir=$(SPL_DATA_DIR_WeatherConditions) $(SPL_CMD_ARGS_WeatherConditions)

$(SPL_SUBMIT_APPSET): 
	echo $(SPL_OUTPUT_DIR_AutomatedBuyer)/$(SPL_MAIN_COMPOSITE_AutomatedBuyer).adl > $(SPL_SUBMIT_APPSET)
	echo $(SPL_OUTPUT_DIR_SupplyAndPurchase)/$(SPL_MAIN_COMPOSITE_SupplyAndPurchase).adl >> $(SPL_SUBMIT_APPSET)
	echo $(SPL_OUTPUT_DIR_TopSupplier)/$(SPL_MAIN_COMPOSITE_TopSupplier).adl >> $(SPL_SUBMIT_APPSET)
	echo $(SPL_OUTPUT_DIR_WatchesAndWarnings)/$(SPL_MAIN_COMPOSITE_WatchesAndWarnings).adl >> $(SPL_SUBMIT_APPSET)
	echo $(SPL_OUTPUT_DIR_WeatherConditions)/$(SPL_MAIN_COMPOSITE_WeatherConditions).adl >> $(SPL_SUBMIT_APPSET)
	sed -i 's/::/./g' $(SPL_SUBMIT_APPSET)

clean: clean-AutomatedBuyer clean-SupplyAndPurchase clean-TopSupplier clean-WatchesAndWarnings clean-WeatherConditions clean-appset

clean-AutomatedBuyer:
	rm -rf $(SPL_DATA_DIR_AutomatedBuyer)
	$(SPLC) $(SPLC_FLAGS_AutomatedBuyer) -C -M $(SPL_MAIN_COMPOSITE_AutomatedBuyer) \
	  --output-dir=$(SPL_OUTPUT_DIR_AutomatedBuyer) --data-dir=$(SPL_DATA_DIR_AutomatedBuyer) 

clean-SupplyAndPurchase:
	rm -rf $(SPL_DATA_DIR_SupplyAndPurchase)
	$(SPLC) $(SPLC_FLAGS_SupplyAndPurchase) -C -M $(SPL_MAIN_COMPOSITE_SupplyAndPurchase) \
	  --output-dir=$(SPL_OUTPUT_DIR_SupplyAndPurchase) --data-dir=$(SPL_DATA_DIR_SupplyAndPurchase) 

clean-TopSupplier: 
	rm -rf $(SPL_DATA_DIR_TopSupplier)
	$(SPLC) $(SPLC_FLAGS_TopSupplier) -C -M $(SPL_MAIN_COMPOSITE_TopSupplier) \
	  --output-dir=$(SPL_OUTPUT_DIR_TopSupplier) --data-dir=$(SPL_DATA_DIR_TopSupplier) 

clean-WatchesAndWarnings: 
	rm -rf $(SPL_DATA_DIR_WatchesAndWarnings)
	$(SPLC) $(SPLC_FLAGS_WatchesAndWarnings) -C -M $(SPL_MAIN_COMPOSITE_WatchesAndWarnings) \
	  --output-dir=$(SPL_OUTPUT_DIR_WatchesAndWarnings) --data-dir=$(SPL_DATA_DIR_WatchesAndWarnings) 

clean-WeatherConditions: 
	rm -rf $(SPL_DATA_DIR_WeatherConditions)
	$(SPLC) $(SPLC_FLAGS_WeatherConditions) -C -M $(SPL_MAIN_COMPOSITE_WeatherConditions) \
	  --output-dir=$(SPL_OUTPUT_DIR_WeatherConditions) --data-dir=$(SPL_DATA_DIR_WeatherConditions) 

clean-appset:
	rm -f $(SPL_SUBMIT_APPSET)
