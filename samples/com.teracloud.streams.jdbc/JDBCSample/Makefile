# Copyright (C)2015,2016 International Business Machines Corporation and  
# others. All Rights Reserved.    
.PHONY: all clean 

TOOLKIT_NAME=com.teracloud.streams.jdbc

ifndef STREAMS_INSTALL
  $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif

# You may need to set the STREAMSX_JDBC_TOOLKIT variable if the toolkit cannot be found locally or in the Streams install.
ifndef STREAMSX_JDBC_TOOLKIT
  TOOLKIT_NAME=com.teracloud.streams.jdbc
  ifneq ($(realpath ../../$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_JDBC_TOOLKIT = ../../$(TOOLKIT_NAME)
  else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_JDBC_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
  else
    $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
  endif
endif

SPLC_FLAGS ?= -a -t $(STREAMSX_JDBC_TOOLKIT)
SPLC = $(STREAMS_INSTALL)/bin/sc

SPL_CMD_ARGS ?=  
SPL_MAIN_COMPOSITE = com.teracloud.streams.jdbc.sample.jdbcrun::JDBCRunSample
#SPL_MAIN_COMPOSITE = com.teracloud.streams.jdbc.sample.jdbcrun::JDBCRunErrorPort

all: distributed

distributed:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) $(SPL_CMD_ARGS)

clean: 
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE)
	rm -rf output
