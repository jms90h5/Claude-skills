##################################################################### 
# Copyright (C)2014, 2018 International Business Machines Corporation and 
# others. All Rights Reserved. 
#####################################################################

.PHONY: all clean

ifndef STREAMS_INSTALL
  $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif

# You may need to set the STREAMSX_HDFS_TOOLKIT variable if the toolkit cannot be found locally or in the Streams install.
ifndef STREAMSX_HDFS_TOOLKIT
  TOOLKIT_NAME=com.teracloud.streams.hdfs
  ifneq ($(realpath ../../$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_HDFS_TOOLKIT= ../../$(TOOLKIT_NAME)
  else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_HDFS_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
  else
    $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
  endif
endif

SPLC_FLAGS = -a -t $(STREAMSX_HDFS_TOOLKIT) --data-directory data

SPL_CMD_ARGS ?= 

SPLC = $(STREAMS_INSTALL)/bin/sc
SPL_MAIN_COMPOSITE1 = HDFS2FileSinkSampleLineFormat
SPL_MAIN_COMPOSITE2 = HDFS2FileSinkSampleTxtFormat
SPL_MAIN_DYNAMIC = DynamicFilename
BUILD_OUTPUT_DIR = output


all: data
	$(SPLC) $(SPLC_FLAGS) -M hdfsexample::$(SPL_MAIN_COMPOSITE1) --output-dir ./$(BUILD_OUTPUT_DIR)/$(SPL_MAIN_COMPOSITE1) $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -M hdfsexample::$(SPL_MAIN_COMPOSITE2) --output-dir ./$(BUILD_OUTPUT_DIR)/$(SPL_MAIN_COMPOSITE2) $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -M hdfsexample::$(SPL_MAIN_DYNAMIC) --output-dir ./$(BUILD_OUTPUT_DIR)/$(SPL_MAIN_DYNAMIC) $(SPL_CMD_ARGS)

data:
	mkdir data
clean:
	$(SPLC) $(SPLC_FLAGS) -C -M hdfsexample::$(SPL_MAIN_COMPOSITE1) --output-dir ./$(BUILD_OUTPUT_DIR)/$(SPL_MAIN_COMPOSITE1)
	$(SPLC) $(SPLC_FLAGS) -C -M hdfsexample::$(SPL_MAIN_COMPOSITE2) --output-dir ./$(BUILD_OUTPUT_DIR)/$(SPL_MAIN_COMPOSITE2)
	$(SPLC) $(SPLC_FLAGS) -C -M hdfsexample::$(SPL_MAIN_DYNAMIC) --output-dir ./$(BUILD_OUTPUT_DIR)/$(SPL_MAIN_DYNAMIC) $(SPL_CMD_ARGS)
	-rm -f toolkit.xml
	-rm -rf output
