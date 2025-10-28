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
# (C) Copyright Teracloud ApS 2025, 2025, IBM Corp. 2011, 2015     
# All Rights reserved.                                             
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 
# -----------------------------------------------------------------------------
# phony targets are targets being not in the filesystem but are always "active"
# -----------------------------------------------------------------------------

.PHONY: all clean distributed clean-distributed clean-output clean-runtime-generated-files run

# -----------------------------------------------------------------------------
# The environment has to be prepared.
# -----------------------------------------------------------------------------

ifndef STREAMS_INSTALL
  $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif

# -----------------------------------------------------------------------------
# Namespace of this toolkit is the name of the root directory.
# -----------------------------------------------------------------------------

APP_NAME = teda.sample.DirectoryWatch

# -----------------------------------------------------------------------------
# Streams Compiler & Arguments
# -----------------------------------------------------------------------------

# check for existence of Telecommunications Event Data Analytics toolkit in Streams installation
# try STREAMS_SPLPATH otherwise
ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/com.teracloud.streams.teda),)
	STREAMS_TEDA_TOOLKIT:=$(STREAMS_INSTALL)/toolkits/com.teracloud.streams.teda
else
	STREAMS_TEDA_TOOLKIT:=$(STREAMS_SPLPATH)
endif

SPLC_FLAGS = -a -t $(STREAMS_TEDA_TOOLKIT) --data-directory=data

SPLC = $(STREAMS_INSTALL)/bin/sc

# -----------------------------------------------------------------------------
# Main Composite
# -----------------------------------------------------------------------------

SPL_MAIN_COMPOSITE = $(APP_NAME)::Main

# -----------------------------------------------------------------------------
# Output Directories
# -----------------------------------------------------------------------------

OUTPUT =
ifeq ($(STREAMS_STUDIO_BUILDING),1)
  SPLC_FLAGS += --no-toolkit-indexing
  OUTPUT = $(STREAMS_STUDIO_OUTPUT_DIRECTORY)
else
  OUTPUT = output/Distributed
endif
OUTDIR = --output-directory=$(OUTPUT)

# -----------------------------------------------------------------------------
# Build and Clean Targets
# -----------------------------------------------------------------------------

all: distributed

run:
	$(OUTPUT)/bin/standalone
	@echo "*** RESULTS ***********************************************"
	@find data -name '*.txt' -print -exec cat {} \;

distributed:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) $(OUTDIR)

clean: clean-distributed clean-output clean-runtime-generated-files

clean-distributed:
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE) $(OUTDIR)
	-rm -rf toolkit.xml

clean-output:
	-rm -rf $(OUTPUT)

clean-runtime-generated-files:
	-rm -rf data/*.txt
