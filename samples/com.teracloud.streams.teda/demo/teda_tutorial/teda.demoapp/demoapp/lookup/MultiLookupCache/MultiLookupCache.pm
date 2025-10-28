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
package MultiLookupCache;

use strict;
use warnings;
use Data::Dumper;
use Exporter 'import';
unshift @INC, (reverse(glob(sprintf("%s/toolkits/com.teracloud.streams.teda*/impl/nl/include", $ENV{STREAMS_INSTALL}))))[0];
require TedaToolkitResource;


our $inputPort;
our $inTupleName;
our $inTupleType;
our $outputPort;
our $outTupleType;

our $releaseMode;
our $useThreads;
our $segmentNamePrefix;
our $disableLookup;

our %uniqueStores;				#the value contains the index to storeVector
our @storeVector;				#the list with all sore names
our @storeSegmentIndexVector;	#the value is the index to the segment vector
our %uniqueSegments;			#the value is the index in segment vector
our @segmentVector;				#the list of segments to be used
our @segmentUseCountVector;
our $numberOfStores;
our $numberOfSegments;
our @keyTypeVector;				#indexed by stores - the cpp type
our @keySPLTypeVector;			#indexed by stores
our @valueTypeVector;			#indexed by stores - the cpp type
our @valueSPLTypeVector;		#indexed by stores
our @containerTypeVector;		#indexed by stores -  the cpp type

# Find functions are : Find, FilterFind, FindAssign, FilterFindAssign
our $numberOfOutputAttributes;
our @outputAssignementFunctionNameVector;			#indexed by output stream attribute index - the name of the COF if any
our @outputAssignementIsFindFunctionVector;			#indexed by output stream attribute index - 1 if Find function, 0 otherwise
our @outputAssignementIsAssignFunctionVector;		#indexed by output stream attribute index - 1 if function with assignment, 0 otherwise
our @outputAssignementAttributeNameVector;			#indexed by output stream attribute index - the name of the output attribute
our @outputAssignementStoreIndexVector;				#indexed by output stream attribute index - the store index for each Find or Has function, -1 otherwise
our @outputAssignementParamKeyVector;				#indexed by output stream attribute index - the expression for the key or param1 for AsIs, undef otherwise
our @outputAssignementParamDefaultVector;			#indexed by output stream attribute index - the expression for the default value if any, undef otherwise
our @outputAssignementParamFilterVector;			#indexed by output stream attribute index - the expression for the filter value if any, undef otherwise
our @outputAssignementParamValueVector;				#indexed by output stream attribute index - the expression for the filter value if any, undef otherwise
our @outputAssignementHasAttributeNameVector;		#indexed by output stream attribute index - the attribute name of the corresponding has function
our @outputAssignementAssociatedFindFunctionIndex;	#indexed by output stream attribute index - is valid for has functions and is the index if the associated find function
our $numberOfFindFunctions;							#is the number of required threads
our @threadToOutpuAssignementIndex;					#the tread to output assignment index

sub intro {
	my ($model) = @_;
	$inputPort = $model->getInputPortAt(0);
	$inTupleName = $inputPort->getCppTupleName();
	$inTupleType = $inputPort->getCppTupleType();
	$outputPort = $model->getOutputPortAt(0);
	$outTupleType = $outputPort->getCppTupleType();

	#check equal schema input and output port
	#my $inTupleSPLType =  $inputPort->getSPLTupleType();
	#my $outTupleSPLType = $outputPort->getSPLTupleType();
	#if ($inTupleSPLType ne $outTupleSPLType) {
	#	SPL::CodeGen::errorln("Input port type and output port type must be equal $inTupleSPLType ne $outTupleSPLType", $inputPort->getSourceLocation());
	#}

	$releaseMode = $model->getParameterByName("releaseMode");
	$releaseMode = $releaseMode ? $releaseMode->getValueAt(0)->getSPLExpression() : "punct";
	print "\t//releaseMode: $releaseMode\n";
	
	$useThreads = $model->getParameterByName("useThreads");
	if ($useThreads && ( ! $model->getParameterByName("useThreads")->getValueAt(0)->getSPLExpressionTree()->isLiteral())) {
		SPL::CodeGen::errorln(TedaToolkitResource::TEDA_MUST_BE_LITERAL("useThreads"), $useThreads->getSourceLocation());
	}
	$useThreads = $useThreads ? $useThreads->getValueAt(0)->getSPLExpression() : "false";
	print "\t//\$useThreads: $useThreads\n";
	if ($useThreads eq "true") {
		SPL::CodeGen::errorln(TedaToolkitResource::TEDA_NOT_IMPLEMENTED());
	}

	$segmentNamePrefix = $model->getParameterByName("segmentNamePrefix");
	if ($segmentNamePrefix) {
		$segmentNamePrefix = $segmentNamePrefix->getValueAt(0)->getCppExpression();
		print "\t//\$segmentNamePrefix: '$segmentNamePrefix'\n";
	} else {
		print "\t//\$segmentNamePrefix: undef\n";
	}

	$disableLookup = $model->getParameterByName('disableLookup');
	if ($disableLookup) {
		$disableLookup = $disableLookup->getValueAt(0)->getCppExpression();
		print "\t//disableLookup: $disableLookup\n";
	} else {
		print "\t//disableLookup: undef\n";
	};
	
	#build @storeVector and @segmentVector from parameter storeSegmentPairs
	my $pairs = $model->getParameterByName("storeSegmentPairs");
	my $numberOfPairs = $pairs->getNumberOfValues();
	my $segmentIndex = 0;
	for (my $i = 0; $i < $numberOfPairs; $i++) {
		my $expression = $pairs->getValueAt($i);
		my $tree = $expression->getSPLExpressionTree();
		my $isLiteral = $tree->isLiteral();
		my $pair = $expression->getSPLExpression();
		$pair =~ s/ |(\\t)//g; #remove space and tab
		print "\t//\$pair: $pair \$isLiteral: $isLiteral\n";
		if (! $isLiteral ) {
			SPL::CodeGen::errorln(TedaToolkitResource::TEDA_PAIR_AS_LITERAL("$pair"), $pairs->getSourceLocation());
			next;
		}
		$pair =~ s/^[^"]*"(.*)"[^"]*$/$1/;
		my @l = split(/:/, $pair);
		print "\t//Split: @l\n";
		if ($#l != 1) {
			SPL::CodeGen::errorln(TedaToolkitResource::TEDA_MISSING_COLON_IN_PAIR("$pair"), $pairs->getSourceLocation());
			next;
		}
		if (defined($uniqueStores{$l[0]})) {
			SPL::CodeGen::errorln(TedaToolkitResource::TEDA_UNIQUE_STORE("$l[0]"), $pairs->getSourceLocation());
			next;
		} else {
			$uniqueStores{$l[0]} = $i;
			$storeVector[$i] = $l[0];
		}
		my $storeSegIndex;
		if (defined($uniqueSegments{$l[1]})) {
			$storeSegIndex = $uniqueSegments{$l[1]};
			$segmentUseCountVector[$storeSegIndex]++;
		} else {
			$uniqueSegments{$l[1]} = $segmentIndex;
			$segmentVector[$segmentIndex] = $l[1];
			$segmentUseCountVector[$segmentIndex] = 1;
			$storeSegIndex = $segmentIndex;
			$segmentIndex++;
		}
		$storeSegmentIndexVector[$i] = $storeSegIndex;
	}
	$numberOfStores = @storeVector;
	$numberOfSegments = @segmentVector;
	
	#iterate through output functions an build outputAssignement vectors
	$numberOfFindFunctions = 0;
	$numberOfOutputAttributes = $outputPort->getNumberOfAttributes();
	for (my $i = 0; $i < $numberOfOutputAttributes; $i++) {
		#$outputAssignementFunctionNameVector[$i] = '';
		$outputAssignementIsFindFunctionVector[$i] = 0;
		$outputAssignementIsAssignFunctionVector[$i] = 0;
		$outputAssignementStoreIndexVector[$i] = -1;
		$outputAssignementAssociatedFindFunctionIndex[$i] = -1;
		my $attribute = $outputPort->getAttributeAt($i);
		my $attributeName = $attribute->getName();
		$outputAssignementAttributeNameVector[$i] = $attributeName;
		if ($attribute->hasAssignmentWithOutputFunction()) {
			my $of = $attribute->getAssignmentOutputFunctionName();
			$outputAssignementFunctionNameVector[$i]=$of;
			if (($of eq "Find") || ($of eq "FilterFind") || ($of eq "Has") || ($of eq "FilterHas") || ($of eq "FindAssign") || ($of eq "FilterFindAssign")) {
				print "\t//\$of=$of\n";
				if (($of eq "Find") || ($of eq "FilterFind") || ($of eq "FindAssign") || ($of eq "FilterFindAssign")) { # This is a Find Function
					$outputAssignementIsFindFunctionVector[$i] = 1;
					$threadToOutpuAssignementIndex[$numberOfFindFunctions] = $i;
					$numberOfFindFunctions++;
				}
				if (($of eq "FindAssign") || ($of eq "FilterFindAssign")) { # This is a Assignement function
					$outputAssignementIsAssignFunctionVector[$i] = 1;
				}
				#store (param 0)
				my $param = $attribute->getAssignmentOutputFunctionParameterValueAt(0); # the first param is the store
				my $store = $param->getSPLExpression();
				my $tree = $param->getSPLExpressionTree();
				if (! $tree->isLiteral()) {
					SPL::CodeGen::errorln(TedaToolkitResource::TEDA_FIRST_PARAMETER_AS_LITERAL("$of"), $param->getSourceLocation());
					next;
				}
				#we take always the pure literal without quotes
				$store =~ s/^[^"]*"(.*)"[^"]*$/$1/;
				#my $g = SPL::Operator::Instance::ExpressionTreeCppGenVisitor->new();
				#$g->visit($tree);
				#my $cppCode = $g->getCppCode();
				#$cppCode contains a C++ expression that will evaluate to the expression.
				
				#check if param0 is a known store and determine $storeindex
				if (defined($uniqueStores{$store})) {
					my $storeindex = $uniqueStores{$store};
					$outputAssignementStoreIndexVector[$i] = $storeindex;
					#param1 -> key
					$param = $attribute->getAssignmentOutputFunctionParameterValueAt(1);
					my $paramCppExp = $param->getCppExpression();
					my $paramSPLExp = $param->getSPLExpression();
					my $paramCppType = $param->getCppType();
					my $paramSPLType = $param->getSPLType();

					#determine value type from return
					my $valueCppType;
					my $valueSPLType;
					if (($of eq "Find") || ($of eq "FilterFind")) {
						$valueCppType = $attribute->getCppType();
						$valueSPLType = $attribute->getSPLType();
					}

					#check if already known key type of store and check.
					if (defined($keySPLTypeVector[$storeindex])) {
						if ($keySPLTypeVector[$storeindex] ne $paramSPLType) {
							SPL::CodeGen::errorln(TedaToolkitResource::TEDA_INVALID_KEY_TYPE("$paramSPLType", "$keySPLTypeVector[$storeindex]"), $param->getSourceLocation());
							next;
						}
					} else {
						$keySPLTypeVector[$storeindex] = $paramSPLType;
						$keyTypeVector[$storeindex] = $paramCppType;
					}
					
					$outputAssignementParamKeyVector[$i] = $param;
					#param 2 
					if ($attribute->getAssignmentOutputFunctionParameterValueAt(2)) {
						$param = $attribute->getAssignmentOutputFunctionParameterValueAt(2);
						$paramCppExp = $param->getCppExpression();
						$paramSPLExp = $param->getSPLExpression();
						$paramCppType = $param->getCppType();
						$paramSPLType = $param->getSPLType();
						if ($of eq "Find") {
							$outputAssignementParamDefaultVector[$i] = $param;
						} elsif (($of eq "FilterFind") || ($of eq "FilterHas") || ($of eq "FilterFindAssign")) {
							$outputAssignementParamFilterVector[$i] = $param;
						} elsif ($of eq "FindAssign") {
							$outputAssignementParamValueVector[$i] = $param;
							$valueCppType = $paramCppType;
							$valueSPLType = $paramSPLType;
						} else { # remains Has
							SPL::CodeGen::errorln(TedaToolkitResource::TEDA_TOO_MANY_PARAMETERS("$of", 2), $param->getSourceLocation());
							next;
						}
						if ($attribute->getAssignmentOutputFunctionParameterValueAt(3)) {
							$param = $attribute->getAssignmentOutputFunctionParameterValueAt(3);
							$paramCppExp = $param->getCppExpression();
							$paramSPLExp = $param->getSPLExpression();
							$paramCppType = $param->getCppType();
							$paramSPLType = $param->getSPLType();
							if (($of eq "FilterFind") || ($of eq "FindAssign")) {
								$outputAssignementParamDefaultVector[$i] = $param;
							} elsif ($of eq "FilterFindAssign") {
								$outputAssignementParamValueVector[$i] = $param;
								$valueCppType = $paramCppType;
								$valueSPLType = $paramSPLType;
							} else {
								SPL::CodeGen::errorln(TedaToolkitResource::TEDA_TOO_MANY_PARAMETERS("$of", 3), $param->getSourceLocation());
								next;
							}
							if ($attribute->getAssignmentOutputFunctionParameterValueAt(4)) {
								if ($of eq 'FilterFindAssign') {
									$param = $attribute->getAssignmentOutputFunctionParameterValueAt(4);
									$paramCppExp = $param->getCppExpression();
									$paramSPLExp = $param->getSPLExpression();
									$paramCppType = $param->getCppType();
									$paramSPLType = $param->getSPLType();
									$outputAssignementParamDefaultVector[$i] = $param;
								} else {
									SPL::CodeGen::errorln(TedaToolkitResource::TEDA_TOO_MANY_PARAMETERS("$of", 4), $param->getSourceLocation());
									next;
								}
							}
						}
					} else {
						if (($of ne "Find") && ($of ne "Has")) {
							SPL::CodeGen::errorln(TedaToolkitResource::TEDA_TOO_LESS_PARAMETERS("$of", 3), $attribute->getAssignmentSourceLocation());
						}
					}
					
					#check if already known value type and check (Find functions only)
					if ($outputAssignementIsFindFunctionVector[$i]) {
						if (defined($valueSPLTypeVector[$storeindex])) {
							if ($valueSPLTypeVector[$storeindex] ne $valueSPLType) {
								SPL::CodeGen::errorln(TedaToolkitResource::TEDA_INVALID_VALUE_TYPE("$valueSPLType", "$valueSPLTypeVector[$storeindex]"), $attribute->getAssignmentSourceLocation());
								next;
							}
						} else {
							$valueTypeVector[$storeindex] = $valueCppType;
							$valueSPLTypeVector[$storeindex] = $valueSPLType;
						}
						$containerTypeVector[$storeindex] = "com::ibm::streams::teda::internal::shm::MapObjectImplT<$keyTypeVector[$storeindex], $valueTypeVector[$storeindex]>";
					}
					
				} else {
					SPL::CodeGen::errorln(TedaToolkitResource::TEDA_INVALID_STORE_NAME($store, "storeSegmentPairs"), $param->getSourceLocation());
					next;
				}
				#check value
				if ($outputAssignementIsAssignFunctionVector[$i] && $outputAssignementParamValueVector[$i]->hasStreamAttributes()) {
					my $val = $outputAssignementParamValueVector[$i]->getSPLExpression();
					SPL::CodeGen::warnln(TedaToolkitResource::TEDA_VALUE_PARAMETER_EXISTS("$val"), $outputAssignementParamValueVector[$i]->getSourceLocation());
				}
				
			} elsif ($of eq "AsIs") {
				print "\t//\$of=$of\n";
				my $param = $attribute->getAssignmentOutputFunctionParameterValueAt(0);
				$outputAssignementParamKeyVector[$i] = $param;
			}
		}
	}
	# check if the associated find function is there for all has functions and set the outputAssignementAssociatedFindFunctionIndex to the 
	# index of that find function
	for (my $i = 0; $i < $numberOfOutputAttributes; $i++) {
		my $storeIndex = $outputAssignementStoreIndexVector[$i];
		#functions with a valid store index an not Find functions are has functions
		if (($storeIndex != -1) && (! $outputAssignementIsFindFunctionVector[$i])) { #it is a Has function
			print "\t//assoc chec for attribute: $outputAssignementAttributeNameVector[$i]\n";
			my $of = $outputAssignementFunctionNameVector[$i];
			my $storeName = $storeVector[$storeIndex];
			my $keySPLExp = $outputAssignementParamKeyVector[$i]->getSPLExpression();
			my $filterSPLExp = '';
			if (defined $outputAssignementParamFilterVector[$i]) {$filterSPLExp = $outputAssignementParamFilterVector[$i]->getSPLExpression();};
			my $associatedFindFunctionIndex = -1;
			for (my $j = 0; $j < $numberOfOutputAttributes; $j++) {
				if ($outputAssignementIsFindFunctionVector[$j] && ! $outputAssignementIsAssignFunctionVector[$i]) { #is a find function but not a find with assignment
					if ($storeIndex == $outputAssignementStoreIndexVector[$j]) { #compare store
						my $keySPLExpFindFunction = $outputAssignementParamKeyVector[$j]->getSPLExpression();
						print "\t//key: $keySPLExp $keySPLExpFindFunction\n";
						if ($keySPLExp eq $keySPLExpFindFunction) { #compare key
							my $filterSPLExpFindFunction ='';
							if (defined $outputAssignementParamFilterVector[$j]) { $filterSPLExpFindFunction = $outputAssignementParamFilterVector[$j]->getSPLExpression();};
							print "\t//filter: $filterSPLExp $filterSPLExpFindFunction\n";
							if ($filterSPLExp eq $filterSPLExpFindFunction) {
								$associatedFindFunctionIndex = $j;
								$outputAssignementHasAttributeNameVector[$j] = $outputAssignementAttributeNameVector[$i];
								last;
							}
						}
					}
				}
			}
			if ($associatedFindFunctionIndex != -1) {
				$outputAssignementAssociatedFindFunctionIndex[$i] = $associatedFindFunctionIndex;
				print "\t//has index: $i associated find index: $associatedFindFunctionIndex\n";
			} else {
				SPL::CodeGen::errorln(TedaToolkitResource::TEDA_INVALID_STORE_FUNCTION_ASSOCIATION($of, $storeName), $outputPort->getAttributeAt($i)->getAssignmentSourceLocation());
			}
		}
	}

	print "\t//\@keyTypeVector       :@keyTypeVector\n";
	print "\t//\@valueTypeVector     :@valueTypeVector\n";
	print "\t//\@containerTypeVector :@containerTypeVector\n";
	print "\n";
	my $lines = "\t//No\tCOF\tisFind\tisAssign\tAttribute\tStoreIndex\tkeyType\tFilter\tValueType\tDefault\tHasAttr\tFindFunctionIndex\n";
	for (my $i=0; $i<$numberOfOutputAttributes; $i++) {
		my $COF = 'undef';
		if ($outputAssignementFunctionNameVector[$i]) { $COF = $outputAssignementFunctionNameVector[$i]; };
		my $isFind = $outputAssignementIsFindFunctionVector[$i];
		my $isAssign = $outputAssignementIsAssignFunctionVector[$i];
		my $Attribute = $outputAssignementAttributeNameVector[$i];
		my $StoreIndex = $outputAssignementStoreIndexVector[$i];
		my $keyType = 'undef';
		if (defined $outputAssignementParamKeyVector[$i]) { $keyType = $outputAssignementParamKeyVector[$i]->getSPLType(); };
		my $Filter = 'undef';
		if (defined $outputAssignementParamFilterVector[$i]) { $Filter = $outputAssignementParamFilterVector[$i]->getSPLType(); };
		my $ValueType = 'undef';
		if (defined $outputAssignementParamValueVector[$i]) { $ValueType = $outputAssignementParamValueVector[$i]->getSPLType(); };
		my $Default = 'undef';
		if (defined $outputAssignementParamDefaultVector[$i]) { $Default = $outputAssignementParamDefaultVector[$i]->getSPLType(); };
		my $HasAttr = 'undef';
		if (defined $outputAssignementHasAttributeNameVector[$i]) { $HasAttr = $outputAssignementHasAttributeNameVector[$i]; };
		my $FindFunctionIndex = $outputAssignementAssociatedFindFunctionIndex[$i];
		my $l = "\t//$i\t$COF\t\t$isFind\t$isAssign\t$Attribute\t$StoreIndex\t$keyType\t$Filter\t$ValueType\t$Default\t$HasAttr\t$FindFunctionIndex\n";
		$lines .= $l
	}
	print $lines;
	print "\t//\$numberOfFindFunctions                       :$numberOfFindFunctions\n";
	if ($numberOfFindFunctions > 0) {
		print "\t//\@threadToOutpuAssignementIndex               :@threadToOutpuAssignementIndex\n";
	}
}

our @EXPORT_OK = qw(
		&intro
		$inputPort $inTupleName $inTupleType
		$outputPort $outTupleType
		$releaseMode $useThreads $segmentNamePrefix $disableLookup
		$numberOfStores $numberOfSegments
		%uniqueStores @storeVector @storeSegmentIndexVector
		%uniqueSegments @segmentVector @segmentUseCountVector
		@keyTypeVector @valueTypeVector @containerTypeVector
		$numberOfOutputAttributes
		@outputAssignementFunctionNameVector @outputAssignementIsFindFunctionVector @outputAssignementIsAssignFunctionVector @outputAssignementAttributeNameVector @outputAssignementStoreIndexVector
		@outputAssignementParamKeyVector @outputAssignementParamDefaultVector our @outputAssignementParamFilterVector @outputAssignementParamValueVector
		@outputAssignementHasAttributeNameVector @outputAssignementAssociatedFindFunctionIndex
		$numberOfFindFunctions @threadToOutpuAssignementIndex
	);

1;

