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
# (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2014, 2016     
# All Rights reserved.                                             
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 
.PHONY: all distributed clean data-dir

SPLC = $(STREAMS_INSTALL)/bin/sc
SPLC_FLAGS ?= -a 
OUTDIR =
ifeq ($(STREAMS_STUDIO_BUILDING),1)
  SPLC_FLAGS += --no-toolkit-indexing
  OUTDIR = --output-directory=$(STREAMS_STUDIO_OUTPUT_DIRECTORY)
else
  OUTDIR = --output-directory=output
endif
SPL_DATA_DIR ?= ./data
SPL_CMD_ARGS ?=

all: data-dir distributed

data-dir:
	mkdir -p $(SPL_DATA_DIR)

distributed:
	$(SPLC) $(SPLC_FLAGS) -M sample::MultipleSources --data-directory $(SPL_DATA_DIR) $(SPL_CMD_ARGS) $(OUTDIR)/MultipleSources
	$(SPLC) $(SPLC_FLAGS) -M sample::StatefulPrimitive --data-directory $(SPL_DATA_DIR) $(SPL_CMD_ARGS) $(OUTDIR)/StatefulPrimitive
	$(SPLC) $(SPLC_FLAGS) -M sample::ReplayableSource --data-directory $(SPL_DATA_DIR) $(SPL_CMD_ARGS) $(OUTDIR)/ReplayableSource

clean: 
	$(SPLC) $(SPLC_FLAGS) -C -M sample::MultipleSources $(OUTDIR)/MultipleSources
	$(SPLC) $(SPLC_FLAGS) -C -M sample::StatefulPrimitive $(OUTDIR)/StatefulPrimitive
	$(SPLC) $(SPLC_FLAGS) -C -M sample::ReplayableSource $(OUTDIR)/ReplayableSource

