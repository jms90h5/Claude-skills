# Copyright (C) 2018, International Business Machines Corporation. 
# All Rights Reserved.

.PHONY: build all clean distributed

SPLC_FLAGS = -a
OUTPUT_DIR = output

ifndef STREAMS_INSTALL
  $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif

# You may need to set the STREAMSX_OBJECTSTORAGE_TOOLKIT variable if the toolkit cannot be found locally or in the Streams install.
ifndef STREAMSX_OBJECTSTORAGE_TOOLKIT
  TOOLKIT_NAME=com.teracloud.streams.objectstorage
  ifneq ($(realpath ../../../$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_OBJECTSTORAGE_TOOLKIT = ../../../$(TOOLKIT_NAME)
  else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_OBJECTSTORAGE_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
  else
    $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
  endif
endif

SPLC = $(STREAMS_INSTALL)/bin/sc
SPL_PATH=$(STREAMSX_OBJECTSTORAGE_TOOLKIT)

SPLC_FLAGS += -t $(SPL_PATH) --rebuild-toolkits

SPL_CMD_ARGS ?= 

SPL_MAIN_COMPOSITE = com.teracloud.streams.objectstorage.sample::PartitionedParquetSample


build: distributed 

all: clean build

distributed:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) --output-directory=$(OUTPUT_DIR) $(SPL_CMD_ARGS)
	
clean:
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE) --output-directory=$(OUTPUT_DIR)
	rm -rf $(OUTPUT_DIR)
	rm -rf doc
	rm -rf impl

tkidx:
	$(STREAMS_INSTALL)/bin/spl-make-toolkit -i .
