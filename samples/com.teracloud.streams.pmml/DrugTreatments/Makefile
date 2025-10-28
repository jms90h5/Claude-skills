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
# (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2017, 2017     
# All Rights reserved.                                             
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 

.PHONY: all clean

# determine pathes
ifeq ($(STREAMS_STUDIO_BUILDING), 1)
  # Building with Streams Studio
  SPLC = $(STREAMS_STUDIO_SC_PATH)
  SPL_PATH = $(STREAMS_STUDIO_SPL_PATH)
  OUTPUT_DIR = $(STREAMS_STUDIO_OUTPUT_DIRECTORY)
else
  ifndef STREAMS_INSTALL
    $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
  endif

  # You may need to set the STREAMS_PMML_TOOLKIT variable if the toolkit cannot be found in the Streams install.
  STREAMS_PMML_TOOLKIT ?= $(STREAMS_INSTALL)/toolkits/com.teracloud.streams.pmml

  SPLC = $(STREAMS_INSTALL)/bin/sc
  SPL_PATH = $(STREAMS_PMML_TOOLKIT)
endif

# directories and compiler options
DATA_DIR = /tmp
SPL_NAMESPACE = sample.pmml
SPL_MAIN_COMPOSITE = $(SPL_NAMESPACE)::DrugTreatments
SPLC_FLAGS  = -a -t $(SPL_PATH) --data-directory=$(DATA_DIR)
SPL_CMD_ARGS ?= 
OUTPUT_DIR = output

all:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) --output-directory $(OUTPUT_DIR) $(SPL_CMD_ARGS)

clean:
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE) --output-directory $(OUTPUT_DIR)
	-rm -rf $(OUTPUT_DIR)
	-rm -rf toolkit.xml
	-rm -rf .toolkitList

# configure:
#	-streamtool rmappconfig --noprompt es
#	streamtool mkappconfig --property userName=$(PMML_USER) --property password=$(PMML_PASSWORD) --property nodeList=$(PMML_NODES) --property sslEnabled=true es


