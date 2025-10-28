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

COMPOSITE_NAME = KafkaClientIdSample
SPL_NAMESPACE = com.teracloud.streams.kafka.sample
SPL_MAIN_COMPOSITE = $(SPL_NAMESPACE)::$(COMPOSITE_NAME)
OUTPUT_DIR = output/$(SPL_NAMESPACE).$(COMPOSITE_NAME)

SPLC_FLAGS = -a
SPLC = $(STREAMS_INSTALL)/bin/sc
SPL_PATH = $(STREAMSX_KAFKA_TOOLKIT)

all:
	if [ -x ../../gradlew ]; then \
	  ../../gradlew build; \
	else \
	  $(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) --output-directory $(OUTPUT_DIR) -t $(SPL_PATH); \
	fi

clean:
	if [ -x ../../gradlew ]; then \
	  ../../gradlew clean; \
	else \
	  $(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE) --output-directory $(OUTPUT_DIR); \
	fi
