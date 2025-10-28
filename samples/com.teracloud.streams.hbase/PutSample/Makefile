# Copyright (C) 2014, 2018, International Business Machines Corporation  
# All Rights Reserved      

# NOTE: To compile, you must have HBASE_HOME and HBASE_HOME set in your
# environment.

.PHONY: all clean 

ifndef STREAMS_INSTALL
  $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif

# You may need to set the STREAMSX_HBASE_TOOLKIT variable if the toolkit cannot be found locally or in the Streams install.
ifndef STREAMSX_HBASE_TOOLKIT
  TOOLKIT_NAME=com.teracloud.streams.hbase
  ifneq ($(realpath ../../$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_HBASE_TOOLKIT = ../../$(TOOLKIT_NAME)
  else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_HBASE_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
  else
    $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
  endif
endif

SPLC_FLAGS ?= -a -t $(STREAMSX_HBASE_TOOLKIT) --data-directory data 
SPLC = $(STREAMS_INSTALL)/bin/sc

SPL_CMD_ARGS ?=
SPL_MAIN_UPDATE = com.teracloud.streams.hbase.sample::BasicUpdate
SPL_MAIN_CHECK = com.teracloud.streams.hbase.sample::CheckAndPut
SPL_MAIN_EXIST_CHECK=com.teracloud.streams.hbase.sample::PutExistCheck
SPL_MAIN_PUT=com.teracloud.streams.hbase.sample::PutSample

SPL_MAIN_COMP= BasicUpdate
SPL_MAIN_CHECK_COMP= CheckAndPut
SPL_MAIN_EXIST_COMP= PutExistCheck
SPL_MAIN_PUT_COMP= PutSample

all: compile data

data:
	mkdir data


compile: data
	$(SPLC) --output-dir output/$(SPL_MAIN_COMP) $(SPLC_FLAGS) -M $(SPL_MAIN_UPDATE) $(SPL_CMD_ARGS)
	$(SPLC) --output-dir output/$(SPL_MAIN_CHECK_COMP) $(SPLC_FLAGS) -M $(SPL_MAIN_CHECK) $(SPL_CMD_ARGS)
	$(SPLC) --output-dir output/$(SPL_MAIN_EXIST_COMP) $(SPLC_FLAGS) -M $(SPL_MAIN_EXIST_CHECK) $(SPL_CMD_ARGS)
	$(SPLC) --output-dir output/$(SPL_MAIN_PUT_COMP)  $(SPLC_FLAGS) -M $(SPL_MAIN_PUT) $(SPL_CMD_ARGS)

clean: 
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_UPDATE) $(SPL_CMD_ARGS)  --output-dir output/$(SPL_MAIN_COMP)
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_CHECK) $(SPL_CMD_ARGS) --output-dir output/$(SPL_MAIN_CHECK_COMP)
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_EXIST_CHECK) $(SPL_CMD_ARGS) --output-dir output/$(SPL_MAIN_EXIST_COMP) 
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_PUT) $(SPL_CMD_ARGS) --output-dir output/$(SPL_MAIN_PUT_COMP)

