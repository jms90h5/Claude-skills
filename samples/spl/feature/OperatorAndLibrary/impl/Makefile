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
# (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2010, 2017     
# All Rights reserved.                                             
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 
SPL_PKGCFG=$(STREAMS_INSTALL)/bin/dst-pe-pkg-config.sh
SPL_PKG=dst-spl-pe-install
SPL_INCLUDE_OPTIONS = `$(SPL_PKGCFG) --cflags $(SPL_PKG)`

ifeq ($(CXX),g++)
  PLATFORM := $(shell uname -i)
  ifeq ($(PLATFORM),ppc64)
    CXX=/opt/at7.0/bin/g++
  endif
  ifeq ($(PLATFORM),ppc64le)
    CXX=/opt/at8.0/bin/g++
  endif
endif

.PHONY: clean distclean

all: lib/libMySampleLib.so 

lib/MySampleLib.o: src/MySampleLib.cpp include/MySampleLib.h
	@echo Compiling 'src/MySampleLib.cpp' ...
	@$(CXX) -std=c++17 -Wall -fPIC -I include $(SPL_INCLUDE_OPTIONS) \
             -c src/MySampleLib.cpp -o $@

lib/libMySampleLib.so: lib/MySampleLib.o
	@echo Building C++ shared library '$@'
	@$(CXX) -std=c++17 -shared -o $@ $<

clean:
	rm -rf lib/MySampleLib.o lib/libMySampleLib.so

distclean: clean

