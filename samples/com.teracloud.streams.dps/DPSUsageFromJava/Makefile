# begin_generated_IBM_copyright_prolog                             
#                                                                  
# This is an automatically generated copyright prolog.             
# After initializing,  DO NOT MODIFY OR MOVE                       
# **************************************************************** 
# THIS SAMPLE CODE IS PROVIDED ON AN "AS IS" BASIS. IBM MAKES NO   
# REPRESENTATIONS OR WARRANTIES, EXPRESS OR IMPLIED, CONCERNING    
# USE OF THE SAMPLE CODE, OR THE COMPLETENESS OR ACCURACY OF THE   
# SAMPLE CODE. IBM DOES NOT WARRANT UNINTERRUPTED OR ERROR-FREE    
# OPERATION OF THIS SAMPLE CODE. IBM IS NOT RESPONSIBLE FOR THE    
# RESULTS OBTAINED FROM THE USE OF THE SAMPLE CODE OR ANY PORTION  
# OF THIS SAMPLE CODE.                                             
#                                                                  
# LIMITATION OF LIABILITY. IN NO EVENT WILL IBM BE LIABLE TO ANY   
# PARTY FOR ANY DIRECT, INDIRECT, SPECIAL OR OTHER CONSEQUENTIAL   
# DAMAGES FOR ANY USE OF THIS SAMPLE CODE, THE USE OF CODE FROM    
# THIS [ SAMPLE PACKAGE,] INCLUDING, WITHOUT LIMITATION, ANY LOST  
# PROFITS, BUSINESS INTERRUPTION, LOSS OF PROGRAMS OR OTHER DATA   
# ON YOUR INFORMATION HANDLING SYSTEM OR OTHERWISE.                
#                                                                  
# (C) Copyright IBM Corp. 2016  All Rights reserved.         
#                                                                  
# end_generated_IBM_copyright_prolog                               

ifndef STREAMS_INSTALL
  $(error ERROR: the STREAMS_INSTALL environment variable is not set. Source the <streams-install-dir>/bin/streamsprofile.sh script file to set up your environment.)
endif

# You may need to set the STREAMSX_DPS_TOOLKIT variable if the toolkit cannot be found locally or in the Streams install.
ifndef STREAMSX_DPS_TOOLKIT
  TOOLKIT_NAME=com.teracloud.streams.dps
  ifneq ($(realpath ../../../$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_DPS_TOOLKIT = ../../../$(TOOLKIT_NAME)
  else ifneq ($(realpath $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)/toolkit.xml),)
    STREAMSX_DPS_TOOLKIT = $(STREAMS_INSTALL)/toolkits/$(TOOLKIT_NAME)
  else
    $(error ERROR: Valid $(TOOLKIT_NAME) toolkit not found in $(STREAMS_INSTALL)/toolkits)
  endif
endif

# The dps-helper is copied from the DPS toolkit directory to the 
# impl/java/lib directory of this application to ensure it is 
# included in the SAB file.
DPS_HELPER_JAR = $(STREAMSX_DPS_TOOLKIT)/impl/java/lib/dps-helper.jar

SPLC_FLAGS ?= -a -t $(STREAMSX_DPS_TOOLKIT)
SPLC = $(STREAMS_INSTALL)/bin/sc
SPL_CMD_ARGS ?= --data-directory=./data 
SPL_MAIN_COMPOSITE = application::JavaDPSDemo
JAVA_CLASS_FILES = impl/java/src/application/DataStoreTester.java impl/java/src/application/TickerIdGenerator.java

all: distributed

distributed: java
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) $(SPL_CMD_ARGS)

java: $(JAVA_CLASS_FILES)
	mkdir -p impl/java/lib
	cp $(DPS_HELPER_JAR) impl/java/lib || echo "Falling back to dps-helper.jar in $(STREAMS_INSTALL)/toolkits/com.teracloud.streams.dps" && cp $(STREAMS_INSTALL)/toolkits/com.teracloud.streams.dps/impl/java/lib/dps-helper.jar impl/java/lib
	JAVA_HOME=$(STREAMS_JAVA_HOME) ant

clean: 
	ant clean
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE)
	rm -rf output/JavaDPSDemo/Distributed
	rm -f impl/lib/dps-helper.jar

