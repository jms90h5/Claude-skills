# begin_generated_IBM_copyright_prolog                            
#                                                                 
# This is an automatically generated copyright prolog.            
# After initializing,  DO NOT MODIFY OR MOVE                      
# ****************************************************************
# Licensed Materials - Property of IBM                            
# 5724-Y95                                                        
# (C) Copyright IBM Corp.  2011, 2025    All Rights Reserved.     
# US Government Users Restricted Rights - Use, duplication or     
# disclosure restricted by GSA ADP Schedule Contract with         
# IBM Corp.                                                       
#                                                                 
# end_generated_IBM_copyright_prolog                              
# begin_generated_IBM_Teracloud_ApS_copyright_prolog               
#                                                                  
# This is an automatically generated copyright prolog.             
# After initializing,  DO NOT MODIFY OR MOVE                       
# **************************************************************** 
# Licensed Materials - Property of IBM                             
# (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2023, 2023     
# All Rights Reserved.                                             
# US Government Users Restricted Rights - Use, duplication or      
# disclosure restricted by GSA ADP Schedule Contract with          
# IBM Corp.                                                        
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 
SCRIPTS_PATH:=./scripts
ifndef STREAMS_INSTALL
$(error The Streams profile is not created. It must be sourced by <streams-installation-folder>/bin/streamsprofile.sh)
else 
ifeq ($(realpath $(STREAMS_INSTALL)),)
$(error Invalid path: $(STREAMS_INSTALL))
endif
endif
$(info STREAMS_INSTALL $(STREAMS_INSTALL))
GETCFG := $(SCRIPTS_PATH)/getcfg.pl
$(shell chmod +x $(GETCFG))
MAIN_COMPOSITES_LIST := $(realpath main_composites.lst)
SPLC := $(STREAMS_INSTALL)/bin/sc
SPLMTK := $(STREAMS_INSTALL)/bin/spl-make-toolkit
LOOKUP_CUSTOM_XML?=$(realpath ./LookupMgrCustomizing.xml)
DATA_DIR := $(abspath ./data)
SPLC_FLAGS?=
DEFAULT_SPLC_FLAGS+=-a
DEFAULT_SPLC_FLAGS+=--data-directory=$(DATA_DIR)
XSLT := xsltproc

# check existence of Telecommunications Event Data Analytics toolkit in streams installation, try SPLPATH otherwise
ifneq ($(wildcard $(STREAMS_INSTALL)/toolkits/com.teracloud.streams.teda),)
DEFAULT_TOOLKITS:=$(STREAMS_INSTALL)/toolkits/com.teracloud.streams.teda
else
DEFAULT_TOOLKITS:=$(STREAMS_SPLPATH)
endif
ADDITIONAL_TOOLKITS ?=
ifneq ($(LOOKUP_CUSTOM_XML),)
export LOOKUP_CUSTOM_XML:=${LOOKUP_CUSTOM_XML}
SPL_MAIN_COMPOSITE_NAME := LookupManagerMain
DB_SWITCH := $(shell $(GETCFG) -s LookupManager lm.db | tr '[:upper:]' '[:lower:]' )
DB_VENDOR := $(shell $(GETCFG) -s LookupManager lm.db.vendor | tr '[:upper:]' '[:lower:]' )
XML_VERSION=$(shell cd scripts; perl -I$$PWD -MCodeGenFrw -e 'print CodeGenFrw::getSchemaVersion("$(LOOKUP_CUSTOM_XML)")')
#$(info XML_VERSION: ${XML_VERSION})
LOOKUP_CUSTOM_XML_OLD:=$(patsubst %.xml,%.old.xml,${LOOKUP_CUSTOM_XML})
LOOKUP_CUSTOM_XSD_OLD:=$(realpath ./etc/LookupMgrCustomizing_1.0.xsd)
LOOKUP_CUSTOM_XSD:=$(patsubst %.xml,%.xsd,${LOOKUP_CUSTOM_XML})
LOOKUP_CUSTOM_XSLT:=$(realpath ./etc/LookupMgrCustomizing.xslt)
else
SPL_MAIN_COMPOSITE_NAME := ITEMain
DB_SWITCH ?= off
DB_VENDOR ?= 
endif

HOSTSFILE:=$(CURDIR)/config/hosttags.txt

ifeq ($(LOOKUP_CUSTOM_XML),)
ADDITIONAL_TOOLKITS:=$(ADDITIONAL_TOOLKITS)
else
ADDITIONAL_TOOLKITS:=$(ADDITIONAL_TOOLKITS):$(STREAMS_INSTALL)/toolkits/com.ibm.streams.db
endif

SPL_MAIN_COMPOSITE_LIST ?= $(MAIN_COMPOSITES_LIST)
SPL_MAIN_COMPOSITE ?= $(shell COMPS=`cat $(SPL_MAIN_COMPOSITE_LIST)| grep -v ^\#`; echo "$$COMPS") 
TOOLKITLIST_PATH ?= $(realpath $(CURDIR))
TOOLKITLIST_XML := $(realpath $(TOOLKITLIST_PATH)/toolkitsList.xml)
TOOLKITS ?=$(ADDITIONAL_TOOLKITS)
ifneq ($(TOOLKITLIST_XML),)
TOOLKITS :=$(TOOLKITS):$(TOOLKITLIST_XML)
endif
TOOLKITS :=$(TOOLKITS):$(DEFAULT_TOOLKITS)

include Makefile.options
ifneq (,$(CXXFLAGS))
  CXXFLAGS := --cxx-flags='$(CXXFLAGS)'
endif

.PHONY: build pre-build env_check custom_xml clean all hosttags help

build: pre-build
	@for MAIN_COMPOSITE in $(SPL_MAIN_COMPOSITE) ; do \
		MAIN_COMPOSITE_NAME=`echo $$MAIN_COMPOSITE | awk -F\: '{print $$(3)}'` ;\
		SPLCFLAGS=`echo "$(SPLC_FLAGS) $(DEFAULT_SPLC_FLAGS) --output-directory=output/$$MAIN_COMPOSITE_NAME"` ;\
		echo "$(SPLC) $$SPLCFLAGS -M $$MAIN_COMPOSITE -t $(TOOLKITS) $(SPLC_CMD_ARGS) $(CXXFLAGS)"; \
		$(SPLC) $$SPLCFLAGS -M $$MAIN_COMPOSITE -t $(TOOLKITS) $(SPLC_CMD_ARGS) $(CXXFLAGS); RET=$$? ;\
		if [ $$RET != 0 ] ; then echo LEAVE ON ERROR $$RET; exit $$RET; fi ; \
	done

pre-build: env_check custom_xml

all: clean build

clean: 
	@for MAIN_COMPOSITE in $(SPL_MAIN_COMPOSITE) ; do \
		MAIN_COMPOSITE_NAME=`echo $$MAIN_COMPOSITE | awk -F\: '{print $$(3)}'` ;\
		SPLCFLAGS=`echo "$(SPLC_FLAGS) --output-directory=output/$$MAIN_COMPOSITE_NAME"` ;\
		echo "$(SPLC) $$SPLCFLAGS -C -M $$MAIN_COMPOSITE -t $(TOOLKITS)"; \
		$(SPLC) $$SPLCFLAGS -C -M $$MAIN_COMPOSITE -t $(TOOLKITS); \
	done
	@rm -Rf output
	@rm -f $(HOSTSFILE)

custom_xml:
	@touch ".mkrun";
	@if [ "${LOOKUP_CUSTOM_XML}" != "" ] ; then \
		cd $(SCRIPTS_PATH);\
		if [ "${XML_VERSION}" != "2.0" ] ; then \
			xmllint --noout --schema ${LOOKUP_CUSTOM_XSD_OLD} ${LOOKUP_CUSTOM_XML};\
			VALID_OLD=$$?;\
			if [ "0" != "$$VALID_OLD" ] ; then \
				echo -ne "ERROR:Validation error of the customizing file.\nThe customizing file ${LOOKUP_CUSTOM_XML} must be corrected and\nto be valid against ${LOOKUP_CUSTOM_XSD}\nManual transformation is required.\n";\
				exit 2;\
			fi;\
			cp -vf ${LOOKUP_CUSTOM_XML} ${LOOKUP_CUSTOM_XML_OLD} ;\
			${XSLT} -o ${LOOKUP_CUSTOM_XML} ${LOOKUP_CUSTOM_XSLT} ${LOOKUP_CUSTOM_XML_OLD} ;\
			RET=$$?;\
			if [ $$RET == 0 ] ; then \
				VALID=`perl -I$$PWD -MCodeGenFrw -e 'print CodeGenFrw::validateXmlFile("$(LOOKUP_CUSTOM_XML)")'`;\
				if [ "0" != "$$VALID" ] ; then \
					echo -ne "ERROR: Transformation error of the customizing file. Manual transformation required.\n the file ${LOOKUP_CUSTOM_XML}\n must must follow the XSD ${LOOKUP_CUSTOM_XSD}\n";\
					exit 2;\
				fi;\
			else \
				echo "ERROR: Transformation of the customizing file ${LOOKUP_CUSTOM_XML} failed!" ;\
				exit 2;\
			fi;\
		fi; \
		perl -I$$PWD -MCodeGenFrw -e 'CodeGenFrw::createSchemaDefinitionFile("$(LOOKUP_CUSTOM_XML)")';\
		cd ..;\
	fi

env_check:
	@if [ ! -d $(DATA_DIR) ] ; then mkdir data ; fi
	@if [ "$(DB_SWITCH)" == "on" ] ; then \
		if [ "$(DB_VENDOR)" == "db2" ] ; then \
			if [ "" != "$(STREAMS_ADAPTERS_ODBC_DB2)" ] ; then \
				if [ "" !=  "$(STREAMS_ADAPTERS_ODBC_ORACLE)" ] ; then \
					echo "ERROR: ORACLE SET in parallel" ;\
					exit 2;\
				fi;\
			else \
				echo "ERROR: STREAMS_ADAPTERS_ODBC_DB2 must be set" ;\
				exit 2;\
			fi ;\
		fi ; \
		if [ "$(DB_VENDOR)" == "oracle" ] ; then \
			if [ "" != "$(STREAMS_ADAPTERS_ODBC_ORACLE)" ] ; then \
				if [ "" !=  "$(STREAMS_ADAPTERS_ODBC_DB2)" ] ; then \
					echo "ERROR: ORACLE SET in parallel" ;\
					exit 2;\
				fi;\
			else \
				echo "ERROR: STREAMS_ADAPTERS_ODBC_ORACLE must be set" ;\
				exit 2;\
			fi ;\
		fi ;\
	fi

hosttags: pre-build
	@ $(SPLMTK) -i .
	@ $(SPLMTK) -i . -c
	@ rm -fR etc/config
	@ if  [ -f $(HOSTSFILE) ] ; then echo `ls $(HOSTSFILE)` ;fi
	
help:
	@echo -ne "make <all|clean|help> [SPLC_CMD_ARGS=<value> TOOLKITLIST_PATH=<value> (options)\n\tSPL_MAIN_COMPOSITE_LIST=<value>|SPL_MAIN_COMPOSITE=<value> SPLC_FLAGS=<value>] \n"
	@echo "Input definitions:"
	@echo -ne "\tSPLC_CMD_ARGS - spl-compiler command arguments e.g.\"applDbg=g\"\n\t\t(default: empty)\n"
	@echo -ne "\tTOOLKITLIST_PATH - path to toolkitsList.xml\n"
	@echo -ne "\tADDITIONAL_TOOLKITS - the ':'-separated list of single toolkit paths. default: $(ADDITIONAL_TOOLKITS).\n"
	@echo -ne "\tSPL_MAIN_COMPOSITE_LIST - optional file listing the main composite spl/splmm files(curent: $(SPL_MAIN_COMPOSITE_LIST)\n"
	@echo -ne "\tSPL_MAIN_COMPOSITE - optional main composites name.\n"
	@echo -ne "\tSPLC_FLAGS - flag for spl-compiler default: $(SPLC_FLAGS).\n"
