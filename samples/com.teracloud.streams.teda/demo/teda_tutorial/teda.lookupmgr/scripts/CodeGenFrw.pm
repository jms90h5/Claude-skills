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
package CodeGenFrw;

use strict;
use Getopt::Long;
use Cwd qw(abs_path fast_abs_path);
use File::Basename ;
use File::Path;
use File::Spec::Functions qw(canonpath rel2abs catfile catdir splitdir) ;
use File::Copy;
use XML::Simple;
use warnings ;
use Data::Dumper;
use FindBin;
use lib "$FindBin::Bin";
unshift @INC, (reverse(glob(sprintf("%s/toolkits/com.teracloud.streams.teda*/impl/nl/include", $ENV{STREAMS_INSTALL}))))[0];
require TedaToolkitResource;
$| = 1;

###################################################################################################
# Telco Framework Streams code gen functions
###################################################################################################

my %frwConsts =  (
	APPL_CTRL_FILE => "appl.ctl",
	LM_JOBNAME_FILE => ".lmjobname",
	COMMIT_DIR => "committed",
	HASH_FILE_EXTENSION => ".chk",
	CUSTOM_CONTEXT_FILE_EXTENSION => ".bin",
	CONFIG_DUMP_LOG_LEVEL => "Log.warn",
	CONFIG_DUMP_LOG_ASPECT => "CONFIG_DUMP",
	STATISTIC_SEQUENCE_NUMBER => "chainSequenceNumber",
	PARTITION_EXLOCATION_LABEL => "DEFAULT_PE_SEPARATION",
);

my %sizeFactors=(Byte => 1, kB => 1024, MB => 1048576, GB => 1073741824);

my $LmDummyXsdSchema = "1.0";
my $LmXsdSchemaVersion = "2.0";
my $LmFileXsdSchema = undef;
my $xsdPath = "$FindBin::Bin/../etc/LookupMgrCustomizing.xsd";
my $schemaDefinitionTargetFile = 'LookupMgrTypes.spl';
my $schemaDefinitionTemplateFile = abs_path(catfile("$FindBin::Bin/../etc","templates","LookupMgrTypes.templ"));

#####  GET PROJECT COMMON CONSTANTS ########### 
sub getConstant($) {
	my ($keyname) = @_;
	die TedaToolkitResource::TEDA_UNKNOWN_CONSTANT($keyname) ."\n" unless (exists $frwConsts{$keyname});
	return $frwConsts{$keyname};
}	

#####  Logic to get Dedup Parameters from a tuple schema ###########
sub getDedupAttributes($$$;$)
{
	my ($schemaFile, $schemaName, $attrListRef, $optCol) = (@_);
	my $f;
	my $colCounter = 0;
	my @LineArray;
	open(DATA, $schemaFile);
	while (<DATA>) {
		chomp;      # strip record separator
		if ($f) {
			$colCounter++;
		}
		if(/>;/) { $f=0;}
		if (/$schemaName/) {
			s/.*$schemaName//g;
			$f=1;
		}
		if ($f && /#DEDUP/) {
			push(@LineArray, $_."\n");
			
			if (defined $$optCol) {
				$$optCol .= ",";
			}
			$$optCol .= "$colCounter";
		}
	}
	foreach (@LineArray)
	{
		my @dataLine = split(' ',$_);
		my $attrname = $dataLine[1];
		$attrname =~ s/^\s+//; #remove leading spaces
		$attrname =~ s/\s+$//; #remove trailing spaces
		$attrname =~ s/\,//; #remove comma(,) at the end
		push @$attrListRef, $attrname;
	}
	@LineArray = ();
}

#####  Logic to get column index of repository attributes ###########	

# This function provides DB table names by access-specification
# getDbTablesNameByAccessSpec($inputTableList, $dbTableList, $xmlFile, $prefix, $quoted):
# - inputTableList - Reference of array collecting 'access_specification' names, 
# - dbTableList - Reference to the output array; list of DB tables, 
# - xmlFile - file path to connections.xml (default: ./connections.xml), 
# - prefix - defines the prefix of 'access_specification' name (e.g. lookup_), 
# - quoted - flag for output format; if 1 then quoted ("table.name") else unquoted (table.name)
sub getDbTablesNameByAccessSpec($$$;$$)
{
	my ($inputTableList, $dbTableList, $xmlFile, $prefix, $quoted) = (@_);
	my $inPrefix = "";
	my $regExContentEnd = '</access_specification>';
	my $regExAccessName = 'access_specification.*name.*=.*"';
	my $regExStatement = 'statement.*=';
	my $ret = "";

	$inPrefix = "$prefix" if ($prefix);
	
	die TedaToolkitResource::TEDA_FILE_DOES_NOT_EXIST($xmlFile) . "\n" if (! -e $xmlFile);

	foreach my $inTable (@$inputTableList) {
		open(DATA, $xmlFile) or die TedaToolkitResource::TEDA_FILE_CANNOT_OPEN_REASON($xmlFile, $!);
		seek (DATA,0,0); 
		while (<DATA>) {
			chomp;      # strip record separator
			if (/$regExAccessName$inPrefix$inTable"/ .. /$regExContentEnd/) {
				if (/$regExStatement/){
					my @statementLine = split(/"/,$_);
					$statementLine[1] =~ s/.*from //i;
					$statementLine[1] =~ s/\s.*//i;
					$statementLine[1] = "\"$statementLine[1]\"" if ($quoted);
					push(@$dbTableList,$statementLine[1]) if ("@$dbTableList" !~ /$statementLine[1]/);
				}
			}
		}
		close DATA;
	}
	$ret =~ s/,$//;
	return $ret;
}

#####  Reads configured chains per group in groups.cfg file ###########	
sub getChainMapping($$$)
{
	my ($chainCfgFile,$chainsIdsRef,$level1IdBloomNRef) = @_;
	my $defaultPort = -1;
	my $leve1Index = 0;
	my $leve1Id = 0;
	open (CHAINFILE, "$chainCfgFile") or die TedaToolkitResource::TEDA_FILE_CANNOT_OPEN_REASON($chainCfgFile, $!) ."\n";
	while( my $line = <CHAINFILE>)  
	{   
		chomp ($line);
		next if ("$line" =~ /#/);
		my @lcontent = split (/,/ , "$line");
		if (scalar @lcontent == 3) {
			if (! $lcontent[1]) 
			{
				$lcontent[1] = "1";
			}
			$leve1Id = l0($leve1Index);
			$chainsIdsRef->{$leve1Id}=$lcontent[1];
			$level1IdBloomNRef->{$leve1Id}=$lcontent[2];
			$leve1Index++;
		}
	}
	close (CHAINFILE);
}

sub getChainSplit($$)
{
	my ($chainCfgFile,$chainsIdsRef) = @_;
	my $defaultPort = -1;
	my $leve1Index = 0;
	my $leve1Id = 0;
	open (CHAINFILE, "$chainCfgFile") or die TedaToolkitResource::TEDA_FILE_CANNOT_OPEN_REASON($chainCfgFile, $!)."\n";
	while( my $line = <CHAINFILE>)  
	{   
		chomp ($line);
		next if ("$line" =~ /#/);
		my @lcontent = split (/,/ , "$line");
		if (scalar @lcontent == 3) {
			if ("$lcontent[0]" =~ /default/)
			{
				$defaultPort=$leve1Index;
			}
			$chainsIdsRef->{$lcontent[0]}=$leve1Index;
			$leve1Index++;
		}
	}
	close (CHAINFILE);
	return $defaultPort;
}

#####  Counts configured groups in groups.cfg file ###########	
sub getNumGroups($)
{
	my ($chainCfgFile) = @_;
	my $numGroups = 0;
	my %chains;
	my %level1IdBloomN;
	getChainMapping($chainCfgFile, \%chains, \%level1IdBloomN);
	foreach my $chId (keys %chains) {
		++$numGroups;
	}
	return $numGroups;
}

#####  Leading zero for 2 digit string
sub l0($) {
	my $string = shift;
	while (length($string)<2) {
		$string = "0${string}";
	}
	return $string;
}

#####  Remove leading zero for 2 digit string
sub triml0($) {
	my $string = shift;
	if (length($string)==2) {
		$string = substr($string, 1, 1);
	}
	return $string;
}

# this function restores a comma which was removed from the config->get and changed into a space
sub restoreComma($) {
	my $myvar = shift;
	my @parray = split (/ /,$myvar);
	my $pstr=join(",",@parray);
	return $pstr;
}

# --------------------------------------------------------------------------
# Build a code snippet for the config clause if active options are
# available. The function gets a hash map of configuration options (e.g.
# placement) as keys, each referring to an array of configuration statements
# (e.g. partitionColocation, partitionExlocation).
#
# The function evaluates for each key whether statements are available.
# Undefined (undef) entries are ignored. If there is at least one key with
# statements, the config clause is built. A configuration item is generated
# if at least one statement is available.
#
# @param options
# A hash map. The key is the name of the configuration option like
# 'placement'. The value is an array of statements fitting to the option.
# For example:
# placement => [ 'partitionColocation("A")', undef, 'partitionExlocation("B")' ] 
# --------------------------------------------------------------------------
sub buildConfigClauseCodeSnippet($)
{
	my ($options) = @_;
	my $codeSnippet;
	# There might be many configuration options.
	foreach my $option (keys %{$options})
	{
		# Ignore undef values in the placements array.
		my @statements = grep { defined $_ } @{$options->{$option}};
		if (scalar @statements > 0)
		{
			if (!defined $codeSnippet)
			{
				$codeSnippet = "\t\t\tconfig\n";
			}
			else
			{
				$codeSnippet = "\n";
			}
			$codeSnippet .= "\t\t\t\t${option}:\n\t\t\t\t\t" . join(",\n\t\t\t\t\t", @statements) . "\n\t\t\t\t;";
		}
	}
	return (defined $codeSnippet ? $codeSnippet : "");
}

####################################################
###                                              ###
###         Lookup Manager Customizing           ###
###                                              ###
####################################################
my $environmentValues = sub ($){
	my ($text) = @_;
	my @newText = ($$text=~m/%([^%]*)%/g); 
	foreach my $par (@newText) {
		if ($ENV{$par}){ 
			if ("" ne "$ENV{$par}") {
				$$text =~s/%$par%/$ENV{$par}/g;
			}
		}
	}
};
my $getReferenceValues = sub {
	my ($refs,$elemName) = @_;
	my @retList;
	my $tmpRef = $refs->{$elemName};
	if (( ref($tmpRef) ) eq 'ARRAY') {
		foreach my $elemVal (@$tmpRef) {
			&$environmentValues(\$elemVal);
			push (@retList,$elemVal);
		}
	}
	else {
		&$environmentValues(\$tmpRef);
		push (@retList,$tmpRef);
	}

	return (@retList);
};

my $setValueToResultArray = sub  {
	my ($tmpValueList, $valueList)	= @_;

	foreach my $tmpVal (@$tmpValueList) {
		### look for value in result array
		my $found = undef;
		foreach my $resVal (@$valueList) {
			$found = 1 if ( $resVal eq $tmpVal );
		}
		push( @$valueList, $tmpVal ) unless ($found);
	}
};
my $reference2Array = sub {
	my ($refs) = @_;
	my @retArray = undef;
	if (ref($refs) eq 'ARRAY'){
		@retArray = @$refs;
	}
	elsif(ref($refs) eq 'HASH') {
		@retArray = keys (%$refs);
	}
	return @retArray;
};

my $initXMLReaderByKeyInList = sub ($$$) {
	my ($filename, $keyAttr, $elemList) = @_;
	my $ref = undef;
	if (-e  $filename) {
		my $keyAttrs = {};
		foreach my $elem (@$elemList) {$keyAttrs->{$elem}="+$keyAttr";}
		my $xms = XML::Simple->new (ForceArray => @$elemList, KeepRoot => 1, KeyAttr => $keyAttrs);
		eval {
			$ref = $xms->XMLin($filename); 
		};
	}
	if (@{$ref->{LookupManager}}[0]->{SchemaVersion}) {
		$LmFileXsdSchema=@{$ref->{LookupManager}}[0]->{SchemaVersion};
	}
	else {
		$LmFileXsdSchema = $LmDummyXsdSchema;
	}
	return $ref;
};
my $initXMLReader = sub ($) {
	my ($filename) = @_;
	my $ref = undef;
	if (-e  $filename) {
		my $xms = XML::Simple->new (ForceArray => 1, KeepRoot => 1);
		eval {
			$ref = $xms->XMLin($filename); 
		};
	}
	if (@{$ref->{LookupManager}}[0]->{SchemaVersion}) {
		$LmFileXsdSchema=@{$ref->{LookupManager}}[0]->{SchemaVersion};
	}
	else {
		# check Version 1.0 structure
		if (@{$ref->{LookupManager}}[0]->{Application}) {
			$LmFileXsdSchema = $LmDummyXsdSchema;
		}
		else {
			die TedaToolkitResource::TEDA_XML_CANNOT_PARSE($filename) . "\n";
		}
	}
	return $ref;
};

sub getElementValuesByName 
{
	my ($parrentRefs, $elemName) = @_;

	my @valueList;
	### create references array
	my @source = &$reference2Array($parrentRefs);
	if (@source) {
		### check all references if reference
		foreach my $tmpRefs (@source) {
			next unless ($tmpRefs);
			unless ( ref($tmpRefs) ) {
				### none reference -> value
				next if ( $tmpRefs ne $elemName );
				### next steps because of matching the element name with requested
				my @tmpValueList = &$getReferenceValues ($parrentRefs, $elemName);
				&$setValueToResultArray (\@tmpValueList, \@valueList);
			}
			else {
				my @tmpValueList = getElementValuesByName($tmpRefs,$elemName);
				&$setValueToResultArray (\@tmpValueList, \@valueList);
			}
		}
		
		return @valueList;
	}
	return undef;
};
my $getElementValuesByXpath = sub {
	my ($refs,$xmlPath) = @_;

	my @elemRefs;
	push( @elemRefs, $refs );
	foreach my $xmlElem (split( /\//, $xmlPath )) {
		@elemRefs = getElementValuesByName( \@elemRefs, $xmlElem );
	}

	return (@elemRefs);
};

### This function provides the xml elements defined by path from the file
### IN:		filename - xml file
### IN:		xmlPath - '/' separated path defined by elements to the element
### IN:		dump - prints dumper output if set - OPTIONAL
### OUT:	returns array of values if found else empty
my $getElementsByXmlPath = sub ($$;$) {
	my ($filename,$xmlPath,$dump) = @_;
	my @elementValues = ();
	my $xml = &$initXMLReader($filename);
	print Dumper($xml) if ($dump);
	if ($xml) {
		@elementValues = &$getElementValuesByXpath ($xml, $xmlPath);
	}
	else {
		print STDERR TedaToolkitResource::TEDA_XML_CANNOT_PARSE($filename) . "\n";
	}
	print Dumper(\@elementValues) if ($dump);
	return @elementValues;
};

### This function provides the xml elements defined by xpath to component and attribute name
### IN:		filename - xml file
### IN:		xmlPath - '/' separated path defined by elements to the element
### IN:		key attribute e.g. {element=>"name"}
### IN:		dump - prints dumper output if set - OPTIONAL
### IN:		xml - xpath root reference - OPTIONAL
### OUT:	returns array of values if found else empty
my $getElementsByXmlPathByKeyAttribute = sub ($$$;$$) {
	my ($filename,$xmlPath,$attrName,$dump,$xml) = @_;
	my @elementValues = ();
	my @elemList = ();
	push (@elemList, basename($xmlPath));
	$xml = &$initXMLReaderByKeyInList($filename,$attrName,\@elemList) unless ($xml);
	if ($xml) {
		@elementValues = &$getElementValuesByXpath ($xml, $xmlPath);
	}
	else {
		print STDERR TedaToolkitResource::TEDA_XML_CANNOT_PARSE($filename) . "\n";
	}
	return @elementValues;
};

### This function provides the xml elements defined by xpath to component and attribute name
### IN:		filename - xml file
### IN:		xmlPath - '/' separated path defined by elements to the element
### IN:		key attribute e.g. "name"
### IN:		attribute value e.g. "key-attribute" or possible other attribute of the same element by "key-attribute/other-attribute-name"
### IN:		dump - prints dumper output if set - OPTIONAL
### IN:		xml - xpath root reference - OPTIONAL
### OUT:	returns array of values if found else empty
my $getElementByAttributeValue = sub ($$$$;$$) {
	my ($filename,$xmlPath,$attrName,$attrValue,$dump,$xml) = @_;
	my @elementValues=&$getElementsByXmlPathByKeyAttribute($filename,$xmlPath,$attrName);
	@elementValues = &$getElementValuesByXpath (\@elementValues, $attrValue);
	return @elementValues;
};

sub getMemSegments ($) {
	my ($customFile) = @_;
	my @ret;
	my $XPath = "LookupManager/Segments/Segment";
	my $SegNameAttribute = "Name";
	my @res = &$getElementsByXmlPath($customFile,$XPath);
	foreach my $customSegment (@res) {
		push(@ret,$customSegment->{$SegNameAttribute});
	}
	return @ret;
}

sub getSegmentStreamName ($$) {
	my ($customFile,$segmentName) = @_;
	my $XPath = "LookupManager/Segments/Segment";
	my $SegNameAttribute = "DataSource";
	my @res = &$getElementByAttributeValue( $customFile,$XPath,$SegNameAttribute,$segmentName);
	foreach my $customSegment (@res) {
		next unless ($customSegment->{$SegNameAttribute} eq $segmentName);
		return $customSegment->{Name};
	}
	return undef;
}

my $calculateSize = sub ($$) {
	my ($value, $unit) = @_;
	foreach my $sizeUnit (keys %sizeFactors) {
		next if ("$unit" ne $sizeUnit);
		return $value*$sizeFactors{$sizeUnit};
	}
	return 0;
};

sub getMemSegmentSize ($$) {
	my ($customFile,$segmentName) = @_;
	my $XPath = "LookupManager/Segments/Segment";
	my $SegNameAttribute = "DataSource";
	my @res = &$getElementByAttributeValue( $customFile,$XPath,$SegNameAttribute,$segmentName);
	foreach my $customSegment (@res) {
		next unless ($customSegment->{$SegNameAttribute} eq $segmentName);
		return &$calculateSize($customSegment->{Size},$customSegment->{Unit});
	}
	return undef;
}

sub getStores ($$) {
	my ($customFile,$segmentName) = @_;
	my @ret;
	undef @ret;
	my $XPath = "LookupManager/Segments/Segment";
	my $SegNameAttribute = "DataSource";
	my @res = &$getElementByAttributeValue( $customFile,$XPath, $SegNameAttribute,$segmentName);
	
	foreach my $customSegment (@res) {
		next unless ($customSegment->{$SegNameAttribute} eq $segmentName);
		my $found = undef;
		foreach my $store (@{$customSegment->{Stores}[0]->{Store}}) {
			foreach my $checkStore (@ret) {
				if ($checkStore eq $store->{Name}) {
					$found = 1;
				}
			}
			push(@ret,$store->{Name}) unless ($found);
		}
	}
	return @ret;
}

sub getAllStores ($) {
	my ($customFile) = @_;
	my @ret;
	undef @ret;
	my $XPath = "LookupManager/Segments/Segment";
	my $SegNameAttribute = "DataSource";
	my @res = &$getElementsByXmlPath($customFile,$XPath);
	foreach my $customSegment (@res) {
		my $found = undef;
		foreach my $checkStore (@ret) {
			if ($checkStore eq $customSegment->{Stores}[0]->{Store}->{Name}) {
				$found = 1;
			}
		}
		push(@ret,$customSegment->{Stores}[0]->{Store}->{Name}) unless ($found);
	}
	return @ret;
}

sub getStoreKeyType ($$$) {
	my ($customFile,$segmentName,$storeName) = @_;
	my $ret=undef;
	my $XPath = "LookupManager/Segments/Segment";
	my $SegNameAttribute = "DataSource";
	my @res = &$getElementByAttributeValue( $customFile,$XPath, $SegNameAttribute,$segmentName);
	foreach my $customSegment (@res) {
		next unless ($customSegment->{$SegNameAttribute} eq $segmentName);
		foreach my $store (@{$customSegment->{Stores}[0]->{Store}}) {
			next unless ($store->{Name} eq $storeName);
			$ret=$store->{KeyAssignment}[0]->{SPLType};
		}
	}
	return $ret;
}

sub getStoreKeyExpression ($$$) {
	my ($customFile,$segmentName,$storeName) = @_;
	my $ret=undef;
	my $XPath = "LookupManager/Segments/Segment";
	my $SegNameAttribute = "DataSource";
	my @res = &$getElementByAttributeValue( $customFile,$XPath, $SegNameAttribute,$segmentName);
	foreach my $customSegment (@res) {
		next unless ($customSegment->{$SegNameAttribute} eq $segmentName);
		foreach my $store (@{$customSegment->{Stores}[0]->{Store}}) {
			next unless ($store->{Name} eq $storeName);
			$ret=$store->{KeyAssignment}[0]->{SPLExpression};
		}
	}
	return $ret;
}

sub getStoreValueAssignmentsNames ($$$) {
	my ($customFile,$segmentName,$storeName) = @_;
	my @ret;
	undef @ret;
	my $XPath = "LookupManager/Segments/Segment";
	my $SegNameAttribute = "DataSource";
	my @res = &$getElementByAttributeValue( $customFile,$XPath,$SegNameAttribute,$segmentName);
	foreach my $customSegment (@res) {
		next unless ($customSegment->{$SegNameAttribute} eq $segmentName);
		foreach my $store (@{$customSegment->{Stores}[0]->{Store}}) {
			next unless ($store->{Name} eq $storeName);
			
			foreach my $storeValue (@{$store->{ValueAssignment}}) {
				my $found = undef;
				foreach my $checkStoreValue (@ret) {
					if ($checkStoreValue eq $storeValue->{Name}) {
						$found = 1;
					}
				}
				push(@ret,$storeValue->{Name}) unless ($found);
			}
		}
	}
	return @ret;
}

sub getStoreValueAssignmentsType ($$$$) {
	my ($customFile,$segmentName,$storeName,$attrName) = @_;
	my $ret = undef;
	my $XPath = "LookupManager/Segments/Segment";
	my $SegNameAttribute = "DataSource";
	my @res = &$getElementByAttributeValue( $customFile,$XPath,$SegNameAttribute,$segmentName);
	foreach my $customSegment (@res) {
		next unless ($customSegment->{$SegNameAttribute} eq $segmentName);
		foreach my $store (@{$customSegment->{Stores}[0]->{Store}}) {
			next unless ($store->{Name} eq $storeName);
			foreach my $storeValue (@{$store->{ValueAssignment}}) {
				next unless ($storeValue->{Name} eq $attrName);
				$ret = $storeValue->{SPLType};
			}
		}
	}
	return $ret;
}

sub getStoreValueAssignmentsExpression ($$$$) {
	my ($customFile,$segmentName,$storeName,$attrName) = @_;
	my $ret = undef;
	my $XPath = "LookupManager/Segments/Segment";
	my $SegNameAttribute = "DataSource";
	my @res = &$getElementByAttributeValue( $customFile,$XPath,$SegNameAttribute,$segmentName);
	foreach my $customSegment (@res) {
		next unless ($customSegment->{$SegNameAttribute} eq $segmentName);
		foreach my $store (@{$customSegment->{Stores}[0]->{Store}}) {
			next unless ($store->{Name} eq $storeName);
			foreach my $storeValue (@{$store->{ValueAssignment}}) {
				next unless ($storeValue->{Name} eq $attrName);
				$ret = $storeValue->{SPLExpression};
			}
		}
	}
	return $ret;
}
my $writeFile = sub ($$){
	my ($filename,$content) = @_;
	open( CMDFILE, '>',$filename ) or die TedaToolkitResource::TEDA_FILE_CANNOT_OPEN_REASON($filename, $!) ."\n";
	print CMDFILE "$content";
	close CMDFILE;
};

sub verifyStoreName ($$$) {
	my ($definedStores, $storeName, $segmentName) = @_;
	my $found = undef;
	if (exists $definedStores->{$storeName}) {
		foreach my $definedStore (keys %$definedStores) {
			next if ($storeName ne $definedStore);
			foreach my $defSegName (@{$definedStores->{$storeName}}) {
				$found = 1 if ($defSegName eq $segmentName);
			}
		}
		return (undef) if ($found); # next store of segment
	}
	push (@{$definedStores->{$storeName}}, $segmentName);
	
	return $storeName;
}

sub createCSVMappingFiles ($$$) {
	my ($xmlFile, $mappingPath, $segmentList) = @_;
	my @processedFiles;
	my $outContent = "";
	
	my $csvParserMappingFileHead=<<'EOT';
<?xml version="1.0" encoding="UTF-8"?>

<mappings xmlns="http://www.ibm.com/software/data/infosphere/streams/csvparser">
	<mapping name="<SEGMENT>">
EOT
	my $csvParserMappingFileFooter=<<'EOT';
	</mapping>
</mappings>
EOT
	my $csvParserMappingFileLine='		<assign index="<CSV_INDEX>" attribute="<CSV_ATTRIBUTE>" />' . "\n";
	
	foreach my $segment (@$segmentList) {
		### Mapping file name
		my $outputFile = $mappingPath . "/" . $segment . "_mapping.xml";
		if (-f $outputFile) {
			foreach my $checkFile (@processedFiles) {
				if ("$outputFile" eq $checkFile) {
					print STDERR TedaToolkitResource::TEDA_MAPPING_CREATED($segment . "_mapping.xml") . "\n";
					next;
				}
			}
		}
		
		### Prepare header
		$csvParserMappingFileHead =~s/<SEGMENT>/$segment/g;
		$outContent = $csvParserMappingFileHead;
		
		### Process lines
		my $XPath = "LookupManager/DataSources/DataSource";
		my $SegNameAttribute = "Name";
		foreach my $schemaMapping (&$getElementByAttributeValue( $xmlFile,$XPath, $SegNameAttribute,"$segment/ValueDefinition")) {
			my $tmpLine = $csvParserMappingFileLine;
			$tmpLine =~s/<CSV_INDEX>/$schemaMapping->{IndexInInputFile}/g;
			$tmpLine =~s/<CSV_ATTRIBUTE>/$schemaMapping->{Name}/g;
			$outContent .= $tmpLine if ("$outContent" !~ /$tmpLine/);
		}
		
		### Set footer
		$outContent .= $csvParserMappingFileFooter;
		
		### Write to file
		&$writeFile($outputFile,$outContent)
	}
}

my $getLmXsdVersionFromXml = sub ($) {
	my ($filename) = @_;
	&$initXMLReader($filename);
	return $LmFileXsdSchema;
};

my $getLinesBetween = sub($$$$) {
	my ($firstLine,$lastLine,$textRef,$resRef) = @_;
	foreach (@$textRef) {
		if (/$firstLine/ .. /$lastLine/) {
			push(@$resRef,"$_");
		}
	}
};
my $readFileToArray = sub ($$) {
	my ($file,$retRef) = @_;

	die TedaToolkitResource::TEDA_FILE_DOES_NOT_EXIST($file) . "\n" if (! -e $file);
	open(DATA, $file) or die TedaToolkitResource::TEDA_FILE_CANNOT_OPEN_REASON($file, $!) ."\n";
	seek (DATA,0,0); 
	@$retRef=<DATA>;
	close DATA;
};

my $getAllContentApplications = sub ($$){
	my ($fileContent, $applications) = @_;

	my @xmlBlock = ();

	# get applications by application namespace
	&$getLinesBetween( "Namespace=", ">", \@$fileContent, \@xmlBlock );
	foreach my $applLine (@xmlBlock) {
		chomp($applLine);
		my $applName = $applLine;
		$applName =~ s/.*Namespace\s*=\s*"//;
		$applName =~ s/".*//;
		# check if it is already included
		my $copyFlag = undef;
		foreach my $includedAppl (@$applications) {
			if ($includedAppl eq $applName) {
				$copyFlag = 1;
				last;
			}
		}
		# push to list
		push( @$applications, $applName ) unless ($copyFlag);
	}
};
my $getAllMemSegmtFromContent = sub ($){
	my ($content) = @_;

	my @xmlBlock = ();
	my @memSegmnts = ();

	# get applications by application namespace
	&$getLinesBetween( "Name=", ">", \@$content, \@xmlBlock );
	foreach my $memLine (@xmlBlock) {
		chomp($memLine);
		my $memSegName = $memLine;
		$memSegName =~ s/.*Name\s*=\s*"//;
		$memSegName =~ s/".*//;
		push( @memSegmnts, $memSegName );
	}
	return @memSegmnts;
};
sub getSchemaVersion ($) {
	my ($filename) = @_;
	my $schemaVersion = &$getLmXsdVersionFromXml($filename);
	return $schemaVersion;
}

sub validateXmlFile ($){
	my ($xml) = @_;
	
	my @args = ("xmllint --noout --schema $xsdPath $xml");
	system(@args);
	return $?;
}
sub getShmSegmentApplications ($$){
	my ($xmlFile, $applications) = @_;
	foreach my $shmSegmnt (getMemSegments($xmlFile)) {
		my @applList = ();
		$applications->{$shmSegmnt} = \@applList;
		foreach my $customSegment (&$getElementByAttributeValue($xmlFile, "LookupManager/Segments/Segment", "Name", "$shmSegmnt/"."Applications/Application")) {
			my $applName = $customSegment->{Namespace};
			# check if it is already included
			my $copyFlag = undef;
			foreach my $includedAppl (@applList) {
				if ($includedAppl eq $applName) {
					$copyFlag = 1;
					last;
				}
			}
			# push to list
			push( @applList, $applName ) unless ($copyFlag);
		}
	}
}

sub getAllApplications ($$){
	my ($xmlFile, $applications) = @_;

	my %segmentAppls = ();
	
	# get applications by application namespace
	getShmSegmentApplications($xmlFile,\%segmentAppls);
	foreach my $shmSegment (keys %segmentAppls) {
		foreach my $segAppl (@{$segmentAppls{"$shmSegment"}}){
			# check if it is already included
			my $copyFlag = undef;
			foreach my $includedAppl (@$applications) {
				if ($includedAppl eq $segAppl) {
					$copyFlag = 1;
					last;
				}
			}
			# push to list
			push( @$applications, $segAppl ) unless ($copyFlag);
		}
	}
}

sub getStreamsSchemaList ($) {
	my ($xmlFile) = @_;
	my @resList = ();
	
	my $XPath = "LookupManager/DataSources/DataSource";
	my $SchemaNameAttribute = "Name";
	
	my @res = &$getElementsByXmlPath($xmlFile,$XPath);
	foreach my $streamsSchema (@res) {
		push(@resList,$streamsSchema->{"$SchemaNameAttribute"});
	}
	return @resList;
}
sub getSegmentStreamList ($) {
	my ($xmlFile) = @_;
	my @resList = ();
	
	my $XPath = "LookupManager/Segments/Segment";
	my $SchemaNameAttribute = "DataSource";
	
	my @res = &$getElementsByXmlPath($xmlFile,$XPath);
	foreach my $streamsSchema (@res) {
		push(@resList,$streamsSchema->{"$SchemaNameAttribute"});
	}
	return @resList;
}
sub isDeleteStream ($$) {
	my ($xmlFile,$streamName) = @_;
	my %dbDeleteStreams;
	getDeleteStreamName($xmlFile,\%dbDeleteStreams);
	foreach my $streamsSchemaName (keys %dbDeleteStreams) {
		return $streamsSchemaName if ($streamName eq $dbDeleteStreams{$streamsSchemaName});
	}
	return undef;
}
my $createSegmentStream = sub ($$$$) {
	my ($dbMappingInStream, $streamsSchema, $streamsSchemaName, $streamType) = @_;
	
	my $SplAttributeName = "Name";
	###----------------------------------------###
	### Temapltes for Schema Mapping definition
	###----------------------------------------###
	my $schemaDefinitionHead=<<'EOT';
/**
This customer specific tuple defines the results of lookup data for <DB><STREAM_NAME> <END_DESCR>.
* **lookup_cmd:** Mandatory command name information.
EOT
	my $schemaDefinitionDescriptionLine='* **<ATTR>:** <ATTR_DESCR>';
	my $schemaDefinitionMid=<<'EOT';
*/
		static Schema<DB><STREAM_NAME> = tuple<
			rstring lookup_cmd, // mandatory for command handling
EOT
	my $schemaDefinitionLine='			<ATTR_TYPE> <ATTR>,';
	my $schemaDefinitionFooter=<<'EOT';
		>;
EOT
###----------------------------------------###
### Schema templates - END
###----------------------------------------###


	### create segemnt Definition
	my $attrCnt      = @{ $streamsSchema->{ValueDefinition} };
	my $descrContent = "";
	my $tupleContent = "";
	my $content = "";
	
	my $segHead = $schemaDefinitionHead;
	$segHead =~ s/<STREAM_NAME>/$streamsSchemaName/g;
	if ($streamType eq "DB") {
		$segHead =~ s/<END_DESCR>/as DB query result/g;
		$segHead =~ s/<DB>/Db/g;
	}
	else {	
		$segHead =~ s/<END_DESCR>/segment/g;
		$segHead =~ s/<DB>//g;
	}	
	foreach my $segemntSchemaValue ( @{ $streamsSchema->{ValueDefinition} } ) {
		$attrCnt--;
		my $AttributeName = $segemntSchemaValue->{$SplAttributeName};
		if ($streamType ne "SEGMENT" && $dbMappingInStream) {
			$AttributeName = $dbMappingInStream->{$segemntSchemaValue->{$SplAttributeName}}
		}
		my $schemaAttrDescLine = $schemaDefinitionDescriptionLine . "\n";
		$schemaAttrDescLine =~ s/<ATTR_DESCR>/$segemntSchemaValue->{Description}/g;
		$schemaAttrDescLine =~ s/<ATTR>/$AttributeName/g;
		$descrContent .= $schemaAttrDescLine;
		my $schemaAttrLine = $schemaDefinitionLine . "\n";
		$schemaAttrLine =~ s/<ATTR_TYPE>/$segemntSchemaValue->{SPLType}/g;
		$schemaAttrLine =~ s/<ATTR>/$AttributeName/g;
		$schemaAttrLine =~ s/,// if ( 0 == $attrCnt );
		$tupleContent .= $schemaAttrLine;
	}
	my $midPart = $schemaDefinitionMid;
	$midPart =~ s/<STREAM_NAME>/$streamsSchemaName/;
	if ($streamType eq "DB") {
		$midPart =~ s/<DB>/Db/g;
	}
	else {	
		$midPart =~ s/<DB>//;
	}	
	
	$content .= $segHead;
	$content .= $descrContent;
	$content .= $midPart;
	$content .= $tupleContent;
	$content .= $schemaDefinitionFooter;

	return $content;
};

my $getSchemaContent = sub ($) {
	my ($xmlFile) = @_;
	my $content = "";
	
	### get possible mappings
	my %dbSchemaMapping;
	getDbSchemaMapping($xmlFile,\%dbSchemaMapping);
	
	### create 
	my $XPath = "LookupManager/DataSources/DataSource";
	my $SchemaNameAttribute = "Name";
	my @res = &$getElementsByXmlPath($xmlFile,$XPath);
	foreach my $streamsSchema (@res) {
		my $streamsSchemaName = $streamsSchema->{"$SchemaNameAttribute"};
		my $dbMappingInStream = $dbSchemaMapping{$streamsSchemaName};
		my $deleteStreamFlag = isDeleteStream($xmlFile,$streamsSchemaName);
		# 
		if ($dbMappingInStream && !$deleteStreamFlag) { # DB mapping of repository stream
			$content .= &$createSegmentStream ($dbMappingInStream, $streamsSchema, $streamsSchemaName, "DB");
		}
		elsif ($deleteStreamFlag || $dbMappingInStream) { # delete stream
			$content .= &$createSegmentStream ($dbMappingInStream, $streamsSchema, $streamsSchemaName, "DELETE");
		}
		if (! $deleteStreamFlag) { # repository stream
			$content .= &$createSegmentStream ($dbMappingInStream, $streamsSchema, $streamsSchemaName, "SEGMENT");
		}
	}
	return $content;
};

sub createSchemaDefinitionFile ($) {
	my ($xmlFile) = @_;
	my $lookupMgrPath = dirname($xmlFile);
	#check is template present
	die TedaToolkitResource::TEDA_FILE_DOES_NOT_EXIST($schemaDefinitionTemplateFile) . "\n" unless (-f $schemaDefinitionTemplateFile);
	# read schema template
	my @schemaTemplate;
	&$readFileToArray($schemaDefinitionTemplateFile,\@schemaTemplate);
	
	# appand custom content
	my $schemaFile = "@schemaTemplate";
	my $schemaFileContent = &$getSchemaContent($xmlFile);
	$schemaFile =~s/<CUSTOM_STREAMS_SCHEMAS>/$schemaFileContent/;
	
	# define namespace
	my $schemaFilename = glob("$lookupMgrPath/*/lookuptypes/") . "$schemaDefinitionTargetFile";
	my @filesplit = split(/\//, $schemaFilename);
	my $namespace = $filesplit[@filesplit-3];
	$schemaFile =~s/<APPLICATION_NAMESPACE>/$namespace/g;
	
	# write to schema file
	&$writeFile($schemaFilename,$schemaFile);
}

sub getStreamOfAccessSpec($$) {
	my ($xmlFile,$accessSpecMap) = @_;
	
	my $XPath = "LookupManager/DataSources/DataSource";
	my $SchemaNameAttribute = "Name";
	my $dbAccessSpecAttribute = "DbAccessSpecification";
	
	my @res = &$getElementsByXmlPath($xmlFile,$XPath);
	foreach my $streamsSchema (@res) {
		if ($streamsSchema->{"$dbAccessSpecAttribute"}) {
			$accessSpecMap->{$streamsSchema->{$SchemaNameAttribute}}=$streamsSchema->{"$dbAccessSpecAttribute"};
		}
		else {
			$accessSpecMap->{$streamsSchema->{$SchemaNameAttribute}}=$streamsSchema->{"$SchemaNameAttribute"};
		}
		
	}
}
sub getDbSchemaMapping($$) {
	my ($xmlFile,$dbSchemaMap) = @_;
	
	my $XPath = "LookupManager/DataSources/DataSource";
	my $SchemaNameAttribute = "Name";
	my $AttributeName = "Name";
	my $dbAccessSpecAttribute = "DbColumnName";
	
#	my @res = &$getElementsByXmlPath($xmlFile,$XPath);
	foreach my $streamsSchema (&$getElementsByXmlPath($xmlFile,$XPath)) {
		my %dbColumnMap = ();
		# fill in the data - look for streams attributes
		foreach my $schemaMapping (&$getElementByAttributeValue( $xmlFile,$XPath, $SchemaNameAttribute,
			"$streamsSchema->{$SchemaNameAttribute}/ValueDefinition")) {
			# check if DB access attribute defined
			if ($schemaMapping->{$dbAccessSpecAttribute}) {
				$dbSchemaMap->{$streamsSchema->{$SchemaNameAttribute}} = \%dbColumnMap 
					unless($dbSchemaMap->{$streamsSchema->{$SchemaNameAttribute}});
				$dbColumnMap{$schemaMapping->{$AttributeName}} = $schemaMapping->{$dbAccessSpecAttribute};
			}
			else {
				# else fill in the name of itself
				$dbColumnMap{$schemaMapping->{$AttributeName}} = $schemaMapping->{$AttributeName};
			}
		}
	}
}
sub getDeleteStreamName ($$) {
	my ($xmlFile,$delStreamMap) = @_;
	my $XPath = "LookupManager/Segments/Segment";
	my $streamNameAttribute = "DataSource";
	my $deleteStreamAttribute = "DataSourceForValueRemoval";
	# access the segment elements
	my @res = &$getElementsByXmlPath($xmlFile,$XPath);
	foreach my $segmentElem (@res) {
		# check if deletion streams defined
		if ($segmentElem->{"$deleteStreamAttribute"}) {
			# set the deletion stream name
			$delStreamMap->{$segmentElem->{"$streamNameAttribute"}}=$segmentElem->{"$deleteStreamAttribute"};
		}
#		else {
#			# deletion streams is not defined, so set the segment stream as deletion stream
#			$delStreamMap->{$segmentElem->{"$streamNameAttribute"}}=$segmentElem->{"$streamNameAttribute"};
#		}
		
	}
	return undef;
}

1;
