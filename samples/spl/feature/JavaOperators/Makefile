# begin_generated_IBM_Teracloud_ApS_copyright_prolog               
#                                                                  
# This is an automatically generated copyright prolog.             
# After initializing,  DO NOT MODIFY OR MOVE                       
# **************************************************************** 
# THIS SAMPLE CODE IS PROVIDED ON AN "AS IS" BASIS.                
# TERACLOUD APS AND IBM MAKES NO REPRESENTATIONS OR WARRANTIES,    
# EXPRESS OR IMPLIED, CONCERNING  USE OF THE SAMPLE CODE, OR THE   
# COMPLETENESS OR ACCURACY OF THE SAMPLE CODE. TERACLOUD APS       
# AND IBM DOES NOT WARRANT UNINTERRUPTED OR ERROR-FREE OPERATION   
# OF THIS SAMPLE CODE. TERACLOUD APS AND IBM IS NOT RESPONSIBLE FOR THE 
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
# (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2010, 2015     
# All Rights reserved.                                             
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 
.PHONY: all clean dist distributed javacompile data-dir

SPLC = $(STREAMS_INSTALL)/bin/sc
SPLC_FLAGS = -a 
ifeq ($(STREAMS_STUDIO_BUILDING), 1)
  # Building from Streams Studio
  SPLC_FLAGS += --no-toolkit-indexing --no-mixed-mode-preprocessing
endif
SPL_MAIN_COMPOSITE = sample::JavaOperators
SPL_DATA_DIR ?= ./data
SPL_CMD_ARGS ?= 

BIN_LOC=impl/java/bin
JSI = $(STREAMS_INSTALL)

all: data-dir distributed

data-dir:
	mkdir -p $(SPL_DATA_DIR)

javacompile: $(BIN_LOC) $(BIN_LOC)/sample/DirectoryPropertyLister.class

$(BIN_LOC)/sample/DirectoryPropertyLister.class: impl/java/src/sample/DirectoryPropertyLister.java
	javac -g -classpath $(JSI)/lib/com.ibm.streams.operator.jar -d $(BIN_LOC) impl/java/src/sample/DirectoryPropertyLister.java

$(BIN_LOC):
	mkdir -p $(BIN_LOC)

distributed: javacompile dist

dist:
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) --data-directory $(SPL_DATA_DIR) $(SPL_CMD_ARGS)

clean: 
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE)
	rm -rf $(BIN_LOC)

