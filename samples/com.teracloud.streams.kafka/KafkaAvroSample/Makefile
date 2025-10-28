.PHONY: all clean

ifndef STREAMS_INSTALL
  $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif

# You may need to set the STREAMSX_KAFKA_TOOLKIT variable if the toolkit cannot be found locally or in the Streams install.
ifndef STREAMSX_KAFKA_TOOLKIT
  TOOLKIT_NAME=com.teracloud.streams.kafka
  ifneq ($(realpath ../../$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_KAFKA_TOOLKIT = ../../$(TOOLKIT_NAME)
  else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_KAFKA_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
  else
    $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
  endif
endif

# You may override these variables if you wish to use a custom toolkit outside of the Streams install
STREAMSX_AVRO_TOOLKIT ?= $(STREAMS_INSTALL)/toolkits/com.teracloud.streams.avro

COMPOSITE_NAME = KafkaAvroSample
SPL_NAMESPACE = com.teracloud.streams.kafka.sample
SPL_MAIN_COMPOSITE = $(SPL_NAMESPACE)::$(COMPOSITE_NAME)
OUTPUT_DIR = output/$(SPL_NAMESPACE).$(COMPOSITE_NAME)

SPLC_FLAGS = -a
SPLC = $(STREAMS_INSTALL)/bin/sc
SPL_PATH = $(STREAMSX_KAFKA_TOOLKIT):$(STREAMSX_AVRO_TOOLKIT)

all:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) --output-directory $(OUTPUT_DIR) -t $(SPL_PATH); \

clean:
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE) --output-directory $(OUTPUT_DIR); \
	rm -rf $(OUTPUT_DIR)
	rm -rf doc
