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
# (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2009, 2009     
# All Rights reserved.                                             
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 
# Define some native functions written in C++ that can be invoked by SPL programs.
# In order to do this, we need to supply a 'native.function/function.xml' file that will
# describe the native functions to the SPL compiler.   It will also specify the location
# of the shared library implementing the functions, and the location of the C++ include file
# that will define the functions for use with the C++ generated from a user's SPL program.
#
# Compile the CPP file that contains the definitions of the native functions to a shared library

# =========== IMPORTANT ===========
# SPL native function support allows us to tap into the rich functions offered
# by the comprehensive SPL API. To do this, you need to #include "SPLFunctions.h"
# in your C++ files.  The invocation of dst-pkg-config.sh below will supply the
# -I lines to locate the SPL API
# =========== IMPORTANT ===========

SPL_PKGCFG=$(STREAMS_INSTALL)/bin/dst-pe-pkg-config.sh
SPL_PKG=dst-spl-pe-install
SPL_INCLUDE_OPTIONS = `$(SPL_PKGCFG) --cflags $(SPL_PKG)`

.PHONY: clean distclean force

all: lib/libSample.so 

Sample.o: Sample.cpp Sample.h
	@echo Compiling 'Sample.cpp' ...
	g++ -Wall -std=gnu++17 -fPIC $(SPL_INCLUDE_OPTIONS) -c Sample.cpp

# Now create a C++ shared library using the object (.o) file created in the previous step.
# After creating the shared library (.so) file, delete the object (.o) file. We don't need that anymore.
lib/libSample.so: Sample.o
	@-mkdir -p lib
	@echo Building C++ shared library '$@'
	@g++ -std=gnu++17 -shared -o $@ $<

clean:
	rm -rf *.o lib

distclean: clean
