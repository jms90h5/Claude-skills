# Copyright (C)2018, International Business Machines Corporation and  
# others. All Rights Reserved.                        
.PHONY: all clean

SPLC_FLAGS = -a
OUTPUT_DIR = ./output

ifndef STREAMS_INSTALL
  $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif
# You may need to set the STREAMSX_AVRO_TOOLKIT variable if the toolkit cannot be found locally or in the Streams install.
ifndef STREAMSX_AVRO_TOOLKIT
  TOOLKIT_NAME=com.teracloud.streams.avro
  ifneq ($(realpath ../../$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_AVRO_TOOLKIT = ../../$(TOOLKIT_NAME)
  else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_AVRO_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
  else
    $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
  endif
endif
SPLC = $(STREAMS_INSTALL)/bin/sc
SPL_PATH = $(STREAMS_INSTALL)/toolkits/com.teracloud.streams.json:$(STREAMSX_AVRO_TOOLKIT)

SPLC_FLAGS += -t $(SPL_PATH)

SPLC = $(STREAMS_INSTALL)/bin/sc

SPL_CMD_ARGS ?=
SPL_MAIN_COMPOSITE = com.teracloud.streams.avro.sample::WriteAvroFileSample


all:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) --output-dir $(OUTPUT_DIR) $(SPL_CMD_ARGS)

clean:
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE)
	rm -rf $(OUTPUT_DIR)
	rm -rf doc

