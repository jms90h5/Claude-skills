.PHONY: all distributed clean 

ifndef NETWORK_TOOLKIT
  TOOLKIT_NAME=com.teracloud.streams.network
  ifneq ($(realpath ../../$(TOOLKIT_NAME)/toolkit.xml),)
    NETWORK_TOOLKIT = ../../$(TOOLKIT_NAME)
  else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
    NETWORK_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
  else
    $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
  endif
endif

SPLC_FLAGS ?= 
SPLC = $(STREAMS_INSTALL)/bin/sc
SAMPLE_TOOLKIT = ../SampleNetworkToolkitData
SPL_CMD_ARGS ?= 
SPL_MAIN_NAMESPACE = sample

all: distributed

distributed:
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::LiveDNSMessageParserAnalysis $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::LiveDNSMessageParserBasic $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::LiveDNSMessageParserERSPAN $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::LiveDNSMessageParserParallelAnalysis $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestDNSMessageParserAnalysis $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestDNSMessageParserBase64 $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestDNSMessageParserBasic $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestDNSMessageParserErrors $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestDNSMessageParserERSPAN $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestDNSMessageParserFilters $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestDNSMessageParserFull $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestDNSMessageParserParallelAnalysis $(SPL_CMD_ARGS)

clean:
	rm -rf output toolkit.xml

