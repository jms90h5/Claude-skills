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
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestIPAddressLocationBasic1 $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestIPAddressLocationBasic2 $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestIPAddressLocationBasic3ControlPort $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestIPAddressLocationBasicIPv6 $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestIPAddressLocationFull $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestIPAddressLocationGeohash $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT):$(SAMPLE_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestIPAddressLocationList $(SPL_CMD_ARGS)

clean:
	rm -rf output toolkit.xml

