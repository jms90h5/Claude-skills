# Copyright (C)2018, International Business Machines Corporation and  
# others. All Rights Reserved.                        

.PHONY: all clean

ifndef STREAMS_INSTALL
  $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif
# You may need to set the STREAMSX_ELASTICSEARCH_TOOLKIT variable if the toolkit cannot be found locally or in the Streams install.
ifndef STREAMSX_ELASTICSEARCH_TOOLKIT
  TOOLKIT_NAME=com.teracloud.streams.elasticsearch
  ifneq ($(realpath ../../$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_ELASTICSEARCH_TOOLKIT= ../../$(TOOLKIT_NAME)
  else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_ELASTICSEARCH_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
  else
    $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
  endif
endif
SPLC = $(STREAMS_INSTALL)/bin/sc
SPL_PATH = $(STREAMSX_ELASTICSEARCH_TOOLKIT)

# directories and compiler options
SPL_NAMESPACE = com.teracloud.streams.elasticsearch.sample.AppConfig
SPL_MAIN_COMPOSITE = $(SPL_NAMESPACE)::Main
SPLC_FLAGS  = -a -t $(SPL_PATH)
SPL_CMD_ARGS ?= 
OUTPUT_DIR = output

all:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) --output-directory $(OUTPUT_DIR) $(SPL_CMD_ARGS)

clean:
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE) --output-directory $(OUTPUT_DIR)
	-rm -rf $(OUTPUT_DIR)
	-rm -rf toolkit.xml
	-rm -rf .toolkitList

configure:
	-streamtool rmappconfig --noprompt es
	streamtool mkappconfig --property userName=$(ES_USER) --property password=$(ES_PASSWORD) --property nodeList=$(ES_NODES) --property sslEnabled=true es


