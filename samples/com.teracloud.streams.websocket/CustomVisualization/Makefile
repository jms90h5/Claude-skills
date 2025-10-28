# Copyright (C)2018, 2020 International Business Machines Corporation and  
# others. All Rights Reserved.                        
.PHONY: build all distributed clean

$(info Building with local Streams installation)
ifndef STREAMS_INSTALL
    $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif

# You may need to set the STREAMSX_WEBSOCKET_TOOLKIT variable if the toolkit cannot be found locally or in the Streams install.
ifndef STREAMSX_WEBSOCKET_TOOLKIT
    TOOLKIT_NAME=com.teracloud.streams.websocket
    ifneq ($(realpath ../../$(TOOLKIT_NAME)/toolkit.xml),)
        STREAMSX_WEBSOCKET_TOOLKIT = ../../$(TOOLKIT_NAME)
    else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
        STREAMSX_WEBSOCKET_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
    else
        $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
    endif
endif

# You may override these variables if you wish to use a custom toolkit outside of the Streams install
STREAMSX_JSON_TOOLKIT ?= $(STREAMS_INSTALL)/toolkits/com.teracloud.streams.json
STREAMS_GEOSPATIAL_TOOLKIT ?= $(STREAMS_INSTALL)/toolkits/com.teracloud.streams.geospatial

SPLC = $(STREAMS_INSTALL)/bin/sc
DATA_DIR = data
OUTPUT_DIR = output
TOOLKIT_PATH = $(STREAMSX_WEBSOCKET_TOOLKIT):$(STREAMSX_JSON_TOOLKIT):$(STREAMS_GEOSPATIAL_TOOLKIT)

SPL_MAIN_COMPOSITE = com.teracloud.streams.websocket.sample::TaxiMetrics
SPLC_FLAGS = -a --c++std=c++17
SPL_CMD_ARGS ?=

build: distributed

all: clean build

distributed:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) -t ${TOOLKIT_PATH} --data-dir $(DATA_DIR) --output-dir $(OUTPUT_DIR) $(SPL_CMD_ARGS)

clean:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) -t ${TOOLKIT_PATH} --data-dir $(DATA_DIR) --output-dir $(OUTPUT_DIR) -C $(SPL_CMD_ARGS)
	rm -rf output
