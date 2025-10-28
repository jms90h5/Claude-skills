# Copyright (C) 2011,2013,2016, International Business Machines Corporation. 
# All Rights Reserved.

.PHONY: all build clean 

ifndef STREAMS_INSTALL
  $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif

# You may need to set the STREAMSX_JSON_TOOLKIT variable if the toolkit cannot be found locally or in the Streams install.
ifndef STREAMSX_JSON_TOOLKIT
  TOOLKIT_NAME=com.teracloud.streams.json
  ifneq ($(realpath ../../$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_JSON_TOOLKIT = ../../$(TOOLKIT_NAME)
  else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_JSON_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
  else
    $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
  endif
endif

SPLC_FLAGS ?= -a -t $(STREAMSX_JSON_TOOLKIT)
SPLC = $(STREAMS_INSTALL)/bin/sc
SPL_CMD_ARGS ?= 
SPL_NS=com.teracloud.streams.json.sample.ttoj

all: build


build:
	$(SPLC) $(SPLC_FLAGS) --output-dir output/SimpleTupleConvert  -M $(SPL_NS)::SimpleTupleConvert $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) --output-dir output/JsonArrayConvert  -M $(SPL_NS)::JsonArrayConvert $(SPL_CMD_ARGS)

clean: 
	$(SPLC) -C --output-dir output/SimpleTupleConvert -M $(SPL_NS)::SimpleTupleConvert
	$(SPLC) -C --output-dir output/JsonArrayConvert  -M $(SPL_NS)::JsonArrayConvert 
	rm -rf output
