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
SPL_CMD_ARGS ?= 
SPL_MAIN_NAMESPACE = sample
SPL_MAIN_COMPOSITE = sample::TestIPv4AddressFunctions

all: distributed

distributed:
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestIPv4AddressFunctions $(SPL_CMD_ARGS)
	$(SPLC) $(SPLC_FLAGS) -t $(NETWORK_TOOLKIT) -M $(SPL_MAIN_NAMESPACE)::TestIPv6AddressFunctions $(SPL_CMD_ARGS)

clean:
	rm -rf output toolkit.xml

