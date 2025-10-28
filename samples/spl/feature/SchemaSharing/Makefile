# begin_generated_IBM_Teracloud_ApS_copyright_prolog               
#                                                                  
# This is an automatically generated copyright prolog.             
# After initializing,  DO NOT MODIFY OR MOVE                       
# **************************************************************** 
# THIS SAMPLE CODE IS PROVIDED ON AN "AS IS" BASIS.                
# TERACLOUD APS AND IBM MAKES NO REPRESENTATIONS OR WARRANTIES,    
# EXPRESS OR IMPLIED, CONCERNING  USE OF THE SAMPLE CODE, OR THE   
# COMPLETENESS OR ACCURACY OF THE SAMPLE CODE. TERACLOUD APS       
# AND IBM DOES NOT WARRANT UNINTERRUPTED OR ERROR-FREE OPERATION   
# OF THIS SAMPLE CODE. TERACLOUD APS AND IBM IS NOT RESPONSIBLE FOR THE 
# RESULTS OBTAINED FROM THE USE OF THE SAMPLE CODE OR ANY PORTION  
# OF THIS SAMPLE CODE.                                             
#                                                                  
# LIMITATION OF LIABILITY. IN NO EVENT WILL IBM BE LIABLE TO ANY   
# PARTY FOR ANY DIRECT, INDIRECT, SPECIAL OR OTHER CONSEQUENTIAL   
# DAMAGES FOR ANY USE OF THIS SAMPLE CODE, THE USE OF CODE FROM    
# THIS [ SAMPLE PACKAGE,] INCLUDING, WITHOUT LIMITATION, ANY LOST  
# PROFITS, BUSINESS INTERRUPTION, LOSS OF PROGRAMS OR OTHER DATA   
# ON YOUR INFORMATION HANDLING SYSTEM OR OTHERWISE.                
#                                                                  
# (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2010, 2016     
# All Rights reserved.                                             
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 
.PHONY: all importer exporter clean clean-importer clean-exporter data-dir

SPLC = $(STREAMS_INSTALL)/bin/sc
SPLC_FLAGS ?= -a
SPLC_FLAGS_importer ?= $(SPLC_FLAGS) 
SPLC_FLAGS_exporter ?= $(SPLC_FLAGS)
SPL_DATA_DIR ?= ./data
SPL_CMD_ARGS ?= 
SPL_CMD_ARGS_importer ?= $(SPL_CMD_ARGS) 
SPL_CMD_ARGS_exporter ?= $(SPL_CMD_ARGS)

SPL_MAIN_COMPOSITE_importer = sample::Importer
SPL_MAIN_COMPOSITE_exporter = sample::Exporter

SPL_OUTPUT_DIR_importer = output/importer
SPL_OUTPUT_DIR_exporter = output/exporter

all: data-dir importer exporter

data-dir:
	mkdir -p $(SPL_DATA_DIR)

importer:
	$(SPLC) $(SPLC_FLAGS_importer) -M $(SPL_MAIN_COMPOSITE_importer) --data-directory $(SPL_DATA_DIR) --output-dir=$(SPL_OUTPUT_DIR_importer) $(SPL_CMD_ARGS_importer)

exporter:
	$(SPLC) $(SPLC_FLAGS_exporter) -M $(SPL_MAIN_COMPOSITE_exporter) --output-dir=$(SPL_OUTPUT_DIR_exporter) $(SPL_CMD_ARGS_exporter)

clean: clean-importer clean-exporter

clean-importer: 
	$(SPLC) $(SPLC_FLAGS_importer) -C -M $(SPL_MAIN_COMPOSITE_importer) --output-dir=$(SPL_OUTPUT_DIR_importer) 

clean-exporter: 
	$(SPLC) $(SPLC_FLAGS_exporter) -C -M $(SPL_MAIN_COMPOSITE_exporter) --output-dir=$(SPL_OUTPUT_DIR_exporter) 

