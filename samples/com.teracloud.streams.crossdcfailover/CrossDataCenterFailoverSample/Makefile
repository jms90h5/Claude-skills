# Copyright (C)2019, International Business Machines Corporation and  
# others. All Rights Reserved.                        
.PHONY: build all distributed clean

#IMPORTANT
#---------
$(info Building with local Streams installation)
ifndef STREAMS_INSTALL
    $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif
# You may need to set the STREAMSX_CROSSDC_FAILOVER_TOOLKIT variable if the toolkit cannot be found locally or in the Streams install.
ifndef STREAMSX_CROSSDC_FAILOVER_TOOLKIT
    TOOLKIT_NAME=com.teracloud.streams.crossdcfailover
    ifneq ($(realpath ../../$(TOOLKIT_NAME)/toolkit.xml),)
        STREAMSX_CROSSDC_FAILOVER_TOOLKIT = ../../$(TOOLKIT_NAME)
    else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
        STREAMSX_CROSSDC_FAILOVER_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
    else
        $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
    endif
endif
SPLC = $(STREAMS_INSTALL)/bin/sc
DATA_DIR = data
OUTPUT_DIR = output
TOOLKIT_PATH = $(STREAMSX_CROSSDC_FAILOVER_TOOLKIT)

SPL_MAIN_COMPOSITE = com.teracloud.streams.crossdc.failover.sample::CrossDataCenterFailoverSample

# Set the STREAMSX_INETSERVER_TOOLKIT variable if you want to use an inetserver toolkit not in Streams install.
STREAMSX_INETSERVER_TOOLKIT ?= $(STREAMS_INSTALL)/toolkits/com.teracloud.streams.inetserver

# If the user sets the STREAMS_SPLPATH environment variable,
# then the value set in the previous line will be ignored.
#
ifndef STREAMS_SPLPATH
   SPLC_FLAGS ?= -a -t $(STREAMSX_INETSERVER_TOOLKIT)
else
   SPLC_FLAGS ?= -a
endif

SPL_CMD_ARGS ?=

build: distributed

all: clean build

distributed:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) -t ${TOOLKIT_PATH} --data-dir $(DATA_DIR) --output-dir $(OUTPUT_DIR) $(SPL_CMD_ARGS)

clean:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) -t ${TOOLKIT_PATH} --data-dir $(DATA_DIR) --output-dir $(OUTPUT_DIR) -C $(SPL_CMD_ARGS)
	rm -rf output
