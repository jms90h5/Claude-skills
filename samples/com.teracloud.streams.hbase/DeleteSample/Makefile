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
SPL_MAIN_COMPOSITE_CHECK = com.teracloud.streams.hbase.sample::CheckAndDelete
SPL_MAIN_COMPOSITE_DELETE = com.teracloud.streams.hbase.sample::DeleteDemo
SPL_MAIN_COMPOSITE_VERSIONDEL = com.teracloud.streams.hbase.sample::DeleteAll

all: distributed

data:
	mkdir data


distributed: data
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE_DELETE) $(SPL_CMD_ARGS) --output-dir output_delete
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE_CHECK) $(SPL_CMD_ARGS) --output-dir output_check
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE_VERSIONDEL) $(SPL_CMD_ARGS) --output-dir output_version

clean: 
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE_DELETE) --output-dir output_delete
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE_CHECK) --output-dir output_check
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE_VERSIONDEL) $(SPL_CMD_ARGS) --output-dir output_version

