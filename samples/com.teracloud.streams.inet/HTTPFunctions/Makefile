# Copyright (C) 2019, International Business Machines Corporation.
# All Rights Reserved.

.PHONY: all distributed standalone clean

$(info Building with local Streams installation)
ifndef STREAMS_INSTALL
    $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif
# You may need to set the STREAMSX_INET_TOOLKIT variable if the toolkit cannot be found locally or in the Streams install.
ifndef STREAMSX_INET_TOOLKIT
    TOOLKIT_NAME=com.teracloud.streams.inet
    ifneq ($(realpath ../../$(TOOLKIT_NAME)/toolkit.xml),)
        STREAMSX_INET_TOOLKIT= ../../$(TOOLKIT_NAME)
    else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
        STREAMSX_INET_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
    else
        $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
    endif
endif
SPLC = $(STREAMS_INSTALL)/bin/sc
DATA_DIR = data
OUTPUT_DIR = output
TOOLKIT_PATH = $(STREAMSX_INET_TOOLKIT)

SPLC_FLAGS = -a
SPL_CMD_ARGS ?=
SPL_MAIN_COMPOSITE = com.teracloud.streams.inet.sample::GetPost

all: clean distributed

distributed:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) -t ${TOOLKIT_PATH} --output-dir $(OUTPUT_DIR) $(SPL_CMD_ARGS)

standalone:
	$(SPLC) $(SPLC_FLAGS) -T -M $(SPL_MAIN_COMPOSITE) -t ${TOOLKIT_PATH} --output-dir $(OUTPUT_DIR) $(SPL_CMD_ARGS)

clean:
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE) -t ${TOOLKIT_PATH} --output-dir $(OUTPUT_DIR) $(SPL_CMD_ARGS)
