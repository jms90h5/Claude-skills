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
package Configurator::Enum;

unshift @INC, (reverse(glob(sprintf("%s/toolkits/com.teracloud.streams.teda*/impl/nl/include", $ENV{STREAMS_INSTALL}))))[0];
require TedaToolkitResource;

sub _declEnum
{
	my ($key, $arguments) = @_;
	my $value = $arguments->{value};
	my $name = $arguments->{name};
	return ( lc($key) => { name => (defined $name ? $name : $key), value => (defined $value ? $value : $key), key => $key } );
}

package Configurator::Enum::Switch;

sub on() { return "on"; }
sub off() { return "off"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(on(), { value => 1 }),
		Configurator::Enum::_declEnum(off(), { value => 0 }),
	);
	return \%hash;
}

package Configurator::Enum::Database;

sub DB2 { return "DB2"; }
sub Oracle { return "ORACLE"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(DB2()),
		Configurator::Enum::_declEnum(Oracle(), { value => "ORACLE" }),
	);
	return \%hash;
}

package Configurator::Enum::TransformationOutputType;

sub tableStream { return "tableStream"; }
sub extendedTableStream { return "extendedTableStream"; }
sub recordStream { return "recordStream"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(tableStream(), { value => 0 }),
		Configurator::Enum::_declEnum(extendedTableStream(), { value => 1 }),
		Configurator::Enum::_declEnum(recordStream(), { value => 2 }),
	);
	return \%hash;
}

package Configurator::Enum::DayOfWeek;

sub Sunday { return "Sunday"; }
sub Monday { return "Monday"; }
sub Tuesday { return "Tuesday"; }
sub Wednesday { return "Wednesday"; }
sub Thursday { return "Thursday"; }
sub Friday { return "Friday"; }
sub Saturday { return "Saturday"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum("*"),
		Configurator::Enum::_declEnum(0, { name => Sunday() }),
		Configurator::Enum::_declEnum(1, { name => Monday() }),
		Configurator::Enum::_declEnum(2, { name => Tuesday() }),
		Configurator::Enum::_declEnum(3, { name => Wednesday() }),
		Configurator::Enum::_declEnum(4, { name => Thursday() }),
		Configurator::Enum::_declEnum(5, { name => Friday() }),
		Configurator::Enum::_declEnum(6, { name => Saturday() }),
		Configurator::Enum::_declEnum("Sun", { value => 0, name => Sunday() }),
		Configurator::Enum::_declEnum("Mon", { value => 1, name => Monday() }),
		Configurator::Enum::_declEnum("Tue", { value => 2, name => Tuesday() }),
		Configurator::Enum::_declEnum("Wed", { value => 3, name => Wednesday() }),
		Configurator::Enum::_declEnum("Thu", { value => 4, name => Thursday() }),
		Configurator::Enum::_declEnum("Fri", { value => 5, name => Friday() }),
		Configurator::Enum::_declEnum("Sat", { value => 6, name => Saturday() }),
		Configurator::Enum::_declEnum(Sunday(), { value => 0 }),
		Configurator::Enum::_declEnum(Monday(), { value => 1 }),
		Configurator::Enum::_declEnum(Tuesday(), { value => 2 }),
		Configurator::Enum::_declEnum(Wednesday(), { value => 3 }),
		Configurator::Enum::_declEnum(Thursday(), { value => 4 }),
		Configurator::Enum::_declEnum(Friday(), { value => 5 }),
		Configurator::Enum::_declEnum(Saturday(), { value => 6 }),
	);
	return \%hash;
}

package Configurator::Enum::DateTimeFormat;

sub YYYYMMDDhhmmss { return "YYYYMMDDhhmmss"; }
sub YYYYMMDD { return "YYYYMMDD"; }
sub MMDDYYYY { return "MMDDYYYY"; }
sub MMDDYYYYhhmmss { return "MMDDYYYYhhmmss"; }
sub DDMMYYYY { return "DDMMYYYY"; }
sub DDMMYYYYhhmmss { return "DDMMYYYYhhmmss"; }
sub YYYY_MM_DD { return "YYYY_MM_DD"; }
sub MM_DD_YYYY { return "MM_DD_YYYY"; }
sub DD_MM_YYYY { return "DD_MM_YYYY"; }
sub YYY_MM_DD_hh_mm_ss { return "YYY_MM_DD_hh_mm_ss"; }
sub MM_DD_YYYY_hh_mm_ss { return "MM_DD_YYYY_hh_mm_ss"; }
sub DD_MM_YYYY_hh_mm_ss { return "DD_MM_YYYY_hh_mm_ss"; }
sub YYYY_MM_DD_hh_mm_ss_mmm { return "YYYY_MM_DD_hh_mm_ss_mmm"; }
sub MM_DD_YYYY_hh_mm_ss_mmm { return "MM_DD_YYYY_hh_mm_ss_mmm"; }
sub DD_MM_YYYY_hh_mm_ss_mmm { return "DD_MM_YYYY_hh_mm_ss_mmm"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(YYYYMMDDhhmmss()),
		Configurator::Enum::_declEnum(YYYYMMDD()),
		Configurator::Enum::_declEnum(MMDDYYYY()),
		Configurator::Enum::_declEnum(MMDDYYYYhhmmss()),
		Configurator::Enum::_declEnum(DDMMYYYY()),
		Configurator::Enum::_declEnum(DDMMYYYYhhmmss()),
		Configurator::Enum::_declEnum(YYYY_MM_DD()),
		Configurator::Enum::_declEnum(MM_DD_YYYY()),
		Configurator::Enum::_declEnum(DD_MM_YYYY()),
		Configurator::Enum::_declEnum(YYY_MM_DD_hh_mm_ss()),
		Configurator::Enum::_declEnum(MM_DD_YYYY_hh_mm_ss()),
		Configurator::Enum::_declEnum(DD_MM_YYYY_hh_mm_ss()),
		Configurator::Enum::_declEnum(YYYY_MM_DD_hh_mm_ss_mmm()),
		Configurator::Enum::_declEnum(MM_DD_YYYY_hh_mm_ss_mmm()),
		Configurator::Enum::_declEnum(DD_MM_YYYY_hh_mm_ss_mmm()),
	);
	return \%hash;
}

package Configurator::Enum::SortAttr;

sub off { return "off"; }
sub filetime { return "time"; }   # TODO: Is it ok to mix time & filetime in that manner?
sub name { return "name"; }
sub size { return "size"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(off(), { value => 0 }),
		Configurator::Enum::_declEnum(filetime(), { value => 1 }),
		Configurator::Enum::_declEnum(name(), { value => 2 }),
		Configurator::Enum::_declEnum(size(), { value => 3 }),
	);
	return \%hash;
}

package Configurator::Enum::Sort;

sub off { return "off"; }
sub ascending { return "ascending"; }
sub descending { return "descending"; }
sub custom { return "custom"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(off(), { value => 0 }),
		Configurator::Enum::_declEnum("asc", { value => 1, name => ascending() }),
		Configurator::Enum::_declEnum(ascending(), { value => 1 }),
		Configurator::Enum::_declEnum("desc", { value => 2, name => descending() }),
		Configurator::Enum::_declEnum(descending(), { value => 2 }),
		Configurator::Enum::_declEnum(custom(), { value => 3 }),
	);
	return \%hash;
}

package Configurator::Enum::LoadDistribution;

sub roundRobin { return "roundRobin"; }
sub equalLoad { return "equalLoad"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(roundRobin(), { value => 0 }),
		Configurator::Enum::_declEnum(equalLoad(), { value => 1 }),
	);
	return \%hash;
}

package Configurator::Enum::FileCompression;

sub FileReaderCSV { return "FileReaderCSV"; }
sub FileReaderASN1 { return "FileReaderASN1"; }
sub FileReaderStructure { return "FileReaderStructure"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(FileReaderCSV()),
		Configurator::Enum::_declEnum(FileReaderASN1()),
		Configurator::Enum::_declEnum(FileReaderStructure()),
	);
	return \%hash;
}

package Configurator::Enum::FileEncoding;

sub FileReaderCSV { return "FileReaderCSV"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(FileReaderCSV()),
	);
	return \%hash;
}

package Configurator::Enum::OutputDirectoryStructure;

sub allInOne { return "allInOne"; }
sub perFile { return "perFile"; }
sub perDay { return "perDay"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(allInOne(), { value => 0 }),
		Configurator::Enum::_declEnum(perFile(), { value => 1 }),
		Configurator::Enum::_declEnum(perDay(), { value => 2 }),
	);
	return \%hash;
}

package Configurator::Enum::StorageType;

sub tableFile { return "tableFile"; }
sub recordFile { return "recordFile"; }
sub custom { return "custom"; }
sub noFile { return "noFile"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(tableFile(), { value => 0 }),
		Configurator::Enum::_declEnum(recordFile(), { value => 1 }),
		Configurator::Enum::_declEnum(custom(), { value => 2 }),
		Configurator::Enum::_declEnum(noFile(), { value => 3 }),
	);
	return \%hash;
}

package Configurator::Enum::ArchiveMode;

sub single { return "single"; }
sub multiple { return "multiple"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(single(), { value => 0 }),
		Configurator::Enum::_declEnum(multiple(), { value => 1 }),
	);
	return \%hash;
}

package Configurator::Enum::ExportInterface;

sub reader { return "reader"; }
sub transformer { return "transformer"; }
sub writer { return "writer"; }
sub dedup { return "dedup"; }
sub mapping()
{
	my %hash =
	(
		Configurator::Enum::_declEnum(reader()),
		Configurator::Enum::_declEnum(transformer()),
		Configurator::Enum::_declEnum(writer()),
		Configurator::Enum::_declEnum(dedup()),
	);
	return \%hash;
}

package Configurator::ParameterSet;

sub LookupManager() { return 0x01; }
sub ITE() { return 0x02; }

package Configurator;

use strict;
use warnings;
use Data::Dumper;
use Scalar::Util qw(looks_like_number reftype);
unshift @INC, sprintf("%s/bin", $ENV{STREAMS_INSTALL});
unshift @INC, (reverse(glob(sprintf("%s/toolkits/com.teracloud.streams.teda*/impl/nl/include", $ENV{STREAMS_INSTALL}))))[0];
require SPL::CodeGen;
require TedaToolkitResource;

my $debug = 0;
my $ST="$ENV{STREAMS_INSTALL}/bin/streamtool";

# -----------------------------------------------------------------------------
# Parameter Name Constants
# -----------------------------------------------------------------------------

sub GLOBAL_APPLICATIONCONTROLDIRECTORY() { return "global.applicationControlDirectory"; }
sub GLOBAL_MULTIHOST() { return "global.multiHost"; }
sub GLOBAL_MULTIHOST_CUSTOMHOSTTAGS() { return "global.multiHost.customHostTags"; }
sub GLOBAL_MULTIHOST_NUMBEROFHOSTS() { return "global.multiHost.numberOfHosts"; }

sub LM_APPLICATIONCONFIGURATION() { return "lm.applicationConfiguration"; }
sub LM_COMMANDSDIRECTORY() { return "lm.commandsDirectory"; }
sub LM_CONTROLLEDAPPLICATIONS() { return "lm.controlledApplications"; }
sub LM_DB_CONNECTIONNAME() { return "lm.db.connectionName"; }
sub LM_DB_NAME() { return "lm.db.name"; }
sub LM_DB_PASSWORD() { return "lm.db.password"; }
sub LM_DB() { return "lm.db"; }
sub LM_DB_USER() { return "lm.db.user"; }
sub LM_DB_VENDOR() { return "lm.db.vendor"; }
sub LM_FILE_DIRECTORY() { return "lm.file.directory"; }
sub LM_FILE() { return "lm.file"; }
sub LM_FILE_EOLMARKER() { return "lm.file.eolMarker"; }
sub LM_FILE_IGNOREEMPTYLINES() { return "lm.file.ignoreEmptyLines"; }
sub LM_FILE_IGNOREHEADERLINES() { return "lm.file.ignoreHeaderLines"; }
sub LM_FILE_QUOTED() { return "lm.file.quoted"; }
sub LM_FILE_SEPARATOR() { return "lm.file.separator"; }
sub LM_STATISTICSDIRECTORY() { return "lm.statisticsDirectory"; }

sub ITE_ARCHIVE_INPUTFILESINTODATEDIRECTORY() { return "ite.archive.inputFilesIntoDateDirectory"; }
sub ITE_BUSINESSLOGIC_GROUP() { return "ite.businessLogic.group"; }
sub ITE_BUSINESSLOGIC_GROUP_CUSTOM() { return "ite.businessLogic.group.custom"; }
sub ITE_BUSINESSLOGIC_GROUP_CUSTOM_TIMETOKEEP() { return "ite.businessLogic.group.custom.timeToKeep"; }
sub ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION() { return "ite.businessLogic.group.deduplication"; }
sub ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_TIMETOKEEP() { return "ite.businessLogic.group.deduplication.timeToKeep"; }
sub ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PARTITIONING() { return "ite.businessLogic.group.deduplication.partitioning"; }
sub ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PARTITIONING_COUNT() { return "ite.businessLogic.group.deduplication.partitioning.count"; }
sub ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PARTITIONING_SEARCHALLPARTITIONS() { return "ite.businessLogic.group.deduplication.partitioning.searchAllPartitions"; }
sub ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PROBABILITY() { return "ite.businessLogic.group.deduplication.probability"; }
sub ITE_BUSINESSLOGIC_GROUP_STARTUPCONTROLFILE() { return "ite.businessLogic.group.startupControlFile"; }
sub ITE_BUSINESSLOGIC_TRANSFORMATION_TUPLEGROUPSPLIT() { return "ite.businessLogic.transformation.tupleGroupSplit"; }
sub ITE_BUSINESSLOGIC_TRANSFORMATION_LOOKUP() { return "ite.businessLogic.transformation.lookup"; }
sub ITE_INGEST_READER_SCHEMAEXTENSIONFORLOOKUP() { return "ite.ingest.reader.schemaExtensionForLookup"; }
sub ITE_BUSINESSLOGIC_TRANSFORMATION_OUTPUTTYPE() { return "ite.businessLogic.transformation.outputType"; }
sub ITE_BUSINESSLOGIC_TRANSFORMATION_POSTPROCESSING_CUSTOM() { return "ite.businessLogic.transformation.postprocessing.custom"; }
sub ITE_RESILIENCEOPTIMIZATION() { return "ite.resilienceOptimization"; }
sub ITE_BUSINESSLOGIC_GROUP_CUSTOM_CHECKPOINTING() { return "ite.businessLogic.group.custom.checkpointing"; }
sub ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_CHECKPOINTING() { return "ite.businessLogic.group.deduplication.checkpointing"; }
sub ITE_CHECKPOINTING_DIRECTORY() { return "ite.checkpointing.directory"; }
sub ITE_CLEANUP_SCHEDULE_DAYOFMONTH() { return "ite.cleanup.schedule.dayOfMonth"; }
sub ITE_CLEANUP_SCHEDULE_DAYOFWEEK() { return "ite.cleanup.schedule.dayOfWeek"; }
sub ITE_CLEANUP_SCHEDULE_HOUR() { return "ite.cleanup.schedule.hour"; }
sub ITE_CLEANUP_SCHEDULE_MINUTE() { return "ite.cleanup.schedule.minute"; }
sub ITE_CONTROL_DEBUG() { return "ite.control.debug"; }
sub ITE_BUSINESSLOGIC_GROUP_DEBUG() { return "ite.businessLogic.group.debug"; }
sub ITE_INGEST_DEBUG() { return "ite.ingest.debug"; }
sub ITE_INGEST_READER_DEBUG() { return "ite.ingest.reader.debug"; }
sub ITE_BUSINESSLOGIC_TRANSFORMATION_DEBUG() { return "ite.businessLogic.transformation.debug"; }
sub ITE_BUSINESSLOGIC_SINK_DEBUG() { return "ite.businessLogic.sink.debug"; }
sub ITE_INGEST_CUSTOMFILETYPEVALIDATOR() { return "ite.ingest.customFileTypeValidator"; }
sub ITE_INGEST_CUSTOMFILECONTROL() { return "ite.ingest.customFileControl"; }
sub ITE_INGEST_ARCHIVEMODE() { return "ite.ingest.archiveMode"; }
sub ITE_INGEST_DEDUPLICATION() { return "ite.ingest.deduplication"; }
sub ITE_INGEST_DEDUPLICATION_TIMETOKEEP() { return "ite.ingest.deduplication.timeToKeep"; }
sub ITE_INGEST_DIRECTORYSCAN_PROCESSFILEPATTERN() { return "ite.ingest.directoryScan.processFilePattern"; }
sub ITE_INGEST_DEDUPLICATION_REPROCESSFILEPATTERN() { return "ite.ingest.deduplication.reprocessFilePattern"; }
sub ITE_INGEST_DIRECTORYSCAN_NANOSECONDSPRECISION() { return "ite.ingest.directoryScan.nanoSecondsPrecision"; }
sub ITE_INGEST_DIRECTORYSCAN_SLEEPTIME() { return "ite.ingest.directoryScan.sleepTime"; }
sub ITE_INGEST_DIRECTORYSCAN_SORT() { return "ite.ingest.directoryScan.sort"; }
sub ITE_INGEST_DIRECTORYSCAN_SORT_ATTRIBUTE() { return "ite.ingest.directoryScan.sort.attribute"; }
sub ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME() { return "ite.ingest.directoryScan.specialFileTime"; }
sub ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_FORMAT() { return "ite.ingest.directoryScan.specialFileTime.format"; }
sub ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_REGEXP() { return "ite.ingest.directoryScan.specialFileTime.regexp"; }
sub ITE_INGEST_FILEGROUPSPLIT() { return "ite.ingest.fileGroupSplit"; }
sub ITE_INGEST_FILEGROUPSPLIT_PATTERN() { return "ite.ingest.fileGroupSplit.pattern"; }
sub ITE_INGEST_DIRECTORY_INPUT() { return "ite.ingest.directory.input"; }
sub ITE_INGEST_DIRECTORY_INPUTLISTFILE() { return "ite.ingest.directory.inputListFile"; }
sub ITE_INGEST_LOADDISTRIBUTION() { return "ite.ingest.loadDistribution"; }
sub ITE_INGEST_LOADDISTRIBUTION_GROUPCONFIGFILE() { return "ite.ingest.loadDistribution.groupConfigFile"; }
sub ITE_INGEST_LOADDISTRIBUTION_NUMBEROFPARALLELCHAINS() { return "ite.ingest.loadDistribution.numberOfParallelChains"; }
sub ITE_INGEST_LOADDISTRIBUTION_UDP() { return "ite.ingest.loadDistribution.udp"; }
sub ITE_INGEST_READER_COMPRESSION() { return "ite.ingest.reader.compression"; }
sub ITE_INGEST_READER_CUSTOMFILESTATISTICS() { return "ite.ingest.reader.customFileStatistics"; }
sub ITE_INGEST_READER_CUSTOMPARSERSTATISTICS() { return "ite.ingest.reader.customParserStatistics"; }
sub ITE_INGEST_READER_ENCODING() { return "ite.ingest.reader.encoding"; }
sub ITE_INGEST_READER_PARSERLIST() { return "ite.ingest.reader.parserList"; }
sub ITE_INGEST_READER_PREPROCESSING() { return "ite.ingest.reader.preprocessing"; }
sub ITE_JOBNAME() { return "ite.jobName"; }
sub ITE_EMBEDDEDSAMPLECODE() { return "ite.embeddedSampleCode"; }
sub ITE_STORAGE_AUDITOUTPUTS() { return "ite.storage.auditOutputs"; }
sub ITE_STORAGE_DIRECTORY_OUTPUTS() { return "ite.storage.directory.outputs"; }
sub ITE_STORAGE_DIRECTORY_STATISTICS() { return "ite.storage.directory.statistics"; }
sub ITE_STORAGE_OUTPUTDIRECTORYSTRUCTURE() { return "ite.storage.outputDirectoryStructure"; }
sub ITE_STORAGE_REJECTWRITER_CUSTOM() { return "ite.storage.rejectWriter.custom"; }
sub ITE_STORAGE_TABLENAMES() { return "ite.storage.tableNames"; }
sub ITE_STORAGE_TYPE() { return "ite.storage.type"; }
sub ITE_BUSINESSLOGIC_GROUP_TAP() { return "ite.businessLogic.group.tap"; }
sub ITE_BUSINESSLOGIC_TRANSFORMATION_TAP() { return "ite.businessLogic.transformation.tap"; }
sub ITE_FUSE_CHAIN_OPERATORS() { return "ite.fuse.chain.operators"; }
sub ITE_FUSE_GROUP_OPERATORS() { return "ite.fuse.group.operators"; }
sub ITE_FUSE_GROUPWITHCHAIN_OPERATORS() { return "ite.fuse.groupWithChain.operators"; }
sub ITE_EXPORT_STREAMS() { return "ite.export.streams"; }

# -----------------------------------------------------------------------------
# The enumerations.
# -----------------------------------------------------------------------------

my %enumerations =
(
	"switch" => Configurator::Enum::Switch::mapping(),
	"database" => Configurator::Enum::Database::mapping(),
	"transformationOutputType" => Configurator::Enum::TransformationOutputType::mapping(),
	"dayOfWeek" => Configurator::Enum::DayOfWeek::mapping(),
	"dateTimeFormat" => Configurator::Enum::DateTimeFormat::mapping(),
	"sortAttr" => Configurator::Enum::SortAttr::mapping(),
	"sort" => Configurator::Enum::Sort::mapping(),
	"loadDistribution" => Configurator::Enum::LoadDistribution::mapping(),
	"fileCompression" => Configurator::Enum::FileCompression::mapping(),
	"fileEncoding" => Configurator::Enum::FileEncoding::mapping(),
	"outputDirectoryStructure" => Configurator::Enum::OutputDirectoryStructure::mapping(),
	"storageType" => Configurator::Enum::StorageType::mapping(),
	"archiveMode" => Configurator::Enum::ArchiveMode::mapping(),
	"exportInterface" => Configurator::Enum::ExportInterface::mapping(),
);

# -----------------------------------------------------------------------------
# General Constants
# -----------------------------------------------------------------------------

my ( $mandatory, $optional ) = ( 0x00, 0x01 );
my ( $single, $multiple ) = ( 0x00, 0x01 );
my ( $compileTime, $submissionTime ) = ( 0x01, 0x02 );
my ( $deprecated ) = ( 0x01 );

# -----------------------------------------------------------------------------
# Regular Expressions
# -----------------------------------------------------------------------------

my $id = "(?:[a-zA-Z]\\w*)";
my $regEx_path = ".+";
my $regEx_file = "[^\\/]+";
my $regEx_word = "\\w+";
my $regEx_anyNonEmptyString = ".+";
my $regEx_compositeName = "[A-Z][\\w_]*";
my $regEx_type = "(?:(?:[a-z][\\w_]*)(?:\\.[a-z][\\w_]*)*::)?(?:$id\\.)?$id";
my $regEx_parserList = "[^|]+\\|" . $regEx_compositeName;
my $regEx_table = '(?:[\\w$]+\.)?[\\w$]+';
my $regex_namespace = '(?:[a-z][a-z0-9_]*)(?:\\.[a-z][a-z0-9_]*)*';
my $regex_timeToKeep = '(\d+d)?\s*(\d+h)?\s*(\d+m)?';

# -----------------------------------------------------------------------------
# The Parameters.
# -----------------------------------------------------------------------------
# type (mandatory)
#    The value type. Allowed values are "string", "integer", "enum".
#    For enum, the key 'enum' has to exist.
#    For string, the key 'regex' optionally exists.
#    For integer, the keys 'min' and 'max' optionally exist.
# occurrence (mandatory)
#    Indicates whether a parameter is mandatory or optional.
# instances (mandatory)
#    Indicates whether a parameter can take a single or multiple values.
# default (optional)
#    The default value for optional parameters.
# children (optional)
#    The list of child parameters.
# empty (optional)
#    Specifies the value that shall be used if Configurator::Loader::get() returns an empty value

sub _disable($$)
{
	my ($self, $originator, $parameter) = @_;
	if (exists $parameter->{value} && $self->{warnings})
	{
		SPL::CodeGen::warnln(TedaToolkitResource::TEDA_WARNING_DISABLE_PARAMETER_HAVING_USER_PROVIDED_VALUE($parameter->{name}, ($parameter->{instances} == $multiple ? join(",", @{$parameter->{value}}): $parameter->{value}), $originator->{name}, ($originator->{value} or $originator->{default})));
	}
	$parameter->{disabled} = undef;
}

my %lookup;
my @parameters =
(
	# -------------------------------------------------------------------------
	# GLOBAL
	# -------------------------------------------------------------------------
	{
		name       => GLOBAL_APPLICATIONCONTROLDIRECTORY(),
		type       => "string",
		regex      => $regEx_path,
		occurrence => $mandatory,
		instances  => $single,
		empty      => undef,
		selector   => Configurator::ParameterSet::LookupManager() | Configurator::ParameterSet::ITE(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the path of the directory that is used by the applications to store
and exchange status information. The same path must be used for the
Lookup Manager application and its controlled ITE applications.

If the applications are running on multiple hosts, the directory must be
located in a shared file system.

A relative path is relative to the `data` directory.
STOP
	},
	{
		name       => GLOBAL_MULTIHOST(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		children   =>
		[
			GLOBAL_MULTIHOST_NUMBEROFHOSTS(),
			GLOBAL_MULTIHOST_CUSTOMHOSTTAGS(),
		],
		selector   => Configurator::ParameterSet::LookupManager() | Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether the application bundle shall run on a single or multiple
hosts. An application bundle can consist of a single ITE application or of
a single Lookup Manager application with multiple ITE applications.

If you want to run the application bundle on multiple hosts, turn the parameter
on. If you want to run the application bundle on a single host only, turn it
off.

If the parameter is turned off, the child parameters are inactive.
STOP
		details => <<STOP,
If the parameter is turned on, the application uses host tags to ensure, for
example, that the enrichment data is updated on every host. The required host
tags are stored in the `hosttags.txt` file, which is located in the application
`config` directory. The host tags must be created and assigned to hosts
using the `streamtool` command,
for example, `streamtool mktag` or `streamtool chhost`.
STOP
	},
	{
		name       => GLOBAL_MULTIHOST_CUSTOMHOSTTAGS(),
		type       => "string",
		regex      => $regEx_word,
		occurrence => $optional,
		instances  => $multiple,
		default    => [ ],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies host tags that you want to use in your customized code
to place operators on specific hosts.

The parameter is active only if the parent parameter is turned on.
STOP
		details => <<STOP,
The provided host tags are stored in the `hosttags.txt` file, which is located
in the application `config` directory. The host tags must be created and
assigned to hosts using the
`streamtool` command, for example, `streamtool mktag` or `streamtool chhost`.
STOP
	},
	{
		name       => GLOBAL_MULTIHOST_NUMBEROFHOSTS(),
		type       => "integer",
		min        => 1,
		occurrence => $optional,
		instances  => $single,
		default    => "1",
		empty      => undef,
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the number of hosts that will hold enrichment data. This number
must be identical to the number of hosts that are assigned the
<namespace>_lookup_host_writer host tag.

The parameter is active only if the parent parameter is turned on.
STOP
		details => <<STOP,
The application uses the UDP feature to create as many operator instances
as needed, initializing and updating the enrichment data on every host.
Each host has its own operator instance. In other words, a host exlocation
is used.

If the number of hosts that have the <namespace>_lookup_host_writer host tag
assigned is less than this parameter value, the job submission fails. If it
is greater, it is not predictable which hosts hold the enrichment data.
STOP
	},
	# -------------------------------------------------------------------------
	# LOOKUP MANAGER APPLICATION
	# -------------------------------------------------------------------------
	{
		name       => LM_APPLICATIONCONFIGURATION(),
		type       => "string",
		occurrence => $optional,
		instances  => $single,
		default    => "",
		empty      => undef,
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the application configuration instance name, that stores the 
DB name, DB user and the DB password data in the Streams instance 
or Streams domain. The user must create the instance with Streams Console.
STOP
	},
	{
		name       => LM_COMMANDSDIRECTORY(),
		type       => "string",
		regex      => $regEx_path,
		occurrence => $optional,
		instances  => $single,
		default    => "./in/cmd",
		empty      => undef,
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the directory that is scanned for command input files. Successfully
processed command input files are moved to the `archive` subdirectory. Input
files that could not be processed are moved to the `failed` subdirectory.
If these subdirectories do not exist, they are created during the startup
phase.

A relative path is relative to the `data` directory.
STOP
		details => <<STOP,
The directory does not need to be in a shared file system because the Lookup
Manager application always scans for new command input files on the host that
has the <namespace>_lookup_writer host tag assigned.
STOP
	},
	{
		name       => LM_CONTROLLEDAPPLICATIONS(),
		type       => "string",
		regex      => $regex_namespace,
		occurrence => $optional,
		instances  => $multiple,
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $submissionTime,
		description => <<STOP,
Restricts the list of ITE applications that are controlled by the Lookup
Manager application to a subset of the ITE applications that are defined in
the `LookupMgrCustomizing.xml` file. The file is located in the Lookup Manager
application directory.

Provide a comma-separated list of namespaces as defined in the
`LookupMgrCustomizing.xml` file.

If the submission-time parameter is omitted, the Lookup Manager application
controls all ITE applications that are defined in the `LookupMgrCustomizing.xml`
file.
STOP
	},
	{
		name       => LM_DB(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		children   =>
		[
			LM_DB_CONNECTIONNAME(),
			LM_DB_NAME(),
			LM_DB_PASSWORD(),
			LM_DB_USER(),
			LM_DB_VENDOR(),
		],
		related    =>
		[
			LM_FILE(),
		],
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether the Lookup Manager application reads enrichment data from
a database source. The read enrichment data is distributed to the lookup
repositories on all configured hosts.

If the Lookup Manager application reads enrichment data from a database
source, set this parameter to `on`. If not, set it to `off`.

If you set this parameter to `on`, the child parameters must be configured
according to their descriptions. If the parameter is turned off, the child
parameters are inactive, and the related **${\LM_FILE()}** parameters must be
turned on.

When you create a project, a `connections.xml` sample file is created in
the application directory.
STOP
		details => <<STOP,
The Lookup Manager uses the com.ibm.streams.db::ODBCRun operator from the
Database toolkit to read the enrichment data. All required Database toolkit
settings must be provided.
STOP
		postprocess=> sub
		{
			my ($self, $parameter) = @_;
			my $p = $parameter;
			my ($key, $value) = $self->_get($p->{name}, $p->{type}, $p->{instances}, "force");
			if (defined $key && $key eq Configurator::Enum::Switch::off())
			{
				# If the database is switched off, the file source has to be switched on.
				my @subfeatures =
				(
					LM_FILE(),
				);
				my $counter = 0;
				foreach my $name (@subfeatures)
				{
					my $dep = $lookup{lc($name)};
					my ($k, $v) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
					++$counter if (defined $k && $k eq Configurator::Enum::Switch::on());
				}
				$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES_OTHER_CONFIG_PARAMETERS($p->{name}, $key, join(",", @subfeatures))) if (0 == $counter);
			}
			else
			{
				# If the database is switched on, the following parameters are required.
				my @subfeatures =
				(
					LM_DB_CONNECTIONNAME(),
					LM_DB_VENDOR(),
				);
				my @missing;
				foreach my $name (@subfeatures)
				{
					my $dep = $lookup{lc($name)};
					my ($k, $v) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
					push @missing, $name unless (defined $k);
				}
				$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES_OTHER_CONFIG_PARAMETERS($p->{name}, $key, join(",", @missing))) unless (0 == scalar @missing);
			}
		}
	},
	{
		name       => LM_DB_CONNECTIONNAME(),
		type       => "string",
		regex      => $regEx_anyNonEmptyString,
		occurrence => $optional,
		instances  => $single,
		default    => "SAMPLE",
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime,
		description => <<STOP,
Specifies the connection name that will be used to access the database source.

Use one of the names that is specified in the `connections.xml` file of the
database toolkit. The [http://en.wikipedia.org/wiki/XPath|XPath] for these
names is `/connections/connection_specifications/connection_specification/\@name`.

The parameter is active only if the parent parameter is turned on.
STOP
		details => <<STOP,
The specified connection name is passed as `connection` parameter to the
com.ibm.streams.db::ODBCRun operator.
STOP
	},
	{
		name       => LM_DB_NAME(),
		type       => "string",
		regex      => $regEx_anyNonEmptyString,
		occurrence => $optional,
		instances  => $single,
		empty      => undef,
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the data source name (DSN) of the target database.

*Important*: If this parameter is provided as a compile time parameter, its value
is visible in the SPL files that are compiled from the mixed-mode SPLMM files.
To prevent security concerns, it is recommended that you provide all database access
information as submission-time parameters only.

This parameter is active only if the parent parameter is turned on.
STOP
		details => <<STOP,
This parameter is passed as a **database** parameter to the
com.ibm.streams.db::ODBCRun operator.

Any value that is specified on the <ODBC> element of the <connection_specification>
element in the `connection.xml` document is ignored.

For additional information, see the Database toolkit description.
STOP
	},
	{
		name       => LM_DB_PASSWORD(),
		type       => "string",
		regex      => $regEx_anyNonEmptyString,
		occurrence => $optional,
		instances  => $single,
		empty      => undef,
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the password that is used to connect to the target database.

*Important*: If this parameter is provided as compile-time parameter, its value
is visible in the SPL files that are compiled from the mixed-mode SPLMM files.
To prevent security concerns, it is recommended that you provide all database access
information as submission-time parameters only.

The parameter is active only if the parent parameter is turned on.
STOP
		details => <<STOP,
This parameter is passed as a **password** parameter to the
com.ibm.streams.db::ODBCRun operator.

Any value that is specified on the <ODBC> element of the <connection_specification>
element in the `connection.xml` document is ignored.

For additional information, see the Database toolkit description.
STOP
	},
	{
		name       => LM_DB_USER(),
		type       => "string",
		regex      => $regEx_anyNonEmptyString,
		occurrence => $optional,
		instances  => $single,
		empty      => undef,
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the user name that is used to connect to the target database.

*Important*: If this parameter is provided as a compile-time parameter, its value
is visible in the SPL files that are compiled from the mixed-mode SPLMM files.
To prevent security concerns, it is recommended that you provide all database access
information as submission-time parameters only.

The parameter is active only if the parent parameter is turned on.
STOP
		details => <<STOP,
This parameter is passed as a **user** parameter to the
com.ibm.streams.db::ODBCRun operator.

Any value that is specified on the <ODBC> element of the <connection_specification>
element in the `connection.xml` document is ignored.

For additional information, see the Database toolkit description.
STOP
	},
	{
		name       => LM_DB_VENDOR(),
		type       => "enum",
		enum       => "database",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Database::DB2(),
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime,
		description => <<STOP,
Specifies the database vendor (product). The Lookup Manager application
supports only a subset of the database products (DB2 and Oracle) that
are supported by the Database toolkit.

All required database toolkit settings and drivers for the selected product
must be provided. For example, set the `STREAMS_ADAPTERS_ODBC_DB2` environment
variable for DB2 or `STREAMS_ADAPTERS_ODBC_ORACLE` for Oracle. All other
environment variables that are required by the Database toolkit must also be set,
for example, `STREAMS_ADAPTERS_ODBC_INCPATH` and `STREAMS_ADAPTERS_ODBC_LIBPATH`.

The parameter is active only if the parent parameter is turned on.
STOP
		details => <<STOP,
For additional information, see the Database toolkit description.
STOP
	},
	{
		name       => LM_FILE(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		children   =>
		[
			LM_FILE_DIRECTORY(),
			LM_FILE_EOLMARKER(),
			LM_FILE_IGNOREEMPTYLINES(),
			LM_FILE_IGNOREHEADERLINES(),
			LM_FILE_QUOTED(),
			LM_FILE_SEPARATOR(),
		],
		related    =>
		[
			LM_DB(),
		],
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether the Lookup Manager application reads enrichment data from
files. The read enrichment data is distributed to the lookup repositories
on all configured hosts.

If the Lookup Manager application reads enrichment data from files,
set this parameter to `on`. If not, set it to `off`.

If this parameter is turned on, the child parameters can be configured
according to their descriptions. If the parameter is turned off, the child
parameters are inactive and the related ${\LM_DB()} parameters must be
turned on.
STOP
		postprocess=> sub
		{
			my ($self, $parameter) = @_;
			# If the file is switched off, the database source has to be switched on.
			my $p = $parameter;
			my ($key, $value) = $self->_get($p->{name}, $p->{type}, $p->{instances}, "force");
			if (defined $key && $key eq Configurator::Enum::Switch::off())
			{
				my @subfeatures =
				(
					LM_DB(),
				);
				my $counter = 0;
				foreach my $name (@subfeatures)
				{
					my $dep = $lookup{lc($name)};
					my ($k, $v) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
					++$counter if (defined $k && $k eq Configurator::Enum::Switch::on());
				}
				$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES_OTHER_CONFIG_PARAMETERS($p->{name}, $key, join(",", @subfeatures))) if (0 == $counter);
			}
		}
	},
	{
		name       => LM_FILE_DIRECTORY(),
		type       => "string",
		regex      => $regEx_path,
		occurrence => $optional,
		instances  => $single,
		default    => ".",
		empty      => undef,
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the directory that holds enrichment data input files.

A relative path is relative to the `data` directory.

Enrichment data input files have either the `.csv` or `.del.csv` extension.

The parameter is active only if the parent parameter is turned on.
STOP
		details => <<STOP,
The basename (the file name without the extension) is a segment name
that is provided as part of an **update** or **delete** command. The provided
segment name must match one of the segment names that are defined in the
`LookupMgrCustomizing.xml` file. The file is located in the Lookup Manager
application directory.
STOP
	},
	{
		name       => LM_FILE_EOLMARKER(),
		type       => "string",
		occurrence => $optional,
		instances  => $single,
		default    => "\\n",
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the end of line marker of the CSV lines when the Lookup Manager reads 
the enrichment data from files.
STOP
		details => <<STOP,
This parameter value defaults to "\\\\n". Valid 
values include strings with one or two characters, such as "\\\\r" and 
"\\\\r\\\\n". For more details, look at the `eolMarker` parameter in the 
`FileSource` reference.
STOP
	},
	{
		name       => LM_FILE_IGNOREEMPTYLINES(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime,
		description => <<STOP,
Specifies how to handle empty CSV lines when the Lookup Manager reads the 
enrichment data from files. If this parameter is turned on, empty
lines are dropped else empty lines produce tuples with default attribute values.
If this parameter is turned off then multiple empty lines cause warnings 
during the write process to lookup repositories.
STOP
	},
	{
		name       => LM_FILE_IGNOREHEADERLINES(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime,
		description => <<STOP,
Specifies how to handle header lines in the CSV input file that contains the 
enrichment data. A header line is the first line after punctuation. If this 
parameter is turned on, then the header is dropped else the header is handled 
like a normal line.
STOP
	},
	{
		name       => LM_FILE_QUOTED(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime,
		description => <<STOP,
Specifies the quoting mode for attribute values of the CSV input file that 
contains the enrichment data. If the parameter is turned on then some or all 
values are quoted else no one value is quoted. If you are sure that no input 
value is quoted, turn off the parameter to improve performance.
STOP
	},
	{
		name       => LM_FILE_SEPARATOR(),
		type       => "string",
		occurrence => $optional,
		instances  => $single,
		default    => ",",
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime,
		description => <<STOP,
Specifies the quoting mode for attribute values of the CSV input file that 
contains the enrichment data. If the parameter is turned on then some or all 
values are quoted else no one value is quoted. If you are sure that no input 
value is quoted, turn off the parameter to improve performance. The valid 
values is a string with single- or the multi-character.
STOP
	},
	{
		name       => LM_STATISTICSDIRECTORY(),
		type       => "string",
		regex      => $regEx_path,
		occurrence => $optional,
		instances  => $single,
		default    => "./out/statistics",
		empty      => undef,
		selector   => Configurator::ParameterSet::LookupManager(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the directory that is used to store log and statistics files.

The Lookup Manager application collects statistics for the lookup repository,
for example the amount of available memory, and generates log information,
for example the starting and ending times of processed commands. The Lookup Manager
application writes this information to a file, `<date>_LookupManagerStatistics.txt`
with a `YYYYMMDD` date format.

The specified directory holds only one statistics log file. If a new
file is created because the new day begins, the old file is moved to the
`archive` directory. The `archive` directory is created during the startup
phase.

A relative path is relative to the `data` directory.
STOP
		details => <<STOP,
The directory does not need to be in a shared file system because the
Lookup Manager application always runs on the host that has the
<namespace>_lookup_writer host tag assigned.
STOP
	},
	# -------------------------------------------------------------------------
	# INGEST TRANSFORM ENRICH APPLICATION
	# -------------------------------------------------------------------------
	{
		name       => ITE_ARCHIVE_INPUTFILESINTODATEDIRECTORY(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether the ITE application archives processed input files in a
per-day directory or in a directory that receives all files.

If the parameter is `off`, the `archive` directory receives all files. The
`archive` directory is relative to the data directory.

If the parameter is `on`, the ITE application creates a directory for every
day that receives the processed input files for that day. The directory path
is `archive/YYYYMMDD` with YYYY as year, MM as the month and DD as the day.
The `archive/YYYYMMDD` directory is relative to the `data` directory.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		children   =>
		[
			ITE_BUSINESSLOGIC_GROUP_CUSTOM(),
			ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION(),
			ITE_BUSINESSLOGIC_GROUP_STARTUPCONTROLFILE(),
			ITE_BUSINESSLOGIC_GROUP_DEBUG(),
			ITE_BUSINESSLOGIC_GROUP_TAP(),
			ITE_FUSE_GROUPWITHCHAIN_OPERATORS(),
			ITE_FUSE_GROUP_OPERATORS(),
		],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether tuples are grouped.

If the parameter is `off`, the ITE application does not group tuples.

If the parameter is `on`, the ITE application groups tuples, and at least
one of the built-in correlations must be enabled. This  means that either
the tuple deduplication, the custom correlation, or both must be enabled.

**CAUTION:** If the checkpointing for the group logic is enabled, the ITE
applications will regularly run internal maintenance tasks that pause the
file processing for few seconds till several minutes.
STOP
		postprocess => sub
		{
			my ($self, $parameter) = @_;
			# If the grouping is switched on, at least one correlation must be enabled.
			my $p = $parameter;
			my ($key, $value) = $self->_get($p->{name}, $p->{type}, $p->{instances}, "force");
			if (defined $value && $value == 1)
			{
				my @subfeatures =
				(
					ITE_BUSINESSLOGIC_GROUP_CUSTOM(),
					ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION()
				);
				my $counter = 0;
				foreach my $name (@subfeatures)
				{
					my $dep = $lookup{lc($name)};
					my ($k, $v) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
					++$counter if (defined $v && $v == 1);
				}
				$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES_OTHER_CONFIG_PARAMETERS($p->{name}, $key, join(",", @subfeatures))) if (0 == $counter);
			}
		}
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_CUSTOM(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		children   =>
		[
			ITE_BUSINESSLOGIC_GROUP_CUSTOM_CHECKPOINTING(),
		],
		related    =>
		[
			ITE_EMBEDDEDSAMPLECODE(),
		],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether the ITE application groups tuples by using the
custom correlation logic.

If you want to group tuples using your correlation logic, set
this and the parent parameter to `on` and implement your correlation
logic in the <namespace>.context.custom::ContextDataProcessor
composite operator. You must also set the **${\ITE_EMBEDDEDSAMPLECODE()}**
parameter to `off`, so the ITE application uses your implementation
instead of the sample logic that is provided with the
<namespace>.context.sample::ContextDataProcessor composite operator.

**CAUTION:** If the checkpointing for the group logic is enabled, the ITE
applications will regularly run internal maintenance tasks that pause the
file processing for few seconds till several minutes.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_CUSTOM_CHECKPOINTING(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		children   =>
		[
			ITE_BUSINESSLOGIC_GROUP_CUSTOM_TIMETOKEEP(),
		],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether checkpoint files for the custom logic of group processing
are stored. If this parameter is `off`, the state of the custom logic cannot
be recovered if the application is restarted. For example, if your custom
logic aggregates data across file boundaries, data that has been collected
is lost.

Committed checkpoint files are named `custom/<groupId>/committed/<input-filename>.bin`
and are located in the output directory that is specified in the
**${\ITE_CHECKPOINTING_DIRECTORY()}** parameter.

**CAUTION:** If the checkpointing for the group logic is enabled, the ITE
applications will regularly run internal maintenance tasks that pause the
file processing for few seconds till several minutes.
STOP
		details => <<STOP,
The **${\ITE_BUSINESSLOGIC_GROUP_CUSTOM_TIMETOKEEP()}** parameter is active only
if the parent and this parameters are set to `on`.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_CUSTOM_TIMETOKEEP(),
		type       => "string",
		regex      => $regex_timeToKeep,
		occurrence => $optional,
		instances  => $single,
		default    => "1d",
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies the time after which tuples are removed from the stateful
custom group.

This parameter is active only if the parent and the **${\ITE_BUSINESSLOGIC_GROUP_CUSTOM_CHECKPOINTING()}**
parameters are set to `on`.
STOP
		details => <<STOP,
If the **${\ITE_BUSINESSLOGIC_GROUP_CUSTOM_CHECKPOINTING()}** parameter is `on`, the
ITE application automatically saves all tuples that are received by the custom
correlation logic to the hard disk. If the application restarts, for example
because of maintenance or an automatic data refreshment and eviction cycle,
the ITE application removes old tuples from the saved tuple set and processes
only the valid tuples to rebuild an updated state of the custom correlation
logic.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_DEBUG(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Enables additional file outputs that troubleshoot your ITE application.
The files are located in the `debug` directory, which is a subdirectory
of the configured `data` directory.

When this parameter is `on`, you receive information about the commands
and data that are processed in the group logic.
STOP
		details => <<STOP,
The following files are created only if the **${\ITE_BUSINESSLOGIC_GROUP()}**
and **${\ITE_BUSINESSLOGIC_GROUP_DEBUG()}** parameters are turned on:

* `CONTEXT_CMD_<GROUP_ID>.txt`:
  Receives log entries for internal checkpoint commands (**clear**, **read**,
  **write**) that are received by the group logic.
* `CONTEXT_CMD_RESP_<GROUP_ID>.txt`:
  Receives log entries for `start` and `stop` responses that leave the group
  logic.
* `CONTEXT_DATA_IN_<GROUP_ID>.txt`:
  Receives log entries for data tuples that are received by the group logic.
* `CONTEXT_DATA_OUT_<GROUP_ID>.txt`:
  Receives log entries for valid data tuples that leave the group logic.
* `DEDUP_CMD_<GROUP_ID>.txt`:
  Receives log entries for refresh and shutdown signals that are received by
  the deduplication.
* `DEDUP_CMD_RESP_<GROUP_ID>.txt`:
  Receives log entries for refresh and shutdown responses that leave the
  deduplication.
* `DEDUP_IN_<GROUP_ID>.txt`:
  Receives log entries for data tuples that are received by the deduplication.
* `DEDUP_OUT_<GROUP_ID>.txt`:
  Receives log entries for data tuples that leave the deduplication and sets
  whether the tuple is unique or a duplicate.
* `BLOOM_OUT_<GROUP_ID>.txt`:
  Receives log entries for data tuples that leave the deduplication during the
  training phase that starts during the initialization phase or after
  receiving a refresh signal.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		children   =>
		[
			ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_CHECKPOINTING(),
			ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PROBABILITY(),
		],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether the ITE application groups tuples according to the
built-in deduplication logic.

To enable the tuple deduplication, set this and the parent parameter
to `on`.

**CAUTION:** If the checkpointing for the group logic is enabled, the ITE
applications will regularly run internal maintenance tasks that pause the
file processing for few seconds till several minutes.
STOP
		details => <<STOP,
The deduplication uses a memory-efficient algorithm that can lead
to false positives, which means that unique tuples are marked as duplicates.
For more information, see the child parameters or the
[com.teracloud.streams.teda.utility::BloomFilter|BloomFilter] operator.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_CHECKPOINTING(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		children   =>
		[
			ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_TIMETOKEEP(),
		],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether to store checkpoint files for the deduplication of the group
processing. If this parameter is `off`, the state of the deduplication
cannot be recovered if the  application is restarted. For example, unique
tuples are not restored in the deduplication logic anymore, so duplicate tuples
would be detected as unique tuples.

The committed checkpoint files are named `<groupId>/committed/<input-filename>.chk`
and are located in the output directory that is specified in the
**${\ITE_CHECKPOINTING_DIRECTORY()}** parameter.

**CAUTION:** If the checkpointing for the group logic is enabled, the ITE
applications will regularly run internal maintenance tasks that pause the
file processing for few seconds till several minutes.
STOP
		details => <<STOP,
The **${\ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_TIMETOKEEP()}** parameter is active
only if the parent and this parameter is set to `on`.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_TIMETOKEEP(),
		type       => "string",
		regex      => $regex_timeToKeep,
		occurrence => $optional,
		instances  => $single,
		default    => "1d",
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies the time after which tuples are removed from the stateful
deduplication.

The parameter is active only if the parent and the **${\ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_CHECKPOINTING()}**
parameters are set to `on`.
STOP
		details => <<STOP,
If the **${\ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_CHECKPOINTING()}** parameter
is `on`, the ITE application automatically saves all tuples that are received
by the deduplication logic to the hard disk. If the application restarts, for
example because of maintenance or an automatic data refreshment and eviction
cycle, the ITE application removes old tuples from the saved tuple set and
processes valid tuples to rebuild an updated state of the deduplication logic.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PARTITIONING(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		children   =>
		[
			ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PARTITIONING_COUNT(),
			ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PARTITIONING_SEARCHALLPARTITIONS(),
		],
		related    =>
		[
            ITE_INGEST_LOADDISTRIBUTION_GROUPCONFIGFILE(),
            ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_CHECKPOINTING,
            ITE_CHECKPOINTING_DIRECTORY,
		],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether the de-duplication uses partitioning to automatically evict
too old data.To use partitioning, turn this parameter on. If this parameter is
turned on, the **${\ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PROBABILITY()}** 
parameter and the number of expected unique items that are specified for each 
group in the group configuration file
(**${\ITE_INGEST_LOADDISTRIBUTION_GROUPCONFIGFILE()}** parameter) are valid per
each partition. For example, the user specifies in the group configuration file 
that he wants the de-duplication to cope with 1000 entries. Each partition is 
able to cope with 1000 entries. Partitioning requires a sortable value to 
determine the partition that has to be dropped if the maximum number of 
partitions that is specified with the
**${\ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PARTITIONING_COUNT()}** parameter,
is exceeded. This sortable value is defined in the new "partitionId" SPL 
attribute that has to be set latest in the 
<namespace>.chainprocessor.transfomer.custom::DataProcessor composite operator. 
The user must specify the type of the "partitionId" SPL attribute with the
customizable <namespace>.streams.custom.TypesCustom::PartitionIdType streams 
type definition. The name of the new "partitionId" attribute is fixed. 
The BloomFilter operator defines the "partitionBy" parameter that uses the value
of the "partitionId" SPL attribute, that the attribute must be one of the types
described in the BloomFilter operator. The recommended checkpointing is enabled 
by the **${\ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_CHECKPOINTING()}** parameter.
It requires the **${\ITE_CHECKPOINTING_DIRECTORY()}** parameter.STOP
		details => <<STOP,
For more details about the partitioning, see the
[com.teracloud.streams.teda.utility::BloomFilter|BloomFilter operator].
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PARTITIONING_COUNT(),
		type       => "integer",
		min        => 1,
		occurrence => $optional,
		instances  => $single,
		default    => "1",
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies the maximum number of partitions. As soon as the number of active
partitions exceeds this count, the partition with the minimum partitionId 
expression value is evicted.
STOP
		details => <<STOP,
For more details about the partitioning and the counter, see the 
[com.teracloud.streams.teda.utility::BloomFilter|BloomFilter operator].
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PARTITIONING_SEARCHALLPARTITIONS(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether the unique/duplicate detection algorithm evaluates all
partitions or only the partition that is selected, as defined and described in
the BloomFilter description. If the parameter is switched on, the algorithm 
evaluates all partitions. If the tuple is evaluated to be a unique in the 
partition that is selected with the "partitionId", the number of stored uniques
is increased for this partition even if the tuple is marked as duplicated 
because of another partition.
STOP
		details => <<STOP,
For more details about the partitioning and the search options, see the 
[com.teracloud.streams.teda.utility::BloomFilter|BloomFilter operator].
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_PROBABILITY(),
		type       => "float",
		min        => 0.0,
		max        => 0.1,
		occurrence => $optional,
		instances  => $single,
		default    => "0.001",
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_INGEST_LOADDISTRIBUTION_GROUPCONFIGFILE(),
		],
		description => <<STOP,
Specifies the probability of false positives that are allowed for
duplicate detection.

A *false positive* occurs when a tuple is marked as a duplicate even
though it is unique.

The expected number of unique tuples, for which this probability is
ensured, is specified in the file that is specified in the
**${\ITE_INGEST_LOADDISTRIBUTION_GROUPCONFIGFILE()}** parameter.
STOP
		details => <<STOP,
For more details about the probability and the number of expected unique
tuples, see the [com.teracloud.streams.teda.utility::BloomFilter|BloomFilter operator].
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_STARTUPCONTROLFILE(),
		type       => "string",
		regex      => $regEx_file,
		occurrence => $optional,
		instances  => $single,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			GLOBAL_APPLICATIONCONTROLDIRECTORY(),
		],
		description => <<STOP,
Specifies the name of the text file that delays the initialization
of the ITE application. As soon as the file exists and contains the `done`
value in the first row, the initialization begins.

You use this file to indicate completed external activities that are required
before the ITE application starts its initialization, for example, creating
files that are needed for the custom or deduplication initialization from
a database.

The specified file is expected in the control directory that is identified
by the **${\GLOBAL_APPLICATIONCONTROLDIRECTORY()}** parameter.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_GROUP_TAP(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_EMBEDDEDSAMPLECODE(),
			ITE_BUSINESSLOGIC_TRANSFORMATION_TAP(),
		],
		description => <<STOP,
Turns the post-group data processor tap on or off.

If this tap is turned on, another stream that contains the tuples that passed
the business logic, including the group logic (for example, deduplication),
is activated. You may use these tuples to implement features that do not alter
the data stored in the files by the main business logic. For example, the tap
logic filters for tuples and sends an event to another application or another
system if the filter condition is met. The spl.adapter::Export operator or any
sink operator like the spl.adapter::TCPSink operator may be used with the tap
data tuples.

Implement your tap logic in the <namespace>.tap.custom::PostContextDataProcessorTap
composite operator. You must also set the **${\ITE_EMBEDDEDSAMPLECODE()}**
parameter to `off`, so the ITE application uses your implementation instead
of the sample logic that is provided with the <namespace>.tap.sample::PostContextDataProcessorTap
composite operator.
STOP
		details => <<STOP,
The ITE application supports two taps.
* The first tap is turned on with the **${\ITE_BUSINESSLOGIC_TRANSFORMATION_TAP()}**
  parameter and normally used only if the **${\ITE_BUSINESSLOGIC_GROUP()}**
  parameter is turned `off`.
* The second tap is turned on with the **${\ITE_BUSINESSLOGIC_GROUP_TAP()}**
  parameter and normally used only if the **${\ITE_BUSINESSLOGIC_GROUP()}**
  parameter is turned `on`.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_SINK_DEBUG(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether to enable additional file outputs that are used to
troubleshoot your ITE application. The files are located in the `debug`
directory, which is a subdirectory of the configured *data* directory.

When this parameter is set to `on`, you receive information about the
storage stage.
STOP
		details => <<STOP,
The following files are created:

* `CHAIN_TRANSFORMER_IN_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives log entries for data tuples that are received by the
  <namespace>.chainprocessor.transformer::ChainprocessorTransformerCore
  composite operator.
* `CHAIN_TRANSFORMER_OUT_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives log entries for data tuples that are sent by the
  <namespace>.chainprocessor.transformer::ChainprocessorTransformerCore
  composite operator.
* `CHAIN_TRANSFORMER_STAT_IN_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives log entries for statistics tuples that are received by the
  <namespace>.chainprocessor.transformer::ChainprocessorTransformerCore
  composite operator at the end of each file.
* `CHAIN_TRANSFORMER_STAT_OUT_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives log entries for enriched statistics tuples that are sent by the
  <namespace>.chainprocessor.transformer::ChainprocessorTransformerCore
  composite operator at the end of each file.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_TRANSFORMATION_DEBUG(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies whether to enable additional file outputs that are used to
troubleshoot your ITE application. The files are located in the `debug`
directory, which is a subdirectory of the configured *data* directory.

When this parameter is set to `on`, you receive information about the
transformation stage.
STOP
		details => <<STOP,
Following files are created:

* `SINK_FILE_WRITER_STAT_IN_<GROUP_ID>_<CHAIN_ID>.txt`:
  statistic tuple sent by FileReader at end of file
* `SINK_FILE_WRITER_IN_<GROUP_ID>_<CHAIN_ID>.txt`:
  data tuples to write to file at RecordFileWriter or TableFileWriter
* `CHAIN_POSTCONTEXT_IN_<GROUP_ID>_<CHAIN_ID>.txt`:
  data tuples received from context
* `CHAIN_POSTCONTEXT_OUT_<GROUP_ID>_<CHAIN_ID>.txt`:
  data tuples sent to FileWriter Sink
* `CHAIN_POSTCONTEXT_STAT_IN_<GROUP_ID>_<CHAIN_ID>.txt`:
  statistic tuple sent by FileReader at end of file
* `CHAIN_POSTCONTEXT_STAT_OUT_<GROUP_ID>_<CHAIN_ID>.txt`:
  statistic tuple sent by FileReader at end of file
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_TRANSFORMATION_LOOKUP(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime | $submissionTime,
		related    =>
		[
			ITE_INGEST_READER_SCHEMAEXTENSIONFORLOOKUP(),
		],
		description => <<STOP,
Specifies whether the ITE application performs data enrichment
using the lookup functionality.

If you want to use the lookup functionality, set the parameter to `on`.
If not, set the parameter to `off`. In this case, the ITE application
runs independently of the Lookup Manager application.
STOP
		details => <<STOP,
The **${\ITE_INGEST_READER_SCHEMAEXTENSIONFORLOOKUP()}** parameter is
related because all attributes that are introduced in lookup are added
already to the stream definition for the parser output when
**${\ITE_INGEST_READER_SCHEMAEXTENSIONFORLOOKUP()}** is switched on.
This setting creates a streams schema that is used throughout the
application (beginning to end).

The Lookup Manager application controls the initialization and
updates of the enrichment data. During the initialization and the
updates, the ITE application is paused.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_TRANSFORMATION_OUTPUTTYPE(),
		type       => "enum",
		enum       => "transformationOutputType",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::TransformationOutputType::recordStream(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_STORAGE_TYPE(),
		],
		description => <<STOP,
Specifies the output schema of the <namespace>.chainprocessor.transformer::ChainprocessorTransformerCore
composite that is handled by the <namespace>.streams::TypesCommon.TransformerOutType
while considering the value of the **${\ITE_STORAGE_TYPE()}** parameter. The
streams are defined in "TypesCommon" and "TypesCustom" and used in the "DataProcessor" composites.

If tuple deduplication is enabled, the hash code must be part of the defined tuple.

Valid values of this parameter are:

* `tableStream`:
  This output stream becomes the input of the TableRowGenerator. One tuple
  contains a single table row and one hash code for deduplication. If an
  input record results in multiple table rows or input to different tables,
  several tuples must be sent by the Transformer.
* `extendedTableStream`:
  Extends the table schema, for example, if lookup data is evaluated in custom
  PostDedupProcessor or in CustomContext. This is all that the 'tableStream'
  selection is extended with the <namespace>.streams::TypesCustom.ExtendedTableStream
  or <namespace>.streams.custom::TypesCustom.ExtendedTableStream streams.
* `recordStream`:
  Enables the RecordStreamType that contains the TransformedRecord tuple. It
  is used when **${\ITE_STORAGE_TYPE()}** is set to 'recordFile' or 'custom'. The
  PostContextDataProcessor composte creates the row tuples.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_TRANSFORMATION_POSTPROCESSING_CUSTOM(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_EMBEDDEDSAMPLECODE(),
		],
		description => <<STOP,
Enables the custom logic that runs after the group processing but before
the storage stage.

If you want to implement this custom logic, set this parameter
to `on` and adapt the <namespace>.chainsink.custom::PostContextDataProcessor
composite. You must also set the **${\ITE_EMBEDDEDSAMPLECODE()}**
parameter to `off`, so the ITE application uses your implementation instead
of the sample logic that is provided with the <namespace>.chainsink.sample::PostContextDataProcessor
composite operator.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_TRANSFORMATION_TAP(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_EMBEDDEDSAMPLECODE(),
			ITE_BUSINESSLOGIC_GROUP_TAP(),
		],
		description => <<STOP,
Turns the post-transformation data processor tap on or off.

If this tap is turned on, another stream that contains the tuples that passed
the business logic, excluding the group logic (for example, deduplication),
is activated. You may use these tuples to implement features that do not alter
the data stored in the files by the main business logic. For example, the tap
logic filters for tuples and sends an event to another application or another
system if the filter condition is met. The spl.adapter::Export operator or any
sink operator like the spl.adapter::TCPSink operator may be used with the tap
data tuples.

Implement your tap logic in the <namespace>.tap.custom::TransformerTap
composite operator. You must also set the **${\ITE_EMBEDDEDSAMPLECODE()}**
parameter to `off`, so the ITE application uses your implementation instead
of the sample logic that is provided with the <namespace>.tap.sample::TransformerTap
composite operator.
STOP
		details => <<STOP,
The ITE application supports two taps.
* The first tap is turned on with the **${\ITE_BUSINESSLOGIC_TRANSFORMATION_TAP()}**
  parameter and normally used only if the **${\ITE_BUSINESSLOGIC_GROUP()}**
  parameter is turned `off`.
* The second tap is turned on with the **${\ITE_BUSINESSLOGIC_GROUP_TAP()}**
  parameter and normally used only if the **${\ITE_BUSINESSLOGIC_GROUP()}**
  parameter is turned `on`.
STOP
	},
	{
		name       => ITE_BUSINESSLOGIC_TRANSFORMATION_TUPLEGROUPSPLIT(),
		type       => "enum",
		enum       => "switch",
		occurrence => $mandatory,
		instances  => $single,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_BUSINESSLOGIC_GROUP(),
			ITE_INGEST_FILEGROUPSPLIT(),
		],
# TODO    postprocess => sub { mutual exclusive and group is on }
		description => <<STOP,
Enables tuple grouping based on tuple attributes to increase
parallelization, improve throughput, or overcome memory limitations.

For example, you want to run deduplicatation on several billion unique records.
Even with memory-efficient deduplication, you exceed the available memory.
Tuple grouping allows you to build smaller record subsets that are distributed
to different instances of the deduplication logic on different hosts. The tuple
grouping also ensures that tuples with the same identification, also called
*group ID*, are routed to the same instance. The memory requirement for
deduplication that runs with a subset of records is less than the memory
requirement for deduplication that runs with the complete record set.

If this parameter is set to `on`, tuple grouping based on tuple
attributes is enabled.

As a developer, you implement your custom business logic in the
<namespace>.chainprocessor.transfomer.custom::DataProcessor composite.
As part of this implementation, you provide the destination group ID in
the `groupID` SPL output attribute. The `groupID` is a 2-digit `rstring`
attribute that supports a range from 00 to 99. The default `groupId` value
is `00`. Tuples that have the same identification must result in the same
`groupID` value. For example, a key attribute of the tuple has a range from
0 to 255. You want to divide this range into two subranges, 0 to 127 and 128
to 255. If the key attribute is in the first range, you provide the 00
`groupID`. If it is in the second range, you provide the 01 `groupID`.

If this parameter is set to `on`, the **${\ITE_BUSINESSLOGIC_GROUP()}**
parameter must be set to `on`, and the **${\ITE_INGEST_FILEGROUPSPLIT()}**
parameter must be set to `off`. In other words, this parameter can only be
set to `on` for an ITE application that uses variant B. For ITE applications
that use variant A or C, this parameter must be set to `off`.
STOP
		details => <<STOP,
When you create an SPL project the `teda-create-project` command line tool, you
selected a variant for your ITE application. The command line
tool set this parameter to the value that is appropriate for your selected
variant. Typically, you do not change this value.
STOP
	},
	{
		name       => ITE_CHECKPOINTING_DIRECTORY(),
		type       => "string",
		regex      => $regEx_path,
		occurrence => $optional,
		instances  => $single,
		default    => "./checkpoint",
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime | $submissionTime,
		related    =>
		[
			ITE_BUSINESSLOGIC_GROUP_CUSTOM_CHECKPOINTING(),
			ITE_BUSINESSLOGIC_GROUP_DEDUPLICATION_CHECKPOINTING(),
		],
		description => <<STOP,
Specifies the directory that receives checkpoint files.

A relative path is relative to the `data` directory.

For more information about the checkpoint files, see the related parameters.
STOP
	},
	{
		name       => ITE_CLEANUP_SCHEDULE_DAYOFMONTH(),
		type       => "string",
		regex      => "(([1-2]?[0-9]|3[01])-)?([1-2]?[0-9]|3[01])",
		occurrence => $optional,
		instances  => $multiple,
		default    => [ ],
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the day or days of the month on which automated cleanup
operations run. To enable automated cleanup operations, the other
schedule parameters must also be specified.

Automated cleanup operations are required, for example, to remove
old information from the file or tuple deduplication.

See the [com.teracloud.streams.teda.utility::ScheduledBeacon|ScheduledBeacon]
operator for more information about the schedule.
STOP
		details => <<STOP,
Before the automated cleanup runs, the ITE application suspends file
processing. The cleanup operations can run from a few seconds to several
hours, depending on your configuration and, for example, the amount of
active records in your deduplication logic.
STOP
	},
	{
		name       => ITE_CLEANUP_SCHEDULE_DAYOFWEEK(),
		type       => "enum",
		enum       => "dayOfWeek",
		occurrence => $optional,
		instances  => $multiple,
		default    => [ "*" ],
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the day or days of the week on which automated cleanup
operations run. To enable automated cleanup operations, the other
schedule parameters must also be specified.

Automated cleanup operations are required, for example, to remove
old information from the file or tuple deduplication.

See the [com.teracloud.streams.teda.utility::ScheduledBeacon|ScheduledBeacon]
operator for more information about the schedule.
STOP
		details => <<STOP,
Before the automated cleanup runs, the ITE application suspends file
processing. The cleanup operations can run from a few seconds to several
hours, depending on your configuration and, for example, the amount of
active records in your deduplication logic.
STOP
	},
	{
		name       => ITE_CLEANUP_SCHEDULE_HOUR(),
		type       => "string",
		regex      => "(([0-9]|1[0-9]|2[0-3])-)?([0-9]|1[0-9]|2[0-3])",
		occurrence => $optional,
		instances  => $multiple,
		default    => [ 0 ],
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the hour or hours of the day during which automated cleanup
operations run. To enable automated cleanup operations, the other
schedule parameters must also be specified.

Automated cleanup operations are required, for example, to remove
old information from the file or tuple deduplication.

See the [com.teracloud.streams.teda.utility::ScheduledBeacon|ScheduledBeacon]
operator for more information about the schedule.
STOP
		details => <<STOP,
Before the automated cleanup runs, the ITE application suspends file
processing. The cleanup operations can run from a few seconds to several
hours, depending on your configuration and, for example, the amount of
active records in your deduplication logic.
STOP
	},
	{
		name       => ITE_CLEANUP_SCHEDULE_MINUTE(),
		type       => "string",
		regex      => "([1-5]?[0-9]-)?[1-5]?[0-9]",
		occurrence => $optional,
		instances  => $multiple,
		default    => [ 0 ],
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the minute or minutes of the hour at which automated cleanup
operations run. To enable automated cleanup operations, the other
schedule parameters must also be specified.

Automated cleanup operations are required, for example, to remove
old information from the file or tuple deduplication.

See the [com.teracloud.streams.teda.utility::ScheduledBeacon|ScheduledBeacon]
operator for more information about the schedule.
STOP
		details => <<STOP,
Before the automated cleanup runs, the ITE application suspends file
processing. The cleanup operations can run from a few seconds to several
hours, depending on your configuration and, for example, the amount of
active records in your deduplication logic.
STOP
	},
	{
		name       => ITE_FUSE_CHAIN_OPERATORS(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_FUSE_GROUP_OPERATORS(),
			ITE_FUSE_GROUPWITHCHAIN_OPERATORS(),
		],
		description => <<STOP,
This parameter describes the operator fusing of all operators from the
following namespaces:
* <namespace>.chainprocessor.reader
* <namespace>.chainprocessor.reader.custom
* <namespace>.chainprocessor.transformer
* <namespace>.chainprocessor.transformer.custom
* <namespace>.chainsink
* <namespace>.chainsink.custom
Set the parameter `on` to fuse all operators into a single Processing Element
to achieve better performance.
You can better analyze the congestion factor or problems in an operator
if you set this parameter to `off`.
STOP
	},
	{
		name       => ITE_FUSE_GROUP_OPERATORS(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_FUSE_CHAIN_OPERATORS(),
			ITE_FUSE_GROUPWITHCHAIN_OPERATORS(),
		],
		description => <<STOP,
This parameter describes the operator fusing of all operators from the
following namespaces:
* <namespace>.context
* <namespace>.context.custom
* <namespace>.housekeeping.context.custom
Set the parameter `on` to fuse all operators of one group into a single 
Processing Element to achieve better performance.
You can better analyze the congestion factor or problems in an operator
if you set this parameter to `off`.
Each group is running in an own Processing Element if this parameter is on.
STOP
	},
	{
		name       => ITE_FUSE_GROUPWITHCHAIN_OPERATORS(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_FUSE_CHAIN_OPERATORS(),
			ITE_FUSE_GROUP_OPERATORS(),
		],
		description => <<STOP,
This parameter describes the operator fusing of all operators from the
following namespaces:
* <namespace>.chainprocessor.reader
* <namespace>.chainprocessor.reader.custom
* <namespace>.chainprocessor.transformer
* <namespace>.chainprocessor.transformer.custom
* <namespace>.chainsink
* <namespace>.chainsink.custom
* <namespace>.context
* <namespace>.context.custom
* <namespace>.housekeeping.context.custom
If this parameter is turned on, then the operators are fused and the tuples
are not sent across Processing Elements.
In variant B, all chains and all group operators are in a single
Processing Element.
As a consequence it not possible to scale across hosts with Variant B
if parameter is turned on.
In variant C, all chains of one group are fused to the same Processing Element.
STOP
		postprocess => sub
		{
			# If the ite.fuse.groupWithChain.operators is on, then the parameters
			# ite.fuse.chain.operators and ite.fuse.group.operators must have the on value.
			my ($self, $parameter) = @_;
			my $fuseGroupWithChainParam = $lookup{lc(ITE_FUSE_GROUPWITHCHAIN_OPERATORS())};
			my ($fuseGroupWithChainParamEnumValue, $fuseGroupWithChainParamMappedValue) = $self->_get($fuseGroupWithChainParam->{name}, $fuseGroupWithChainParam->{type}, $fuseGroupWithChainParam->{instances}, "force");
			if ($fuseGroupWithChainParamEnumValue eq Configurator::Enum::Switch::on())
			{
				my $expected = Configurator::Enum::Switch::on();
				my $actual = Configurator::Enum::Switch::off();
				my $wrongGroupFusion = 0;
				my $wrongChainFusion = 0;
				my $dep = $lookup{lc(ITE_FUSE_GROUP_OPERATORS())};
				my ($key, $value) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
				if ($key eq Configurator::Enum::Switch::off())
				{
					$wrongGroupFusion = 1;					
				}
				my $dep2 = $lookup{lc(ITE_FUSE_CHAIN_OPERATORS())};
				my ($key2, $value2) = $self->_get($dep2->{name}, $dep2->{type}, $dep2->{instances}, "force");
				if ($key2 eq Configurator::Enum::Switch::off())
				{
					$wrongChainFusion = 1;
				}
				if ((1 == $wrongGroupFusion) && (0 == $wrongChainFusion))
				{
					$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES($fuseGroupWithChainParam->{name}, $fuseGroupWithChainParamEnumValue, $dep->{name}, $expected, $actual));
				}
				elsif ((0 == $wrongGroupFusion) && (1 == $wrongChainFusion)) {
					$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES($fuseGroupWithChainParam->{name}, $fuseGroupWithChainParamEnumValue, $dep2->{name}, $expected, $actual));
				}
				elsif ((1 == $wrongGroupFusion) && (1 == $wrongChainFusion)) {
					SPL::CodeGen::errorln(TedaToolkitResource::TEDA_PARAMETER_REQUIRES($fuseGroupWithChainParam->{name}, $fuseGroupWithChainParamEnumValue, $dep->{name}, $expected, $actual));
					$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES($fuseGroupWithChainParam->{name}, $fuseGroupWithChainParamEnumValue, $dep2->{name}, $expected, $actual));
				}
			}
		}
	},
	{
		name       => ITE_EXPORT_STREAMS(),
		type       => "enum",
		enum       => "exportInterface",
		occurrence => $optional,
		instances  => $multiple,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Configures one or more interfaces to export a stream by connecting the spl.adapter::Export operator to this output port, making it available to spl.adapter::Import operators of applications that are running in the same streaming middleware instance. 
The spl.adapter::Export operators in the ITE application are configured to prevent back-pressure.
In case any importing client is not keeping up, data is lost since the connection is dropped and reconnected automatically.

The following interfaces are supported:

 |:------------+:---------------------------------------------------------------------:|:--------------------------------:|
 | Value       + Export property                                                       | Exported SPL Schema              |
 |:============+:=====================================================================:|:================================:|
 | reader      + ite="<namespace>.chainprocessor.reader_output_RecordValidator"        | TypesCommon.ReaderOutStreamType  |
 |-------------+-----------------------------------------------------------------------|----------------------------------|
 | transformer + ite="<namespace>.chainprocessor.transformer_output_DataProcessor"     | TypesCommon.TransformerOutType   |
 |-------------+-----------------------------------------------------------------------|----------------------------------|
 | writer      + ite="<namespace>.chainsink_input_Writer"                              | TypesCommon.ChainSinkStreamType  |
 |-------------+-----------------------------------------------------------------------|----------------------------------|
 | dedup       + ite="<namespace>.context_output_Dedup"                                | TypesCommon.TransformerOutType   |
 --------------------------------------------------------------------------------------------------------------------------

In your custom application, the output stream of the Import operator needs to use the selected schema from the table and the export property must be set as subscription parameter.

Configuration examples:
* The parameter value `reader,writer` selects two interfaces to be exported in each chain.
* The parameter value `dedup` selects the output stream of the BloomFilter operator to be exported in each group.

NOTE: If interface `dedup` is selected the configuration parameter ite.businessLogic.group.deduplication must be set to `on`. Otherwise the value `dedup` is ignored.
STOP
	},	
	{
		name       => ITE_CONTROL_DEBUG(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
# TODO discuss filenames with "CONTEXT" ... should they use the "GROUP" word?
		related    =>
		[
			ITE_BUSINESSLOGIC_GROUP(),
			ITE_CLEANUP_SCHEDULE_DAYOFMONTH(),
			ITE_CLEANUP_SCHEDULE_DAYOFWEEK(),
			ITE_CLEANUP_SCHEDULE_HOUR(),
			ITE_CLEANUP_SCHEDULE_MINUTE(),
		],
# TODO should we mention the output stream name and the corresponding emitting composite (full namespace, not filename)?
		description => <<STOP,
Enables additional file outputs that are used to troubleshoot your ITE
application. The files are located in the `debug` directory, which is
a subdirectory of the configured *data* directory.

If this parameter is set to `on`, you get information about the status
and status changes of the ITE application.
STOP
		details => <<STOP,
If this parameter is enabled, the following files are created:

* `CONTROLLER_APPL_CTRL_OUT.txt`:
  Receives log entries for each **start** or **stop** command that is sent
  to the chains.
* `CONTROLLER_APPL_CTRL_RESP_IN.txt`:
  Receives log entries for each start or stop response.
* `CONTROLLER_CONTEXT_CTRL_OUT.txt`:
  Receives log entries for each shutdown or refresh signal that is sent to
  the group logic. This file is created only if the **${\ITE_BUSINESSLOGIC_GROUP()}**
  parameter is enabled.
* `CONTROLLER_CONTEXT_READY_IN.txt`:
  Receives log entries for each shutdown or refresh response. This file is
  created only if the **${\ITE_BUSINESSLOGIC_GROUP()}** parameter is enabled.
* `CONTROLLER_FILE_INGEST_CLEANUP_OUT.txt`:
  Receives log entries for the initialization phase and for the automated
  cleanup operations that are scheduled with, for example, the
  **${\ITE_CLEANUP_SCHEDULE_DAYOFMONTH()}** parameter.
* `CONTROLLER_FILE_INGEST_CTRL_OUT.txt`:
  Receives log entries for the start of the file ingestion.
STOP
	},
	{
		name       => ITE_EMBEDDEDSAMPLECODE(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_BUSINESSLOGIC_GROUP_CUSTOM(),
			ITE_BUSINESSLOGIC_GROUP_TAP(),
			ITE_BUSINESSLOGIC_TRANSFORMATION_POSTPROCESSING_CUSTOM(),
			ITE_INGEST_CUSTOMFILETYPEVALIDATOR(),
			ITE_INGEST_READER_PREPROCESSING(),
			ITE_INGEST_READER_SCHEMAEXTENSIONFORLOOKUP(),
			ITE_STORAGE_AUDITOUTPUTS(),
			ITE_STORAGE_REJECTWRITER_CUSTOM(),
		],
		description => <<STOP,
Activates sample code in created ITE projects. By default, this parameter is
enabled (`on`), creating projects with a ready-to-run implementation. When
coding custom code starts for the custom namespace composites, this parameter
must be disabled. If you disable the parameter, you must also assign your
parsers to **${\ITE_INGEST_READER_PARSERLIST()}**.

If this parameter is set to `on`, all customized code is disabled.
STOP
	},
	{
		name       => ITE_JOBNAME(),
		type       => "string",
		regex      => $regex_namespace,
		occurrence => $optional,
		instances  => $single,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $submissionTime,
		related    =>
		[
			LM_CONTROLLEDAPPLICATIONS(),
			ITE_INGEST_DIRECTORY_INPUT(),
			ITE_CHECKPOINTING_DIRECTORY(),
			ITE_STORAGE_DIRECTORY_OUTPUTS(),
			ITE_STORAGE_DIRECTORY_STATISTICS(),
			GLOBAL_MULTIHOST()
		],
		description => <<STOP,
Changes the job name of the ITE application at submission time. Per default
the job name is the namespace you specified during creation of the ITE project.
Each ITE job needs a unique job name to communicate with the Lookup Manager. 
Use this parameter to launch multiple ITE applications and assign unique names
to each of them during submission time. You need to ensure that each job uses
a different set of input and output directories, specify the directories by 
using the relevant submission time parameters.

You also need to tell the Lookup Manager application which ITE jobs it needs
to control, by setting the submission time parameter **${\LM_CONTROLLEDAPPLICATIONS()}**
to contain the desired job names.

NOTE: If you use the multihost feature, the ITE jobs still share the same hosttag definitions.
These definitions are created during compile time and cannot be overwritten using the ite.jobName
parameter at submission time. The names of the generated hosttags are still derived from the original
namespace of the application, you setup during project creation.

As a consequence, all jobs will run on the same set of hosts, with the same host placements.
If this is not the desired behaviour, it is recommended to create multiple Streams instances
with different sets of hosts and submit the jobs to different instances. 
Alternatively you can forgo the usage of the multihost feature (do not set global.multiHost=on)
and let Streams decide the host placement on its own. In that case you need to ensure
that all shared resources like filesystems and lookup segments are accessible by all hosts.
STOP
	},
	{
		name       => ITE_INGEST_CUSTOMFILETYPEVALIDATOR(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_EMBEDDEDSAMPLECODE(),
			ITE_INGEST_READER_PARSERLIST(),
			ITE_RESILIENCEOPTIMIZATION(),
		],
		description => <<STOP,
Enables file-type validation. File-type validation distinguishes between
different file types and data formats, for example CSV or ASN.1. Depending
on the determined file type, the ITE application sends the file name to
the appropriate parse logic.

If file-type validation is turned `off`, every file is processed. Only
one parse logic exists that processes all files.

If the file-type validation is turned `on`, file names are determined to be
valid or invalid. If a file is invalid, it is not processed but logged as
invalid and moved to the `invalid` directory, which is a subdirectory of
the input directory that is specified with the
**${\ITE_INGEST_DIRECTORY_INPUT()}** parameter.

If the filename is valid, a unique file type ID is stored in the `fileType`
SPL output attribute of the <namespace>.fileingestion.custom::FileTypeValidator
composite operator. As a developer, you want to implement an algorithm that
validates the file name and determines the file type in the
<namespace>.fileingestion.custom::FileTypeValidator composite operator.
To activate your algorithm, set this parameter to `on`. You must also set the
**${\ITE_EMBEDDEDSAMPLECODE()}** parameter to `off`, so the ITE application
uses your implementation instead of the sample logic that is provided with the
<namespace>.fileingestion.sample::FileTypeValidator composite operator.

The unique file type IDs that can occur as a result of your algorithm must be
consistent with the types that are specified with the **${\ITE_INGEST_READER_PARSERLIST()}**
parameter. Any inconsistency is reported as soon as it occurs, either leading
to an unhealthy processing element or a log message for this file, depending
on the **${\ITE_RESILIENCEOPTIMIZATION()}** parameter.

The easiest algorithm checks for a file name pattern. A more complicated
algorithm could read and analyze the file contents.
STOP
	},
	{
		name       => ITE_INGEST_CUSTOMFILECONTROL(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_INGEST_LOADDISTRIBUTION()
		],
		description => <<STOP,
Enables fine grained control over the filename distribution mechanism.
If this parameter is set to true, the custom composite operator
<namespace>.fileingestion.custom::FileControl needs to be implemented.
It receives all acknowledgement tuples from the chain processors, after a file is processed.
The developer can delay these acknowledgement tuples to control when a certain chain starts processing
the next input file. The type of the acknowledgement tuples is <namespace>.streams::TypesCommon.AcknowledgedFilesType
It contains the chain number, the filename and a few other attributes
(see TypesCommon.splmm for details).

This option can only be used if the **${\ITE_INGEST_LOADDISTRIBUTION()}** parameter
is set to `equalLoad`. If this parameter is set to `on`, the **${\ITE_INGEST_FILEGROUPSPLIT()}**
parameter must be set to `off`. In other words, this parameter can only be
set to `on` for an ITE application that uses variant A or B. For ITE applications
that use variant C, this parameter must be set to `off`.
STOP
		postprocess => sub
		{
			# If the ite.ingest.customFileControl is on, then the parameter
			# ite.ingest.loadDistribution must have the equalLoad value.
			my ($self, $parameter) = @_;
			my $controlParam = $lookup{lc(ITE_INGEST_CUSTOMFILECONTROL())};
			my ($controlParamEnumValue, $controlParamMappedValue) = $self->_get($controlParam->{name}, $controlParam->{type}, $controlParam->{instances}, "force");
			if ($controlParamEnumValue eq Configurator::Enum::Switch::on())
			{
				my $dep = $lookup{lc(ITE_INGEST_LOADDISTRIBUTION())};
				my ($key, $value) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
				if ($key eq Configurator::Enum::LoadDistribution::roundRobin())
				{
					my $expected = Configurator::Enum::LoadDistribution::equalLoad();
					my $actual = Configurator::Enum::LoadDistribution::roundRobin();
					$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES($controlParam->{name}, $controlParamEnumValue, $dep->{name}, $expected, $actual));
				}

				my $dep2 = $lookup{lc(ITE_INGEST_FILEGROUPSPLIT())};
				my ($key2, $value2) = $self->_get($dep2->{name}, $dep2->{type}, $dep2->{instances}, "force");
				if ($key2 eq Configurator::Enum::Switch::on())
				{
					my $expected = Configurator::Enum::Switch::off();
					my $actual = Configurator::Enum::Switch::on();
					$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES($controlParam->{name}, $controlParamEnumValue, $dep2->{name}, $expected, $actual));
				}
				
			}
		}
	},
	{
		name       => ITE_INGEST_DEBUG(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
# TODO Different spelling (upper/lower case) for RawFiles_<sequence>.txt
# TODO should we mention the output stream name and the corresponding emitting composite (full namespace, not filename)?
		description => <<STOP,
Enables additional file outputs that are used to troubleshoot your ITE
application. The files are located in the `debug` directory, which is
a subdirectory of the configured *data* directory.

When this parameter is `on`, you get information about file
detection.
STOP
		details => <<STOP,
If this parameter is enabled, the following files are created:

* `FILEINGESTION_DROPPED_FILES.txt`:
  Receives log entries for files that are dropped because their names are
  either invalid or duplicates.
* `FILEINGESTION_FILES.txt`:
  Receives log entries for files that have valid and unique filenames.
* `FILEINGESTION_IN_ACK_FILES.txt`:
  Receives log entries for files that are processed and commit themselves
  to the file name deduplication logic.
* `FILEINGESTION_IN_CTRL.txt`:
  Receives log entries for **start** and **stop** commands that enable or
  disable the directory scan.
* `FILEINGESTION_OUT_FILES.txt`:
  Receives log entries for files that must be processed. For an ITE application
  in variant C, the `groupID` SPL attribute is set. This attribute distributes
  this tuple to the correct group logic instance.
* `RawFiles_<sequence>.txt`:
  Receives log entries for each detected input file. After 100,000 entries, a
  new log file is created with an incremented sequence number.
STOP
	},
	{
		name       => ITE_INGEST_ARCHIVEMODE(),
		type       => "enum",
		enum       => "archiveMode",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::ArchiveMode::single(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_INGEST_DIRECTORY_INPUTLISTFILE(),
		],
		description => <<STOP,
Specifies the base directory that is used for the following subdirectories:

* `archive`:
  Receives successfully processed input files.
* `duplicate`:
  Receives duplicate input files (files that are already processed).
* `invalid`:
  Receives files that do not match the allowed file types and formats.
* `failed`:
  Receives files with which unexpected problems occurred and that are not
  automatically resolved.

If you set this parameter to `single`, then the ite.ingest.directory.input
parameter is used as base directory.

In case **${\ITE_INGEST_DIRECTORY_INPUTLISTFILE()}** contains multiple directories and 
ite.ingest.archiveMode is set to `multiple` the subdirectories are created
to the corresponding input directory.
STOP
	},
	{
		name       => ITE_INGEST_DEDUPLICATION(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		children   =>
		[
			ITE_INGEST_DEDUPLICATION_TIMETOKEEP(),
			ITE_INGEST_DEDUPLICATION_REPROCESSFILEPATTERN(),
		],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_INGEST_DIRECTORYSCAN_PROCESSFILEPATTERN(),
		],
		description => <<STOP,
Enables file name deduplication.
STOP
	},
	{
		name       => ITE_INGEST_DEDUPLICATION_TIMETOKEEP(),
		type       => "string",
		regex      => $regex_timeToKeep,
		occurrence => $optional,
		instances  => $single,
		default    => "1d",
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies the time after which a file name is removed from
the set of unique file names in the file name deduplication logic.
STOP
		details => <<STOP,
This parameter is active only if the parent parameter, **${\ITE_INGEST_DEDUPLICATION()}**, is set to `on`.
STOP
	},
	{
		name       => ITE_INGEST_DEDUPLICATION_REPROCESSFILEPATTERN(),
		type       => "string",
		occurrence => $optional,
		instances  => $single,
		default    => "",
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Defines the file name pattern for files to reprocess. Matching file names
bypass the duplicate check of the file ingestion logic, and the files are
processed again. The pattern should not match the same set of files as
the pattern configured for parameter ite.ingest.directoryScan.processFilePattern,
because this would allow all processed files to bypass the duplicate check.
STOP
		details => <<STOP,
This parameter is active only if the parent parameter,
**${\ITE_INGEST_DEDUPLICATION()}**, is set to `on`.
STOP
		postprocess => sub
		{
			# If the reprocess file pattern is set, it should not match the value of the ITE_INGEST_DIRECTORYSCAN_PROCESSFILEPATTERN parameter
			# because this effectively disables the filename deduplication.
			my ($self, $parameter) = @_;
			my $dedup = $lookup{lc(ITE_INGEST_DEDUPLICATION())};
			my ($dedupVal) = $self->_get($dedup->{name}, $dedup->{type}, $dedup->{instances}, "force");

			# only check if parameter is set and ITE_INGEST_DEDUPLICATION is on 			
			if (exists($parameter->{value}) && $dedupVal eq Configurator::Enum::Switch::on())
			{
				my $dep = $lookup{lc(ITE_INGEST_DIRECTORYSCAN_PROCESSFILEPATTERN())};
				my ($scanPattern) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
				if ($scanPattern eq $parameter->{value})
				{
					$self->_fail(TedaToolkitResource::TEDA_PARAMETERS_HAVE_SAME_VALUE($parameter->{name},$dep->{name},$scanPattern));
				}
			}
		}
	},
	{
		name       => ITE_INGEST_DIRECTORY_INPUT(),
		type       => "string",
		regex      => $regEx_path,
		occurrence => $optional,
		instances  => $single,
		default    => "./in",
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the path of the directory that receives the input files.
A relative path is relative to the `data` directory.

The input files must occur in this directory as a result of an atomic
action. In other words, it is recommended that you move input files into
this directory instead of copying or creating them. Over time, copying or
creating input files might result in incompletely processed or failed files.
STOP
		details => <<STOP,
The ITE application creates following subdirectories during the startup phase:

* `archive`:
  Receives successfully processed input files.
* `duplicate`:
  Receives duplicate input files (files that are already processed).
* `invalid`:
  Receives files that do not match the allowed file types and formats.
* `failed`:
  Receives files with which unexpected problems occurred and that are not
  automatically resolved.
* `reprocess`:
  Contains files that will be reprocessed, for example after a correction.
  Move the necessary files into this directory.
STOP
	},
	{
		name       => ITE_INGEST_DIRECTORY_INPUTLISTFILE(),
		type       => "string",
		occurrence => $optional,
		instances  => $single,
		default    => "",
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Configures the path to the file that contains a list of several input
directories. This file is a text file that contains one absolute or
relative directory path per line. Comment lines start with a pound
symbol ('#') in column 1. The list must not contain duplicates. This
parameter is optional.

If this parameter is used, all files from the first directory in the
list are considered urgent files. Urgent files are queued in a separate
file queue, which has precedence over the normal file queue.
STOP
	},
	{
		name       => ITE_INGEST_DIRECTORYSCAN_NANOSECONDSPRECISION(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Enables scanning of files with nanosecond precision. When this parameter is
turned off, all nanoseconds fields are set to zero in the directory scanner.
If your file system does not support nanosecond precision, this parameter can
be turned off.
STOP
	},
	{
		name       => ITE_INGEST_DIRECTORYSCAN_PROCESSFILEPATTERN(),
		type       => "string",
		regex      => $regEx_anyNonEmptyString,
		occurrence => $optional,
		instances  => $single,
		default    => ".*\\.DAT\$",
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_INGEST_DEDUPLICATION(),
		],
		description => <<STOP,
Defines a file name pattern. The directory scanner reports matching file names
to the following ingestion logic. If file name deduplication is turned on,
these files are checked to determine whether they have been processed.
If so, the files are moved to the `duplicate` files folder.
STOP
	},
	{
		name       => ITE_INGEST_DIRECTORYSCAN_SLEEPTIME(),
		type       => "float",
		min        => 1,
		max        => 3600,
		occurrence => $optional,
		instances  => $single,
		default    => "5.0",
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies the time (in seconds) after each directory scan. This parameter
optimizes the scan load. For example, there is no need to scan the input
directories every second if new files arrive only once per hour.
STOP
	},
	{
		name       => ITE_INGEST_DIRECTORYSCAN_SORT(),
		type       => "enum",
		enum       => "sort",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Sort::off(),
		children   =>
		[
			ITE_INGEST_DIRECTORYSCAN_SORT_ATTRIBUTE(),
		],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related     =>
		[
			ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME(),
		],
		description => <<STOP,
Specifies the sort mode for file name tuples.

If this parameter is set to `off`, sorting is disabled, in contrast to the
spl.adapter::DirectoryScan operator, which always sorts by file time.

If this parameter is set to `ascending`, file name tuples are sorted in
ascending order. The sort attribute must be provided in the
**${\ITE_INGEST_DIRECTORYSCAN_SORT_ATTRIBUTE()}** parameter. The sort
window is one scan cycle of the directory scanner.

If the parameter is set to `descending`, file name tuples are sorted in
descending order. The sort attribute must be provided in the
**${\ITE_INGEST_DIRECTORYSCAN_SORT_ATTRIBUTE()}** parameter. The sort
window is one scan cycle of the directory scanner.

If this parameter is set to `custom`, you must provide the sort logic in the
custom  <namespace>.fileIngestion.custom::FileSort composite operator. You
can provide the sort attribute in the **${\ITE_INGEST_DIRECTORYSCAN_SORT_ATTRIBUTE()}**
parameter or in the <namespace>.fileIngestion.custom::FileSort composite
operator itself.

The input schema of the <namespace>.fileIngestion.custom::FileSort composite
operator depends on the setting of the related
**${\ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME()}** parameter.
STOP
		postprocess => sub
		{
			my ($self, $parameter) = @_;
			my $p = $parameter;
			my ($enumValue, $mappedValue) = $self->_get($p->{name}, $p->{type}, $p->{instances}, "force");
			if (defined $enumValue && $enumValue ne Configurator::Enum::Sort::off() && $enumValue ne Configurator::Enum::Sort::custom())
			{
				# If sorting is switched on, the following parameters are required.
				my @subfeatures =
				(
					ITE_INGEST_DIRECTORYSCAN_SORT_ATTRIBUTE(),
				);
				my @missing;
				foreach my $name (@subfeatures)
				{
					my $dep = $lookup{lc($name)};
					my ($ev, $mv) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
					push @missing, $name unless (defined $ev);
				}
				$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES_OTHER_CONFIG_PARAMETERS($p->{name}, $enumValue, join(",", @missing))) unless (0 == scalar @missing);
			}
		}
	},
	{
		name       => ITE_INGEST_DIRECTORYSCAN_SORT_ATTRIBUTE(),
		type       => "enum",
		enum       => "sortAttr",
		occurrence => $optional,
		instances  => $single,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related     =>
		[
			ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME(),
		],
		description => <<STOP,
Specifies the file-sort attribute. The file-sort attribute is used by the
downstream sort operator. This parameter is an enumeration parameter with
the following values:

* `off`:
  No file-sort attribute is selected.
* `time`:
  The file time is used as the sort attribute and depends on the
   **${\ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME()}** parameter.
* `name`:
  The file name is used as the sort attribute.
* `size`:
  The file size is used as the sort attribute.

If the parent parameter is set to `ascending` or `descending`, this parameter
is mandatory. If the parent parameter is set to `custom`, it is optional. If
the parent parameter is set to `off`, this parameter is forbidden.

If this parameter is required for the application and the related
**${\ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME()}** parameter is
turned on, this parameter must be set to `time`.
STOP
		postprocess => sub
		{
			# Check for warning if specialFileTime is enabled, but sorting for time is not enabled
			my ($self, $parameter) = @_;
			my $p = $parameter;
			my ($enumValue, $mappedValue) = $self->_get($p->{name}, $p->{type}, $p->{instances}, "force");
			if (defined $enumValue && $enumValue ne Configurator::Enum::SortAttr::filetime())
			{
				my $dep = $lookup{lc(ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME())};
				my ($sptEnabledEnum, $sptMappedEnabledEnum) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
				# TODO: Fail? Or is a warning enough here?
				$self->_fail(TedaToolkitResource::TEDA_NOT_SORTING_FOR_TIME_WITH_SPECIALFILETIME_ENABLED($dep->{name}, $enumValue, Configurator::Enum::SortAttr::filetime())) if ($sptEnabledEnum eq Configurator::Enum::Switch::on());
			}
		}
	},
	{
		name       => ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		children   =>
		[
			ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_FORMAT(),
			ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_REGEXP(),
		],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_INGEST_DIRECTORYSCAN_SORT_ATTRIBUTE(),
		],
		description => <<STOP,
Enables a user-selected source for file time data. File time data is used in
the file name deduplication logic to implement the eviction policy and to
sort file name tuples.

The parameter is closely related to the
**${\ITE_INGEST_DIRECTORYSCAN_SORT_ATTRIBUTE()}** parameter.

If this parameter is set to `off`, the file time attribute is determined from
modification time of the file object. If this parameter is set to `on`, the file
time is determined from the file name. The file time generation is controlled by
the **${\ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_REGEXP()}** and
and **${\ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_FORMAT()}** parameters.
STOP
		details  => <<STOP,
If this parameter is set to `on` and file name sorting is used, the
**${\ITE_INGEST_DIRECTORYSCAN_SORT_ATTRIBUTE()}** parameter must be set to
'time'.
STOP
		postprocess => sub
		{
			my ($self, $parameter) = @_;
			my $p = $parameter;
			my ($enumValue, $mappedValue) = $self->_get($p->{name}, $p->{type}, $p->{instances}, "force");
			if (defined $enumValue && $enumValue eq Configurator::Enum::Switch::on())
			{
				# If specialFileTime extraction is switched on, the following parameters are required.
				my @subfeatures =
				(
					ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_FORMAT(),
					ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_REGEXP(),
				);
				my @missing;
				foreach my $name (@subfeatures)
				{
					my $dep = $lookup{lc($name)};
					my ($ev, $mv) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
					push @missing, $name unless (defined $ev);
				}
				$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES_OTHER_CONFIG_PARAMETERS($p->{name}, $enumValue, join(",", @missing))) unless (0 == scalar @missing);


				# Check cardinality of child parameters
				my $depFormat = $lookup{lc(ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_FORMAT())};
				my ($formatValueList, $mappedFormatValues) = $self->_get($depFormat->{name}, $depFormat->{type}, $depFormat->{instances}, "force");
				
				my $depRegexp = $lookup{lc(ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_REGEXP())};
				my ($regexpValueList, $mappedRegexpValues) = $self->_get($depRegexp->{name}, $depRegexp->{type}, $depRegexp->{instances}, "force");
				
				my $numberOfFormatValues = defined $formatValueList ? scalar @{$formatValueList} : 0;
				my $numberOfRegexpValues = defined $regexpValueList ? scalar @{$regexpValueList} : 0;
				
				$self->_fail(TedaToolkitResource::TEDA_PARAMETERS_HAVE_DIFFERENT_NUMBER_OF_VALUES($depFormat->{name}, $numberOfFormatValues, $depRegexp->{name}, $numberOfRegexpValues)) if ($numberOfFormatValues != $numberOfRegexpValues);
			}
		}
	},
	{
		name       => ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_FORMAT(),
		type       => "enum",
		enum       => "dateTimeFormat",
		occurrence => $optional,
		instances  => $multiple,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Provides a list of date and time formats for special file-time conversion.

Formats with a '_' separator accept any kind of separator.
STOP
		details  => <<STOP,
If the **${\ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME()}** parent parameter is
set to `on`, this parameter is mandatory. If not, this parameter is forbidden.

The cardinality of the parameter must match the cardinality of the
**${\ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_REGEXP()}** related parameter.
STOP
	},
	{
		name       => ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_REGEXP(),
		type       => "string",
		regex      => $regEx_anyNonEmptyString,
		occurrence => $optional,
		instances  => $multiple,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
If the **${\ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME()}** parameter is set to
`on`, this parameter is required. The values of this parameter are a list of
regular expessions. The file name is tested against this regular expressions
list. The first match is used and converted into a time, which overrides the
file time attribute. The date and time format is used from the corresponding
place in the format list that is defined in the
**${\ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_FORMAT()}** parameter.

Each regular expression must contain one group (pair of parentheses) that
isolates the date and time from the rest of the file name. If no match is
found with a particular file name, the file is considered invalid and moved
to the `invalid` files directory.

Valid values are a comma-separated list of regular expressions that contain one
pair of parentheses. A comma must not be part of a regular expression.

Example:

If a file name contains a date and time substring in the last 8 digits in front
of the filename extension, for example cdr_cid1234_20120405.txt, the following
regular expression can extract the date and time portion: `:MARKUP-BEG:.*_([0-9]{8}).txt\$:MARKUP-END:`

The appropriate format parameter is: YYYYMMDD
STOP
		details  => <<STOP
If the **${\ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME()}** parent parameter is
set to `on`, this parameter is mandatory. If not, this parameter is forbidden.

The cardinality of this parameter must match the cardinality of the
**${\ITE_INGEST_DIRECTORYSCAN_SPECIALFILETIME_FORMAT()}** related parameter.
STOP
	},
	{
		name       => ITE_INGEST_FILEGROUPSPLIT(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		children   =>
		[
			ITE_INGEST_FILEGROUPSPLIT_PATTERN(),
		],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Enables the file ingestion group split.
STOP
	},
	{
		name       => ITE_INGEST_FILEGROUPSPLIT_PATTERN(),
		type       => "string",
		regex      => $regEx_anyNonEmptyString,
		occurrence => $optional,
		instances  => $single,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_INGEST_LOADDISTRIBUTION_GROUPCONFIGFILE(),
		],
		description => <<STOP,
Defines a regular expression that extracts the group ID from the file name.
The expression must have exactly one group (a pair of parentheses), which
isolates the group ID from the rest of the file name. If the file name does
not match the pattern, it is assigned to the `default` group. The group
configuration is defined in the group configuration file that is specified
in the **${\ITE_INGEST_LOADDISTRIBUTION_GROUPCONFIGFILE()}** parameter.

If the **${\ITE_INGEST_FILEGROUPSPLIT()}** parameter is set to `on`, this
parameter is required.
STOP
	},
	{
		name       => ITE_INGEST_LOADDISTRIBUTION(),
		type       => "enum",
		enum       => "loadDistribution",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::LoadDistribution::equalLoad(),
		children   =>
		[
			ITE_INGEST_LOADDISTRIBUTION_GROUPCONFIGFILE(),
			ITE_INGEST_LOADDISTRIBUTION_NUMBEROFPARALLELCHAINS(),
			ITE_INGEST_LOADDISTRIBUTION_UDP(),
		],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Selects the distribution method for the input files to the parallel processing
chains.
STOP
	},
	{
		name       => ITE_INGEST_LOADDISTRIBUTION_GROUPCONFIGFILE(),
		type       => "string",
		regex      => $regEx_path,
		occurrence => $optional,
		instances  => $single,
		default    => "./config/groups.cfg",
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Changes the name of the group configuration file. This parameter is obsolete in
variants that do not use file groups.

Relative paths are relative to the `data` directory.
STOP
		details => <<STOP,
The following example shows the expected file format (with added whitespaces
for readability):

	#Group identifier, Chains per group, Maximum BloomFilter entries
	"default"        , 2               , 10000000
	"2"              , 1               , 10000000
	"3"              , 1               , 10000000
STOP
	},
	{
		name       => ITE_INGEST_LOADDISTRIBUTION_NUMBEROFPARALLELCHAINS(),
		type       => "integer",
		min        => 1,
		occurrence => $optional,
		instances  => $single,
		default    => "3",
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Defines the number of parallel processing chains for application variants that
do not build groups based on file names.
STOP
	},
	{
		name       => ITE_INGEST_LOADDISTRIBUTION_UDP(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Enables the user-defined parallelism feature.

If this parameter is set to `on`, the number of parallel chains can be
increased at job submission time with one or more submission parameter
depending on the used application variant. Otherwise, the number of chains
is generated at compile time and cannot be changed at submission time.

If this parameter is set to `on`, you need to select the distribution method
`roundRobin` with the ite.ingest.loadDistribution parameter.

If you are using variant A or B, use the
**ite.ingest.loadDistribution.groupConfigFile.chains** parameter.
If you are using variant C, use the
**ite.ingest.loadDistribution.groupConfigFile.chains.00** through
**ite.ingest.loadDistribution.groupConfigFile.chains.99** parameters.

If the user-defined parallelism feature is used in custom code, this parameter
must be turned off since nested parallel regions are not supported.
STOP
		postprocess => sub
		{
			# If the ite.ingest.loadDistribution.udp is on, then the parameter
			# ite.ingest.loadDistribution must have the roundRobin value.
			my ($self, $parameter) = @_;
			my $udpParam = $lookup{lc(ITE_INGEST_LOADDISTRIBUTION_UDP())};
			my ($udpParamEnumValue, $udpParamMappedValue) = $self->_get($udpParam->{name}, $udpParam->{type}, $udpParam->{instances}, "force");
			if ($udpParamEnumValue eq Configurator::Enum::Switch::on())
			{
				my $dep = $lookup{lc(ITE_INGEST_LOADDISTRIBUTION())};
				my ($key, $value) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
				if ($key eq Configurator::Enum::LoadDistribution::equalLoad())
				{
					my $expected = Configurator::Enum::LoadDistribution::roundRobin();
					my $actual = Configurator::Enum::LoadDistribution::equalLoad();
					$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES($udpParam->{name}, $udpParamEnumValue, $dep->{name}, $expected, $actual));
				}
			}
		}
	},
	{
		name       => ITE_INGEST_READER_COMPRESSION(),
		type       => "enum",
		enum       => "fileCompression",
		occurrence => $optional,
		instances  => $multiple,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Enables the compression parameter for the spl.adapter::FileSource operator in the
specified composite operators. The default compression mode is `gzip` but can
be changed in the <namespace>.chainprocessor.reader.custom::FileReaderCustom
composite operator by setting the compression parameter for the used composite.

Enable this parameter only if your input files are compressed.
STOP
	},
	{
		name       => ITE_INGEST_READER_CUSTOMFILESTATISTICS(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Enables custom file statistics. To add attributes to the statistics schema,
use TypesCustom::CustomFileStatisticsStreamType. If the **${\ITE_STORAGE_TYPE()}**
parameter is not set to 'tableFile', this parameter should be used.
STOP
	},
	{
		name       => ITE_INGEST_READER_CUSTOMPARSERSTATISTICS(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Enables custom parser statistics. Use TypesCustom::CustomParserStatisticsStreamType
to define the parser statistic output stream type. It should be used to integrate
your own parser.
STOP
	},
	{
		name       => ITE_INGEST_READER_DEBUG(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Enables additional file outputs that are used to troubleshoot your ITE
application. The files are located in the `debug` directory, which is a
subdirectory of the configured *data* directory.

When you set this parameter to `on`, you receive information about the parsed files.
STOP
		details => <<STOP,
When this parameter is enabled, the following files are created:

* `CHAIN_READER_FILES_IN_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives log entries for files that must be processed.
* `CHAIN_READER_FILES_ACK_IN_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives log entries for files that are processed and are committed to the
  file name deduplication logic. The chain can then receive and process a new
  file.
* `CHAIN_READER_FILES_APP_CTRL_IN_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives log entries for each **start** or **stop** command that is received
  by the chain control logic.
* `CHAIN_READER_REC_OUT_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives log entries for each valid data tuple that leaves the record
  validation, which is the <namespace>.chainprocessor.reader.custom::RecordValidator,
  or, if the **${\ITE_EMBEDDEDSAMPLECODE()}** parameter is turned on, the
  <namespace>.chainprocessor.reader.sample::RecordValidator composite
  operator.
* `CHAIN_READER_REJ_OUT_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives log entries for each rejected data tuple that leaves the record
  validation, which is the <namespace>.chainprocessor.reader.custom::RecordValidator,
  or, if the **${\ITE_EMBEDDEDSAMPLECODE()}** parameter is turned on, the
  <namespace>.chainprocessor.reader.sample::RecordValidator composite
  operator.
* `CHAIN_READER_STAT_OUT_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives statistics log entries for each completed file.
* `CHAIN_READER_STATUS_OUT_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives log entries for each status change of the chain that is initiated
  with a **start** or **stop** command.
* `CHAIN_READER_APP_CTRL_RESP_OUT_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives log entries for each start or stop response that leaves the chain
  control logic.
* `FILE_READER_OUT_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives log entries for each data tuple that is sent by the FileReader
  composites that are specified in the **${\ITE_INGEST_READER_PARSERLIST()}**
  parameter.
* `FILE_READER_STAT_<GROUP_ID>_<CHAIN_ID>.txt`:
  Receives statistics log entries for each completed file. The statistics are a
  subset of the statistics that are stored in the `CHAIN_READER_STAT_OUT_<GROUP_ID>_<CHAIN_ID>.txt`
  file. The FileReader generates these statistics.
STOP
	},
	{
		name       => ITE_INGEST_READER_ENCODING(),
		type       => "enum",
		enum       => "fileEncoding",
		occurrence => $optional,
		instances  => $multiple,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Enables the encoding parameter for the spl.adapter::FileSource operator in the
specified composite operators.
STOP
	},
	{
		name       => ITE_INGEST_READER_PARSERLIST(),
		type       => "string",
		regex      => $regEx_parserList,
		occurrence => $optional,
		instances  => $multiple,
		default    => [ '*|FileReaderCustom' ],
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Enables one or more parsers and specifies the file type ids for which the
parsers are responsible.

If you disable the parameter **${\ITE_EMBEDDEDSAMPLECODE()}** to start
your customizing work, you must immediately assign your parsers to this
parameter.
STOP
		postprocess => sub
		{
			# If the sample code is enabled, this parameter must be specified
			# and must contain the following three elements:
			# ASN|FileReaderASN1,BIN|FileReaderStructure,CSV|FileReaderCSV
			my ($self, $parameter) = @_;
			my $dep = $lookup{lc(ITE_EMBEDDEDSAMPLECODE())};
			my ($key, $value) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
			if ($key eq Configurator::Enum::Switch::on())
			{
				my $expected = join(",", sort ( 'ASN|FileReaderASN1', 'BIN|FileReaderStructure', 'CSV|FileReaderCSV' ));
				my $actual = join(",", sort @{exists $parameter->{value} ? $parameter->{value} : $parameter->{default}});
				if ($expected ne $actual)
				{
					$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES($dep->{name}, $key, $parameter->{name}, $expected, $actual));
				}
			}
		}
	},
	{
		name       => ITE_INGEST_READER_PREPROCESSING(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_EMBEDDEDSAMPLECODE(),
		],
		description => <<STOP,
Enables file preprocessing that is used to determine attribute values once
per file or to determine the file type if the file type cannot be derived
from the file name.

Implement your code in the <namespace>.chainprocessor.reader.custom::PreFileReader
composite operator. To activate your code, set this parameter to `on`. You must
also set the **${\ITE_EMBEDDEDSAMPLECODE()}** parameter to `off`, so the ITE
application uses your implementation instead of the sample logic that is
provided with the <namespace>.chainprocessor.reader.sample::PreFileReader
composite operator.
STOP
	},
	{
		name       => ITE_INGEST_READER_SCHEMAEXTENSIONFORLOOKUP(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_EMBEDDEDSAMPLECODE(),
		],
		description => <<STOP,
If this parameter is set to `on`, the stream schema, which is the output of
the parsing and the input to the data enrichment, is extended with the attributes
that are specified in the <namespace>.streams.custom::TypesCustom.LookupType
type.

These additional attributes are commonly used during the enrichment. In other
words, the custom lookup code assigns the enrichment data to these attributes.

If you require additional attributes to assign your enrichment data, set this
parameter to `on` and adapt the <namespace>.streams.custom::TypesCustom.LookupType
type. To activate the customized type, you must also set the **${\ITE_EMBEDDEDSAMPLECODE()}**
parameter to `off`, so the ITE application uses the customized type instead
of the sample <namespace>.streams.sample::TypesCustom.LookupType type.
STOP
	},
	{
		name       => ITE_RESILIENCEOPTIMIZATION(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::on(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Enables the resilience for unexpected errors.

An unexpected error is, for example, a file that is deleted while being
processed or a custom business logic that accesses data arrays out of
bounds. For such problems, most SPL operators or functions raise exceptions
and abort the processing element.

If resilience is enabled, the ITE application catches these unexpected errors
and reports them in the `rejected/<input-filename>.rej.csv` rejection file.
The rejection file is located in the output directory that is specified in
the **${\ITE_STORAGE_DIRECTORY_OUTPUTS()}** parameter. If resilience is
disabled, errors lead to unhealthy processing elements (PEs) that stop
tuple processing.
STOP
	},
	{
		name       => ITE_STORAGE_AUDITOUTPUTS(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Enables an additional processing step for file statistics that you can use
to, for example, write the statistics to a database or export the statistics
to another application.

Implement your code in the <namespace>.chainsink.custom::AuditTableWriter
composite operator. To activate your code, set this parameter to `on`. You must
also set the **${\ITE_EMBEDDEDSAMPLECODE()}** parameter to `off`, so the ITE
application uses your implementation instead of the sample logic that is
provided with the <namespace>.chainsink.sample::AuditTableWriter
composite operator.
STOP
	},
	{
		name       => ITE_STORAGE_DIRECTORY_OUTPUTS(),
		type       => "string",
		regex      => $regEx_path,
		occurrence => $optional,
		instances  => $single,
		default    => "./out",
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime | $submissionTime,
		related    =>
		[
			ITE_STORAGE_DIRECTORY_STATISTICS(),
		],
		description => <<STOP,
Specifies the base directory for output files. This base directory may contain
`load`, `rejected`, and `statistics` subdirectories.

A relative path is relative to the `data` directory.
STOP
	},
	{
		name       => ITE_STORAGE_DIRECTORY_STATISTICS(),
		type       => "string",
		regex      => $regEx_path,
		occurrence => $optional,
		instances  => $single,
		default    => "./out/statistics",
		empty      => undef,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime | $submissionTime,
		description => <<STOP,
Specifies the base directory for the statistics log files. For each file that
is processed by an ITE application, an entry is written to the statistics log
file. Job statistics logs are written with the date as the first part of the
file name.

An `archive` subdirectory is created by the application and on a date switch,
log files are moved to this `archive` directory.

A relative path is relative to the `data` directory.
STOP
	},
	{
		name       => ITE_STORAGE_OUTPUTDIRECTORYSTRUCTURE(),
		type       => "enum",
		enum       => "outputDirectoryStructure",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::OutputDirectoryStructure::allInOne(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		description => <<STOP,
Specifies the structure of the output directories. Output files can reside in
one directory, in different subdirectories (according to the input file that
created the output files), or in subdirectories that contains all the files of
one day.
STOP
	},
	{
		name       => ITE_STORAGE_REJECTWRITER_CUSTOM(),
		type       => "enum",
		enum       => "switch",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::Switch::off(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_EMBEDDEDSAMPLECODE(),
		],
		description => <<STOP,
If set to `on`, you can implement your own handling for rejected records,
for example to create alarms or write different files.

Implement your code in the <namespace>.chainsink.custom::RejectWriterCustom
composite operator. To activate your code, set this parameter to `on`. You must
also set the **${\ITE_EMBEDDEDSAMPLECODE()}** parameter to `off`, so the ITE
application uses your implementation instead of the sample logic that is
provided with the <namespace>.chainsink.sample::RejectWriterCustom
composite operator.
STOP
	},
	{
		name       => ITE_STORAGE_TABLENAMES(),
		type       => "string",
		regex      => $regEx_table,
		occurrence => $optional,
		instances  => $multiple,
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_STORAGE_TYPE()
		],
		description => <<STOP,
Configures the table names that are used in the TableFileWriter. For each
table name, a dedicated spl.adapter::FileSink operator is used. If the
**${\ITE_STORAGE_TYPE()}** parameter is set to 'tableFile', this parameter
is mandatory.
STOP
		postprocess => sub
		{
			# If the sample code is enabled and the storage type is set to tableFile,
			# this parameter must be specified and must contain the following element:
			# FCT.FCT_SAMPLE
			my ($self, $parameter) = @_;
			my $depSampleCode = $lookup{lc(ITE_EMBEDDEDSAMPLECODE())};
			my ($sampleCodeEnumValue, $scMappedValue) = $self->_get($depSampleCode->{name}, $depSampleCode->{type}, $depSampleCode->{instances}, "force");
			my $depStorageType = $lookup{lc(ITE_STORAGE_TYPE())};
			my ($storageTypeEnumValue, $stMappedValue) = $self->_get($depStorageType->{name}, $depStorageType->{type}, $depStorageType->{instances}, "force");
			if ($sampleCodeEnumValue eq Configurator::Enum::Switch::on() &&
			    $storageTypeEnumValue eq Configurator::Enum::StorageType::tableFile())
			{
				my $expected = join(",", sort ( 'FCT.FCT_SAMPLE' ));
				my $actual = join(",", sort @{exists $parameter->{value} ? $parameter->{value} : $parameter->{default}});
				if ($expected ne $actual)
				{
					$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES($depSampleCode->{name}, $sampleCodeEnumValue, $parameter->{name}, $expected, $actual));
				}
			}
		}
	},
	{
		name       => ITE_STORAGE_TYPE(),
		type       => "enum",
		enum       => "storageType",
		occurrence => $optional,
		instances  => $single,
		default    => Configurator::Enum::StorageType::recordFile(),
		selector   => Configurator::ParameterSet::ITE(),
		usage      => $compileTime,
		related    =>
		[
			ITE_STORAGE_TABLENAMES(),
		],
		description => <<STOP,
Selects the output type for your application.

You can specify `tableFile` to write CSV files, which can be consumed by
another application, for example, to load the content of these CSV files
into a database. Chose this type if you want to create many output files.

You can specify `recordFile` to write an output file for each input
file.

Or, you specify `custom` to implement your own file writer. Implement your
code in the <namespace>.chainsink.custom::FileWriterCustom composite
operator. To activate your code, set this parameter to `custom`. You must
also set the **${\ITE_EMBEDDEDSAMPLECODE()}** parameter to `off`, so the ITE
application uses your implementation instead of the sample logic that is
provided with the <namespace>.chainsink.sample::FileWriterCustom
composite operator.

If you specify the `noFile` option, the ITE application does not write
output files for each input file.
ITE applications that use, for example, variant B or C, can select
this option if <namespace>.context.custom::ContextDataProcessor creates
output files only.
One use case for writing output files in 
<namespace>.context.custom::ContextDataProcessor only,
is that you need to aggregate data across files and the
<namespace>.context.custom::ContextDataProcessor triggers events.
STOP
		postprocess=> sub
		{
			my ($self, $parameter) = @_;
			my $p = $parameter;
			my ($enumValue, $mappedValue) = $self->_get($p->{name}, $p->{type}, $p->{instances}, "force");
			if (defined $enumValue && $enumValue eq Configurator::Enum::StorageType::tableFile())
			{
				# If the storage type is set to tableFile the user must
				# provide table names in the appropriate parameter, too.
				my @subfeatures =
				(
					ITE_STORAGE_TABLENAMES(),
				);
				my $counter = 0;
				foreach my $name (@subfeatures)
				{
					my $dep = $lookup{lc($name)};
					my ($ev, $mv) = $self->_get($dep->{name}, $dep->{type}, $dep->{instances}, "force");
					++$counter if (defined $ev);
				}
				$self->_fail(TedaToolkitResource::TEDA_PARAMETER_REQUIRES_OTHER_CONFIG_PARAMETERS($p->{name}, $enumValue, join(",", @subfeatures))) if (0 == $counter);
			}
		}
	},
);

# -----------------------------------------------------------------------------
# The constants that depend on enabled or disabled sample code.
# -----------------------------------------------------------------------------
my %constants =
(
);

# Remove whitespaces from both ends of a string.
sub trim
{
	my $s = shift;
	return unless (defined $s);
	$s =~ s/^\s+|\s+$//g;
	return $s;
}

# -----------------------------------------------------------------------------
# Create a new instance of the Configurator class. Load and validate the
# configuration that is loaded using the Configurator::Loader Perl module.
# -----------------------------------------------------------------------------
sub new()
{
	my ($class, %args) = @_;

	# Create the class instance.
	my $self =
	{
	};
	bless $self, $class;

	# Evaluate further arguments.
	my ($cwd, $cfgfile, $selector, $warnings) = ($args{directory}, $args{file}, $args{selector}, $args{warnings});
	$self->{selector} = $selector or die TedaToolkitResource::TEDA_MISSING_MODULE_INPUT("selector") . "\n";
	$self->{warnings} = $warnings;

	# Use the Configurator::Loader Perl module to access the configuration file.
	my %loaderArgs = ( ignoreCase => 1 );
	$loaderArgs{directory} = $cwd if (defined $cwd);
	$loaderArgs{file} = $cfgfile if (defined $cfgfile);
	my $cfg = new Configurator::Loader(%loaderArgs);
	$self->{cfg} = $cfg;

	# Validate parameter definitions i.e. verify that the parameter definitions
	# are correct and add further data, for example the parent link.
	$self->_validateParameterDefinitionDefinitions();

	# Store configuration values.
	$self->_store();
	
	# Validate stored values.
	$self->_validateValues();

	# Print warnings for parameters that are in the configuration file,
	# but that are not used.
	if ($self->{warnings})
	{
		my @unknownParametersInConfigurationFile = grep { ! exists $lookup{lc($_)} } $cfg->keys();
		SPL::CodeGen::warnln(TedaToolkitResource::TEDA_UNKNOWN_PARAMETERS_IN_CONFIGURATION_FILE(join(",", @unknownParametersInConfigurationFile)))
			if (scalar @unknownParametersInConfigurationFile);
	}

	return $self;
}

sub _fail($)
{
	my ($self, $message) = @_;
	my @messages = ( $message );
	$self->_abortOnFailures(\@messages);
}

# -----------------------------------------------------------------------------
# If one ore more error messages are collected, abort.
# @param messages The list of error messages.
# -----------------------------------------------------------------------------
sub _abortOnFailures($)
{
	my ($self, $messages) = @_;
	if (scalar @{$messages} > 0)
	{
		SPL::CodeGen::errorln($_) foreach(@{$messages});
		SPL::CodeGen::exitln(TedaToolkitResource::TEDA_BAD_CONFIGURATION());
	}
}

# -----------------------------------------------------------------------------
# Validate the stored values. This includes resetting or disabling parameters
# that are, for example switched off by another parameter.
# -----------------------------------------------------------------------------
sub _validateValues()
{
	my ( $self ) = @_;
	my @messages;
	
	# Validate all stored values for the active parameters.
	foreach my $parameter ( values %lookup )
	{
		if (exists $parameter->{value})
		{
			foreach (@{$self->_validateValue($parameter, "value")})
			{
				push @messages, $_;
			}
		}
	}

	# Print collected messages and abort if there are messages.
	$self->_abortOnFailures(\@messages);

	# Switch off (disable) child parameters for the active parameters.
	foreach my $parameter ( values %lookup )
	{
		# If a switch parameter (enum: switch) is off and has children,
		# disable all children.
		my $name = $parameter->{name};
		if ($parameter->{type} eq "enum" && $parameter->{enum} eq "switch" && exists $parameter->{children})
		{
			my ($key, $value) = $self->_get($parameter->{name}, $parameter->{type}, $parameter->{instances}, "force");
			if (defined $key && $key eq "off")
			{
				foreach my $child (@{$parameter->{children}})
				{
					$self->_disable($parameter, $lookup{lc($child)});
				}
			}
		}
		
		# If a special disabling method is provided, call it.
		if (exists $parameter->{postprocess})
		{
			$parameter->{postprocess}->($self, $parameter);
		}
	}

}

# -----------------------------------------------------------------------------
# Read the parameter values using the Configurator::Loader and store them in
# the Configurator parameters.
# -----------------------------------------------------------------------------
sub _storeParameterValue($)
{
	my ( $self, %arguments ) = @_;
	my $parameter = $arguments{parameter};
	my @messages;
	
	# Save existing values.
	my $cfg = $self->{cfg};
	my $name = $parameter->{name};
	if ($cfg->hasParam($name))
	{
		my $value = $cfg->get($name);
		$value = $parameter->{empty} if (defined $value && $value eq "" && exists $parameter->{empty});
		my $t = $parameter->{type};
		if ($parameter->{instances} == $single)
		{
			if (exists $parameter->{value})
			{
				push @messages, TedaToolkitResource::TEDA_PARAMETER_TOO_MANY_VALUES($name, join(",", @{$parameter->{value}}, $value));
			}
			else
			{
				$value = trim($value);
				$parameter->{value} = $value;
			}
		}
		else # $multiple
		{
			if (defined $value)
			{
				my @values = split(',', $value);
				foreach (@values)
				{
					$_ = trim($_);
				}
				if (exists $parameter->{value})
				{
					foreach(@values)
					{
						push @{$parameter->{value}}, $_;
					}
				}
				else
				{
					$parameter->{value} = \@values;
				}
			}
			else
			{
				if (exists $parameter->{value})
				{
					die TedaToolkitResource::TEDA_UNSUPPORTED_APPEND($name)."\n";
				}
				else
				{
					$parameter->{value} = undef;
				}
			}
		}
	}
	return \@messages;
}

# -----------------------------------------------------------------------------
# Read the parameter values using the Configuration Perl module and store them
# in the Configurator parameters. For some parameters a special handling is
# required.
# -----------------------------------------------------------------------------
sub _store()
{
	my ( $self ) = @_;
	my @messages;
	
	# Save existing values.
	foreach my $parameter ( values %lookup )
	{
		$self->_storeParameterValue(parameter => $parameter);
	}

	# Print collected messages and abort if there are messages.
	$self->_abortOnFailures(\@messages);
}

# -----------------------------------------------------------------------------
# Validate the parameter definitions.
# -----------------------------------------------------------------------------
sub _validateParameterDefinitionDefinitions()
{
	my ( $self ) = @_;
	my @messages;
	my %uniques;

	# Verify each parameter item.
	my $index = 0;
	foreach my $parameter ( @parameters )
	{
		# The parameter name must exist.
		if (exists $parameter->{name} && exists $parameter->{selector} && exists $parameter->{usage})
		{
			# The lower-case id must exist once only.
			my $name = $parameter->{name};
			my $id = lc($name);
			if (exists $uniques{$id})
			{
				push @messages, TedaToolkitResource::TEDA_FATAL_PARAMETER_ALREADY_DEFINED($name, $lookup{$id}->{name});
			}
			else
			{
				# Store id in the uniques hash.
				$uniques{$id} = $parameter;
				
				# Store id in lookup hash if the right selector is set and if it is a compile-time parameter.
				$lookup{$id} = $parameter if ($self->{selector} & $parameter->{selector} && $parameter->{usage} & $compileTime);
				
				# Validate the parameter definition.
				foreach (@{$self->_validateParameterDefinition($parameter)})
				{
					push @messages, $_;
				}
			}
		}
		else
		{
			push @messages, TedaToolkitResource::TEDA_FATAL_INVALID_PARAMETER_DEFINTION($index);
		}
		++$index;
	}

	# Set the parent relations. The lookup hash is built above.
	foreach my $parameter ( @parameters )
	{
		if ( exists $parameter->{children} )
		{
			my $name = $parameter->{name};
			foreach my $child ( @{ $parameter->{children} } )
			{
				my $id = lc($child);
				if (exists $uniques{$id})
				{
					my $p = $uniques{$id};
					if ( exists $p->{parent} )
					{
						push @messages, TedaToolkitResource::TEDA_FATAL_PARAMETER_PARENT_ALREADY_EXISTS($name, $child, $p->{parent});
					}
					else
					{
						$p->{parent} = $name;
					}
				}
				else
				{
					push @messages, TedaToolkitResource::TEDA_FATAL_PARAMETER_CHILD_DOES_NOT_EXIST($name, $child);
				}
			}
		}
	}

	# Print collected messages and abort if there are messages.
	$self->_abortOnFailures(\@messages);
}

# -----------------------------------------------------------------------------
# Validate a parameter definition.
# -----------------------------------------------------------------------------
sub _validateParameterDefinition($)
{
	my ( $self, $parameter ) = @_;
	my @messages;
	my $name = $parameter->{name};

	# The type, occurrence and instances properties must exist.
	my %propertyValues =
	(
		"type" => { map { $_ => $_ } ( "string", "enum", "integer", "float" ) },
		"occurrence" => { $optional => "optional", $mandatory => "mandatory" },
		"instances" => { $single => "single", $multiple => "multiple" },
	);
	foreach my $property (keys %propertyValues)
	{
		push @messages, TedaToolkitResource::TEDA_FATAL_PARAMETER_MISSING_PROPERTY($name, $property)
			unless (defined $parameter->{$property});
	}
	return \@messages if (scalar @messages > 0);

	# The type, occurrence and instances properties must have valid values.
	foreach my $property (keys %propertyValues)
	{
		my $values = $propertyValues{$property};
		push @messages, TedaToolkitResource::TEDA_FATAL_PARAMETER_INVALID_PROPERTY($name, $property, join(", ", values %{$values}))
			unless (exists $values->{$parameter->{$property}});
	}
	return \@messages if (scalar @messages > 0);
	
	my $type = $parameter->{type};
	
	# If a parameter is mandatory, it must not have a default value.
	if ($parameter->{occurrence} == $mandatory && defined $parameter->{default})
	{
		push @messages, TedaToolkitResource::TEDA_FATAL_MANDATORY_PARAMETER_HAS_DEFAULT($name);
	}
	return \@messages if (scalar @messages > 0);

	# Parameters must fit to their types.
	my %typeParameters =
	(
		"enum"  => { map { $_ => undef } ( "enum" ) },
		"max"   => { map { $_ => undef } ( "integer", "float" ) },
		"min"   => { map { $_ => undef } ( "integer", "float" ) },
		"regex" => { map { $_ => undef } ( "string" ) },
	);
	foreach my $key (keys %{$parameter})
	{
		if (exists $typeParameters{$key} && ! exists $typeParameters{$key}->{$type})
		{
			push @messages, TedaToolkitResource::TEDA_FATAL_PARAMETER_UNNEEDED_PROPERTY($name, $key, $type)
		}
	}

	# Mandatory type-dependend parameters must exist.
	my %mandatoryParameters =
	(
		"enum"    => [ "enum" ],
		"string"  => [ ],
		"float"   => [ ],
		"integer" => [ ],
	);
	foreach my $key (@{$mandatoryParameters{$type}})
	{
		unless (exists $parameter->{$key})
		{
			push @messages, TedaToolkitResource::TEDA_FATAL_PARAMETER_MISSING_PROPERTY($name, $key);
		}
	}

	return \@messages if (scalar @messages > 0);
	
	# If the type is an enum, the corresponding enumeration must exist.
	if ($type eq "enum")
	{
		my $enum = $parameter->{enum};
		unless (exists $enumerations{$enum})
		{
			push @messages, TedaToolkitResource::TEDA_FATAL_PARAMETER_ENUM_NOT_DEFINED($name, $enum);
		}
	}
	
	# Validate the optional default, min and max value.
	if (exists $parameter->{default})
	{
		foreach (@{$self->_validateValue($parameter, "default")})
		{
			push @messages, $_;
		}
	}
	if (exists $parameter->{min})
	{
		foreach (@{$self->_validateValue($parameter, "min")})
		{
			push @messages, $_;
		}
	}
	if (exists $parameter->{max})
	{
		foreach (@{$self->_validateValue($parameter, "max")})
		{
			push @messages, $_;
		}
	}
	return \@messages if (scalar @messages > 0);
	return \@messages;
}

# -----------------------------------------------------------------------------
# Validate a property.
# -----------------------------------------------------------------------------
sub _validateValue($$$)
{
	my ( $self, $parameter, $item, $value ) = @_;
	$item = "value" unless (defined $item);

	my @messages;

	my $name = $parameter->{name};
	my $type = $parameter->{type};
	$value = $parameter->{$item} unless (defined $value);

	if (ref($value) eq "ARRAY")
	{
		foreach(@{$value})
		{
			foreach (@{$self->_validateValue($parameter, $item, $_)})
			{
				push @messages, $_;
			}
		}
	}
	elsif ($type eq "string")
	{
		my $regex = $parameter->{regex};
		if (defined $value && defined $regex && $value !~ m/^(?:$regex)$/)
		{
			push @messages, ($item eq "value" ? TedaToolkitResource::TEDA_PARAMETER_INVALID_STRING_VALUE($name, $value, $regex) : TedaToolkitResource::TEDA_FATAL_PARAMETER_INVALID_STRING_DEFAULT($name, $value, $regex));
		}
	}

	elsif ($type eq "enum")
	{
		my $enum = $parameter->{enum};
		if (defined $value && defined $enum && !exists $enumerations{$enum}->{lc($value)})
		{
			my @allowed = sort map { $_->{key} } values %{$enumerations{$enum}};
			my $text = join(", ", @allowed);
			push @messages, ($item eq "value" ? TedaToolkitResource::TEDA_PARAMETER_INVALID_ENUM_VALUE($name, $value, $text) : TedaToolkitResource::TEDA_FATAL_PARAMETER_INVALID_ENUM_DEFAULT($name, $value, $text));
		}
	}

	elsif ($type eq "integer" || $type eq "float")
	{
		my $min = $parameter->{min};
		my $max = $parameter->{max};
		if (defined $value)
		{
			if (!looks_like_number($value))
			{
				push @messages, ($item eq "value" ? TedaToolkitResource::TEDA_PARAMETER_VALUE_NOT_A_NUMBER($name, $value) : TedaToolkitResource::TEDA_FATAL_PARAMETER_PROPERTY_NOT_A_NUMBER($name, $item, $value));
			}
			elsif ($type eq "integer" && $value ne int($value))
			{
				push @messages, ($item eq "value" ? TedaToolkitResource::TEDA_PARAMETER_INVALID_INTEGER_VALUE($name, $value) : TedaToolkitResource::TEDA_FATAL_PARAMETER_INVALID_INTEGER_PROPERTY($name, $item, $value));
			}
			elsif (defined $min && $value < $min)
			{
				push @messages, ($item eq "value" ? TedaToolkitResource::TEDA_PARAMETER_VALUE_LESS_THAN_MIN($name, $value, $min) : TedaToolkitResource::TEDA_FATAL_PARAMETER_PROPERTY_LESS_THAN_MIN($name, $item, $value, $min));
			}
			elsif (defined $max && $value > $max)
			{
				push @messages, ($item eq "value" ? TedaToolkitResource::TEDA_PARAMETER_VALUE_GREATER_THAN_MIN($name, $value, $max) : TedaToolkitResource::TEDA_FATAL_PARAMETER_PROPERTY_GREATER_THAN_MIN($name, $item, $value, $max));
			}
		}
	}

	return \@messages;
}

# -----------------------------------------------------------------------------
# Get the installed and active Streams version.
# -----------------------------------------------------------------------------
sub getStreamsVersion()
{
	return substr(`$ST version | grep Version`, 8, 1,);
}

# -----------------------------------------------------------------------------
# Get the parameters and their current values as map.
# @param parameterName The parameter name.
# -----------------------------------------------------------------------------
sub getParameters()
{
	my ($self) = @_;
	my %result;
	foreach my $p (values %lookup)
	{
		my $name = $p->{name};
		my ($key, $value) = $self->_get($name);
		$result{$name} = $key;
	}
	return %result;
}

# -----------------------------------------------------------------------------
# Get parameter from parameter name
# @param parameterName The parameter name.
# -----------------------------------------------------------------------------
sub _getParameter
{
	my ( $self, $parameterName ) = @_;
	return $lookup{lc($parameterName)};
}


# -----------------------------------------------------------------------------
# Get either the parameter value and signal if it is its default value.
# @param parameter The parameter structure.
# -----------------------------------------------------------------------------
sub _getParameterValue($)
{
	my ( $self, $parameter ) = @_;
	
	if( exists $parameter->{value} )
	{
		return ( $parameter->{value}, 0 );
	}
	else
	{
		if($parameter->{occurrence} == $optional && exists $parameter->{default})
		{
			return ( $parameter->{default}, 1 );
		}
		else
		{
			return ( undef, undef );
		}
	}
}

# -----------------------------------------------------------------------------
# Get either the parameter value or its default.
# @param parameterName The parameter name.
# -----------------------------------------------------------------------------
sub _get($$$$)
{
	my ( $self, $parameterName, $type, $instances, $force ) = @_;
	
	my $parameter = $self->_getParameter($parameterName);

	$type or $type = $parameter->{type};
	$instances or $instances = $parameter->{instances};

	$self->_fail(TedaToolkitResource::TEDA_PARAMETER_UNKNOWN($parameterName))
		unless ( defined $parameter );
	$self->_fail(TedaToolkitResource::TEDA_PARAMETER_WRONG_TYPE($parameterName, $type))
		unless ( $parameter->{type} eq $type );
	unless ( $parameter->{instances} eq $instances)
	{
		$self->_fail(TedaToolkitResource::TEDA_PARAMETER_IS_NOT_SINGLE_VALUE($parameterName))
			if ($instances == $single);
		$self->_fail(TedaToolkitResource::TEDA_PARAMETER_IS_NOT_LIST_VALUE($parameterName))
			if ($instances == $multiple);
	}

	my ($value, $isDefaultValue)
		= (exists $parameter->{disabled} && !defined $force) ? (undef,undef) : ($self->_getParameterValue($parameter));

	print STDERR sprintf("get(%s,%s,%s)->%s\n",
		$parameterName, $type, ($instances == $single ? "single" : "multiple"),
		(defined $value
			? ($instances == $single ? $value : "[" . join(",", @{$value})) . "]"
			: "undef"
		)
	) if ($debug);

	return unless (defined $value);
	if ($type eq "enum")
	{
		if ($instances == $single)
		{
			return
			(
				$enumerations{$parameter->{enum}}->{lc($value)}->{name},
				$enumerations{$parameter->{enum}}->{lc($value)}->{value}
			);
		}
		else
		{
			my @keys;
			my @values;
			foreach my $v (@{$value})
			{
				push @keys, $enumerations{$parameter->{enum}}->{lc($v)}->{name};
				push @values, $enumerations{$parameter->{enum}}->{lc($v)}->{value};
			}
			return (\@keys, \@values);
		}
	}
	return $value;
}

sub _getEnumName($$)
{
	my ( $self, $parameter, $value ) = @_;
	return $enumerations{$parameter->{enum}}->{lc($value)}->{name};
}

sub isEqual($$)
{
	my ( $self, $parameterName, $value ) = @_;
	
	my $name = lc($parameterName);
	my $parameter = $lookup{$name};

	$self->_fail(TedaToolkitResource::TEDA_PARAMETER_UNKNOWN($parameterName))
		unless ( defined $parameter );
	$self->_fail(TedaToolkitResource::TEDA_PARAMETER_IS_NOT_SINGLE_VALUE($parameterName))
		unless ( $parameter->{instances} eq $single);

	my $type = $parameter->{type};

	# Ensure that the passed value is valid.
	my @messages = @{$self->_validateValue($parameter, "value", $value)};
	$self->_abortOnFailures(\@messages);
	
	$value = $self->_getEnumName($parameter, $value) if ($type eq "enum");
	
	# Get the configured value. Expect 2 values for enumerations, else 1 value.
	my ($cfg, $v) = $self->_get($parameterName, $type, $single);
	# not required: $cfg = $self->_getEnumName($parameter, $cfg) if ($type eq "enum");
	
	# Compare the passed and the configured value.
	my $result = (defined $cfg && ($cfg eq $value));
	print STDERR sprintf("%s::isEqual(value=%s)[cfg=%s] -> %s\n", $parameterName, $value, (defined $cfg ? $cfg : "undef"), ($result ? "true" : "false")) if ($debug);
	return $result;
}

sub isNotEqual($$)
{
	my ( $self, $parameterName, $value ) = @_;
	return ! $self->isEqual($parameterName, $value);
}

# -----------------------------------------------------------------------------
# Get the enumeration value and its mapped value for an enumeration parameter.
# @param parameterName The parameter name.
# @return Array of enumeration and mapped values, for example [off,0].
# -----------------------------------------------------------------------------
sub getEnum($)
{
	my ( $self, $parameterName ) = @_;
	return ($self->_get($parameterName, "enum", $single));
}

# -----------------------------------------------------------------------------
# Get the enumeration values and its mapped value for an enumeration parameter.
# @param parameterName The parameter name.
# @return Array of enumeration and mapped values, for example [off,0].
# -----------------------------------------------------------------------------
sub getEnumList($)
{
	my ( $self, $parameterName ) = @_;
	return ($self->_get($parameterName, "enum", $multiple));
}

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
sub isOn($)
{
	my ( $self, $parameterName ) = @_;
	my $result = ($self->getEnum($parameterName))[1];
	if (defined $result && $lookup{lc($parameterName)}->{enum} ne "switch")
	{
		$self->_fail(TedaToolkitResource::TEDA_PARAMETER_WRONG_ENUM($parameterName, "switch"));
	}
	return unless defined $result;
	return $result;
}

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
sub isOff($)
{
	my ( $self, $parameterName ) = @_;
	my $result = $self->isOn($parameterName);
	return unless defined $result;
	return (0 == $result ? 1 : 0);
}

sub getInteger($)
{
	my ( $self, $parameterName ) = @_;
	return $self->_get($parameterName, "integer", $single);
}

sub getIntegerList($)
{
	my ( $self, $parameterName ) = @_;
	return $self->_get($parameterName, "integer", $multiple);
}

sub getFloat($)
{
	my ( $self, $parameterName ) = @_;
	return $self->_get($parameterName, "float", $single);
}

sub getFloatList($)
{
	my ( $self, $parameterName ) = @_;
	return $self->_get($parameterName, "float", $multiple);
}

sub getString($)
{
	my ( $self, $parameterName ) = @_;
	return $self->_get($parameterName, "string", $single);
}

sub getStringList($)
{
	my ( $self, $parameterName ) = @_;
	return $self->_get($parameterName, "string", $multiple);
}

sub getRegularExpression($)
{
	my ( $self, $parameterName ) = @_;
	my $tmp = $self->getString($parameterName);
	return unless (defined $tmp);
	return $self->_escape($tmp);
}

sub getRegularExpressionList($)
{
	my ( $self, $parameterName ) = @_;
	my $tmp = $self->getStringList($parameterName);
	return unless (defined $tmp);
	return $self->_escape($tmp);
}

sub getTimeToKeepSeconds($)
{
	my ( $self, $parameterName) = @_;
	my $tmp = $self->getRegularExpression($parameterName);
	return unless (defined $tmp);
	# convert to seconds
	my $days=0; my $hours=0; my $minutes=0; my $seconds = 0;
	($days, $hours, $minutes) = ($tmp =~ /$regex_timeToKeep/);	
	$seconds = ((substr($days, 0, -1)) * 24 * 60 * 60) if defined($days);
	$seconds += ((substr($hours, 0, -1)) * 60 * 60) if defined($hours);
	$seconds += ((substr($minutes, 0, -1)) * 60) if defined($minutes);
	return $seconds;
}

# Get the arguments for an SPL getSubmissionTimeValue() call.
#
# If the configured compile-time value is defined, the getSubmissionTimeValue()
# call gets the parameter name and the configured compile-time value as
# arguments. If the compile-time value is not present then only the parameter
# name is used as argument.
#
# The user can provide a mapping that is applied, for example "on" is mapped
# to "true" and "off" to "false". Or the user specifies 'auto'. In this case,
# if the parameter is an enumertion the enumeration mapping is used.
#
# For example:
# mapping => { 1 => 2, 2 => 3 }
# mapping => 'auto'
sub getSubmissionTimeValueArguments
{
	my ( $self, $parameterName, %arguments ) = @_;
	my $parameter = $lookup{lc($parameterName)};

	my %mappedValue;
	if (defined $arguments{mapping})
	{
		my $t = reftype($arguments{mapping});
		if (defined $t && $t eq 'HASH')
		{
			%mappedValue =  %{$arguments{mapping}};
		}
		elsif (lc($arguments{mapping}) eq 'auto')
		{
			if (exists $parameter->{enum})
			{
				%mappedValue = map { $_->{key} => $_->{value} } values %{$enumerations{$parameter->{enum}}};
			}
		}
	}

	# The name as string.
	my $result = sprintf("\"%s\"", $parameterName);

	# If a value is provided (user-provided or default), add it as default.
	# Else, the submission-time value has no default and is mandatory.
	# Except for some special cases.
	my ($keys, $values) = $self->_get($parameterName, $parameter->{type}, $parameter->{instances});
	if (defined $keys)
	{
		my $t = reftype($keys);
		if (defined $t && $t eq 'ARRAY')
		{
			if (scalar @{$keys} > 0)
			{
				my @values = map { $mappedValue{$_} or $_ } @{$keys};
				$result .= sprintf(", \"%s\"", join(",", @values));
			}
			# An empty default must be kept except it is overridden.
			elsif (! exists $parameter->{value} && exists $parameter->{default})
			{
				$result .= ", \"\"";
			}
		}
		else
		{
			$keys = $mappedValue{$keys} if (exists $mappedValue{$keys});
			$result .= sprintf(", \"%s\"", $keys);
		}
	}

	return $result;
}

sub _escape($)
{
	my ( $self, $strings ) = @_;
	my $t = reftype($strings);
	if (!defined $t)
	{
		my $result = $strings;
		$result =~ s/\\/\\\\/g;
		return $result;
	}
	elsif ($t eq 'ARRAY')
	{
		my @result;
		foreach (@{$strings})
		{
			s/\\/\\\\/g;
			push @result, $_;
		}
		return \@result;
	}
	else
	{
		die "_escape: " . TedaToolkitResource::TEDA_UNSUPPORTED_VARIABLE($strings)."\n";
	}
}

sub getConstant($)
{
	my ($self, $name) = @_;
	my $constant = $constants{$name};
	my $p = $lookup{lc($constant->{parameter})};
	die "getConstant($name): " . TedaToolkitResource::TEDA_UNKNOWN_CONSTANT($name) . "\n" unless (defined $p);
	my ($key, $value) = $self->_get($p->{name}, $p->{type}, $p->{instances}, "force");
	die "getConstant($name): " . TEDA_INVALID_PARAMETER_VALUE($key, $p->{name}) . "\n"  unless (defined $constant->{$key});
	print STDERR "getConstant($name): " . $constant->{$key} . "\n" if ($debug);
	return $constant->{$key};
}

# SPLDOC markup must be escaped if it occurs in the string of valid values.
# SPLDOC markup characters are: * # { } [ ] \
sub escapeSPLDOCMarkup($)
{
	my ($value) = @_;
	$value =~ s/([*#{}\[\]\\])/\\$1/g;
	return $value;
}

sub outputSPLDOC()
{
	my @documentation = ("");
	# Get all parameter names and sort them.
	my %lookup = map { $_->{name} => $_ } @parameters;
	# Some lookup hashes.
	my %lookupInstances =
	(
		$optional  => { $single => "0..1", $multiple => "0..n" },
		$mandatory => { $single => "1", $multiple => "1..n" },
	);
	# Set the parent and sibling relations.
	my %access = map { $_->{name} => $_ } @parameters;
	foreach my $parameter ( grep { exists $_->{children} } @parameters )
	{
		foreach my $child ( @{ $parameter->{children} } )
		{
			# Parent
			$access{$child}->{parent} = $parameter->{name};
			# Siblings
			foreach my $sibling ( @{ $parameter->{children} } )
			{
				if ($sibling ne $child)
				{
					$access{$sibling}->{siblings} = () unless (exists $access{$sibling}->{siblings});
					push @{$access{$sibling}->{siblings}}, $child unless ((grep { $_ eq $child } @{$access{$sibling}->{siblings}}) > 0);
				}
			}
		}
	}
	# Introduction
	push @documentation, <<STOP;
The following Lookup Manager and ITE application parameters enable, disable,
and configure application features to suit your needs.

These parameters have the following properties:

* **Type**

  Parameters can be integer, float, string, or [http://en.wikipedia.org/wiki/Enumerated_type|enum]
  type. The integer and float types are for numeric values.

* **Default**

  An optional parameter that can have a default value that is used if the
  parameter is omitted in the configuration file.

* **Cardinality**

  Specifies how many values are allowed for a parameter for compile time.

  0..1 means that the parameter is optional and can take only one value.

  0..n means that the parameter is optional and can take multiple
  comma-separated values.

  1 means that the parameter is mandatory and can take only one value.

  1..n means that the parameter is mandatory and can take multiple
  comma-separated values.

* **Application scope**

  Specifies which application (Lookup Manager, ITE application, or both)
  evaluates the parameter.

* **Provisioning time**

  Specifies whether the application evaluates the parameter during compile
  time, submission time, or both.

  Normally, if the compile time parameter is not provided or if a default is
  overridden with an empty value, the submission-time parameter is mandatory.
  Otherwise, the compile-time parameter is used as a default for the
  submission-time parameter.

* **Valid values**

  For enumerations, the list of supported named values is provided. The named
  values are case-insensitive, which means that you can specify, for example,
  `ite.embeddedSampleCode=off` or `ite.embeddedSampleCode=OFF`.

  For numeric values, you can provide a value that fits to the constraint. For
  example, a constraint might be >=1 (global.multihost.numberOfHosts). If you
  provide a value that is >= 1, your value is accepted. If you provide 0 or a
  negative value, you see an error message.

  For string values, you can provide a value that matches the Perl
  [http://en.wikipedia.org/wiki/Regular_expression|regular expression]. For
  example, the description of **ite.cleanup.schedule.minute** shows the
  ((\\[1-5\\]?\\[0-9\\]-)?\\[1-5\\]?\\[0-9\\]) regular expression. You must provide
  a value that matches this regular expression, for example, `9-59` or `10`.

* **Related parameters**

  Some parameters are related to others. For example, a parameter that can be
  switched on and off may have sub-parameters. If the parameter is switched off,
  sub-parameters are inactive. Or, if a parameter has a certain value, it may
  require that another parameter is either not present or also has a certain
  value.

* **Details**

  For some parameters, technical details are provided. For example, a parameter
  enables customized code that is stored in a certain composite operator, or
  administrative actions are required.

**Note:** In this topic, <namespace> is the namespace of the application. This
namespace was specified when you create an application project with the wizard
or the **teda-create-project** script.
STOP
	# Collect for each parameter all relevant information and print it.
	push @documentation, "";
	foreach my $name (sort keys %lookup)
	{
		my $p = $lookup{$name};

		# ---------------------------------------------------------------------
		# <Parameter Name as Headline>
		#
		# <High Level Description>
		#
		# **Properties**
		#
		# Type: <...>
		# Cardinality: <...>
		#
		# Technical Details
		#
		# <Technical Details Description>
		# ---------------------------------------------------------------------
		my $title = "";
		if (exists $p->{deprecated})
		{
			if ($p->{deprecated} == $deprecated) {
				$title = " (DEPRECATED)";
			}
		}
		push @documentation, "# " . $name . $title;
		push @documentation, "";
		
		if (exists $p->{description})
		{
			my $desc = $p->{description};
			while ($desc =~ m/:MARKUP-BEG:(.*?):MARKUP-END:/)
			{
				my $replacement = escapeSPLDOCMarkup($1);
				$desc =~ s/:MARKUP-BEG:(.*?):MARKUP-END:/$replacement/;
			}
			push @documentation, $desc;
			push @documentation, "";
		}

		push @documentation, "**Properties**";
		push @documentation, "";
		
		push @documentation, "Type: " . $p->{type};
		push @documentation, "";
		
		if (exists $p->{default})
		{
			my $default;
			my $source = $p->{default};
			my $quote = ($p->{type} eq "string" ? '"' : '');
			if ($single == $p->{instances})
			{
				$default = escapeSPLDOCMarkup($quote . $source . $quote);
			}
			elsif (scalar @{$source} > 0)
			{
				$default = escapeSPLDOCMarkup(join(", ", map { $quote . $_ . $quote } @{$source}));
			}
			else
			{
				$default = "*empty list*";
			}
			push @documentation, "Default: " . $default;
			push @documentation, "";
		}
		
		push @documentation, "Cardinality: " . $lookupInstances{$p->{occurrence}}{$p->{instances}};
		push @documentation, "";
		
		my @selectors;
		push @selectors, "ITE" if ($p->{selector} & Configurator::ParameterSet::ITE());
		push @selectors, "Lookup Manager" if ($p->{selector} & Configurator::ParameterSet::LookupManager());
		push @documentation, "Application scope: " . join(", ", @selectors);
		push @documentation, "";

		my @usages;
		push @usages, "compile time" if ($p->{usage} & $compileTime);
		push @usages, "submission time" if ($p->{usage} & $submissionTime);
		push @documentation, "Provisioning time: " . join(", ", @usages);
		push @documentation, "";

		my $constraints = "";
		if ($p->{type} eq 'integer' || $p->{type} eq 'float')
		{
			my $formatter = ($p->{type} eq 'float' ? "%f" : "%d");
			if (exists $p->{min})
			{
				my $min = sprintf($formatter, $p->{min});
				$min =~ s/\.?0*$//;
				if (exists $p->{max})
				{
					my $max = sprintf($formatter, $p->{max});
					$max =~ s/\.?0*$//;
					if ($p->{instances} == $multiple)
					{
						$constraints = sprintf("a comma-separated list of %s values from %s to %s, inclusive", $p->{type}, $min, $max);
					}
					else
					{
						$constraints = sprintf("any %s value from %s to %s, inclusive", $p->{type}, $min, $max);
					}
				}
				else
				{
					if ($p->{instances} == $multiple)
					{
						$constraints = sprintf("a comma-separated list of %s values that are equal to or greater than %s", $p->{type}, $min);
					}
					else
					{
						$constraints = sprintf("any %s value that is equal to or greater than %s", $p->{type}, $min);
					}
				}
			}
			else
			{
				if (exists $p->{max})
				{
					my $max = sprintf($formatter, $p->{max});
					$max =~ s/\.?0*$//;
					if ($p->{instances} == $multiple)
					{
						$constraints = sprintf("a comma-separated list of %s values that are less than or equal to %s", $p->{type}, $max);
					}
					else
					{
						$constraints = sprintf("any %s value that is less than or equal to %s", $p->{type}, $max);
					}
				}
				else
				{
					if ($p->{instances} == $multiple)
					{
						$constraints = "a comma-separated list of " . $p->{type} . " values";
					}
					else
					{
						$constraints = "any " . $p->{type} . " value";
					}
				}
			}
		}
		elsif ($p->{type} eq 'string')
		{
			if (exists $p->{regex})
			{
				my $regex = $p->{regex};
				if ($p->{instances} == $multiple)
				{
					$constraints = sprintf("a comma-separated list of values that match the %s regular expression", $regex);
				}
				else
				{
					$constraints = sprintf("any value that matches the %s regular expression", $regex);
				}
			}
			else
			{
				if ($p->{instances} == $multiple)
				{
					$constraints = "a comma-separated list of strings";
				}
				else
				{
					$constraints = "any string";
				}
			}
		}
		elsif ($p->{type} eq 'enum')
		{
			if ($p->{instances} == $multiple)
			{
				$constraints = "a comma-separated list of the following values: ";
			}
			$constraints .= join(", ", sort map { $_->{key} } values %{$enumerations{$p->{enum}}});
		}
		if (defined $constraints)
		{
			push @documentation, "Valid values: " . escapeSPLDOCMarkup($constraints);
			push @documentation, "";
		}

		my $related = 0;
		my @related_parent;
		my @related_children;
		my @related_other;
		if (exists $p->{parent})
		{
			push @related_parent, $p->{parent};
			$related = 1;
		}
		if (exists $p->{children})
		{
			push @related_children, $_ for (@{$p->{children}});
			$related = 1;
		}
		if (exists $p->{siblings})
		{
			push @related_other, $_ for (@{$p->{siblings}});
			$related = 1;
		}
		if (exists $p->{related})
		{
			push @related_other, $_ for (@{$p->{related}});
			$related = 1;
		}
		if ($related)
		{
			push @documentation, "Related parameters:";
			push @documentation, "* Parent: " . join(", ", sort @related_parent) if (scalar @related_parent > 0);
			push @documentation, "* Children: " . join(", ", sort @related_children) if (scalar @related_children > 0);
			push @documentation, "* Other: " . join(", ", sort @related_other) if (scalar @related_other > 0);
			push @documentation, "";
		}

		if (exists $p->{details})
		{		
			push @documentation, "**Details**";
			push @documentation, "";
			push @documentation, $p->{details};
			push @documentation, "";
		}

	}
	return @documentation;
}

sub outputCSV()
{
	my @documentation;
	# Get all parameter names and sort them.
	my %lookup = map { $_->{name} => $_ } @parameters;
	# Some lookup hashes.
	my %lookupInstances =
	(
		$optional  => { $single => "0..1", $multiple => "0..n" },
		$mandatory => { $single => "1", $multiple => "1..n" },
	);
	# Collect for each parameter all relevant information and print it.
	my @headings =
	(
		"name",
		"occurrence",
#		"instances",
		"selector",
		"usage",
		"type",
		"default",
		"constraints",
	);
	print sprintf("%s\n", join(";", @headings));
	foreach my $name (sort keys %lookup)
	{
		my $p = $lookup{$name};

		my @values;
		
		# General information.
		push @values, $name;
#		push @values, ($mandatory == $p->{occurrence} ? "mandatory" : "optional");
		push @values, $lookupInstances{$p->{occurrence}}{$p->{instances}};
		
		my @selectors;
		push @selectors, "ITE" if ($p->{selector} & Configurator::ParameterSet::ITE());
		push @selectors, "LM" if ($p->{selector} & Configurator::ParameterSet::LookupManager());
		push @values, join(",", @selectors);

		my @usages;
		push @usages, "compile-time" if ($p->{usage} & $compileTime);
		push @usages, "submission-time" if ($p->{usage} & $submissionTime);
		push @values, join(",", @usages);

		push @values, $p->{type};
		push @values, (exists $p->{default} ? ($single == $p->{instances} ? $p->{default} : join(",", @{$p->{default}})) : "");
		
		my $constraints;
		if ($p->{type} eq 'integer' || $p->{type} eq 'float')
		{
			if (exists $p->{min})
			{
				if (exists $p->{max})
				{
					$constraints = sprintf("%d..%d", $p->{min}, $p->{max});
				}
				else
				{
					$constraints = sprintf("%d..", $p->{min});
				}
			}
			else
			{
				if (exists $p->{max})
				{
					$constraints = sprintf("..%d", $p->{max});
				}
				else
				{
					$constraints = sprintf("");
				}
			}
		}
		elsif ($p->{type} eq 'string')
		{
			$constraints = (exists $p->{regex} ? $p->{regex} : "");
		}
		elsif ($p->{type} eq 'enum')
		{
			$constraints = join(",", sort map { $_->{name} } values %{$enumerations{$p->{enum}}});
		}
		push @values, $constraints;

		push @documentation, join(";", map { '"' . $_ . '"' } @values);
	}
	
	return @documentation;
}

sub outputCFG($$)
{
	my ($selector, %userConfiguration) = @_;
	my @documentation;
	# Get all parameter names and sort them.
	my %lookup = map { $_->{name} => $_ } @parameters;
	# Some lookup hashes.
	my %lookupInstances =
	(
		$optional  => { $single => "0..1", $multiple => "0..n" },
		$mandatory => { $single => "1", $multiple => "1..n" },
	);
	# Set the parent and sibling relations.
	my %access = map { $_->{name} => $_ } @parameters;
	foreach my $parameter ( grep { exists $_->{children} } @parameters )
	{
		foreach my $child ( @{ $parameter->{children} } )
		{
			# Parent
			$access{$child}->{parent} = $parameter->{name};
			# Siblings
			foreach my $sibling ( @{ $parameter->{children} } )
			{
				if ($sibling ne $child)
				{
					$access{$sibling}->{siblings} = () unless (exists $access{$sibling}->{siblings});
					push @{$access{$sibling}->{siblings}}, $child unless ((grep { $_ eq $child } @{$access{$sibling}->{siblings}}) > 0);
				}
			}
		}
	}
	# Collect for each parameter all relevant information and print it.
	push @documentation, "";
	foreach my $name (sort keys %lookup)
	{
		my $p = $lookup{$name};
		
		# Skip parametes that are not relevant for the selected parameter set.
		next unless ($p->{selector} & $selector);
		# Skip parameters that are relevant for submission time only.
		next if ($p->{usage} == $submissionTime);
		# Skip deprecated parameters
		if (exists $p->{deprecated})
		{
			next if ($p->{deprecated} == $deprecated);
		}
		# ---------------------------------------------------------------------
		# <Parameter Name as Headline>
		#
		# <High Level Description>
		#
		# **Properties**
		#
		# Type: <...>
		# Cardinality: <...>
		#
		# Technical Details
		#
		# <Technical Details Description>
		# ---------------------------------------------------------------------

		my $title = "";
		my $default;
		if (exists $p->{default})
		{	
			my $source = $p->{default};
			my $quote = ($p->{type} eq "string" ? '"' : '');
			if ($single == $p->{instances})
			{
				$default = $quote . $source . $quote;
			}
			elsif (scalar @{$source} > 0)
			{
				$default = join(", ", map { $quote . $_ . $quote } @{$source});
			}
			else
			{
				$default = "*empty list*";
			}
			$title = " (Default: " . $default . ")";
		}

		push @documentation, "# " . '-' x 78;
		push @documentation, "# " . $name . $title;
		push @documentation, "#";
		
		if (exists $p->{description})
		{
			my $text = $p->{description};
			$text =~ s/:MARKUP-(BEG|END)://g;
			$text =~ s/\r//g;
			$text =~ s/(\n)/$1# /g;
			push @documentation, "# " . trim($text);
#			push @documentation, "#";
		}

		push @documentation, "# Properties";
#		push @documentation, "#";
		
		push @documentation, "#    Type: " . $p->{type};
#		push @documentation, "#";
		
		if (exists $p->{default})
		{
			push @documentation, "#    Default: " . $default;
#			push @documentation, "#";
		}
		
		push @documentation, "#    Cardinality: " . $lookupInstances{$p->{occurrence}}{$p->{instances}};
#		push @documentation, "#";
		
#		my @selectors;
#		push @selectors, "ITE" if ($p->{selector} & Configurator::ParameterSet::ITE());
#		push @selectors, "Lookup Manager" if ($p->{selector} & Configurator::ParameterSet::LookupManager());
#		push @documentation, "# Application Scope: " . join(", ", @selectors);
#		push @documentation, "#";

		my @usages;
		push @usages, "compile-time" if ($p->{usage} & $compileTime);
		push @usages, "submission-time" if ($p->{usage} & $submissionTime);
		push @documentation, "#    Provisioning Time: " . join(", ", @usages);
#		push @documentation, "#";

		my $constraints = ($p->{instances} == $multiple ? "comma-separated list of " : "");
		if ($p->{type} eq 'integer' || $p->{type} eq 'float')
		{
			my $formatter = ($p->{type} eq 'float' ? "%f" : "%d");
			if (exists $p->{min})
			{
				my $min = sprintf($formatter, $p->{min});
				$min =~ s/\.?0*$//;
				if (exists $p->{max})
				{
					my $max = sprintf($formatter, $p->{max});
					$max =~ s/\.?0*$//;
					$constraints .= sprintf("any %s value from %s to %s, inclusive", $p->{type}, $min, $max);
				}
				else
				{
					$constraints .= sprintf("any %s value equal to or greater than %d", $p->{type}, $min);
				}
			}
			else
			{
				if (exists $p->{max})
				{
					my $max = sprintf($formatter, $p->{max});
					$max =~ s/\.?0*$//;
					$constraints .= sprintf("any %s value less than or equal to %s", $p->{type}, $max);
				}
				else
				{
					$constraints .= "any " . $p->{type} . " value";
				}
			}
		}
		elsif ($p->{type} eq 'string')
		{
			if (exists $p->{regex})
			{
				my $regex = $p->{regex};
				# SPLDOC markup has to be considered
				$regex =~ s/(\[|\]|\\)/\\$1/g;
				$constraints .= sprintf("any value matching the %s regular expression", $regex);
			}
			else
			{
				$constraints .= "any string";
			}
		}
		elsif ($p->{type} eq 'enum')
		{
			$constraints .= join(", ", sort map { $_->{key} } values %{$enumerations{$p->{enum}}});
		}
		push @documentation, "#    Valid Values: " . $constraints if (defined $constraints);
#		push @documentation, "#";

		my $related = 0;
		my @related_parent;
		my @related_children;
		my @related_other;
		if (exists $p->{parent})
		{
			push @related_parent, $p->{parent};
			$related = 1;
		}
		if (exists $p->{children})
		{
			push @related_children, $_ for (@{$p->{children}});
			$related = 1;
		}
		if (exists $p->{siblings})
		{
			push @related_other, $_ for (@{$p->{siblings}});
			$related = 1;
		}
		if (exists $p->{related})
		{
			push @related_other, $_ for (@{$p->{related}});
			$related = 1;
		}
		if ($related)
		{
			push @documentation, "#    Related Parameters:";
			push @documentation, "#       Parent: " . join(", ", sort @related_parent) if (scalar @related_parent > 0);
			push @documentation, "#       Children: " . join(", ", sort @related_children) if (scalar @related_children > 0);
			push @documentation, "#       Other: " . join(", ", sort @related_other) if (scalar @related_other > 0);
#			push @documentation, "#";
		}

#		if (exists $p->{details})
#		{		
#			push @documentation, "**Details**";
#			push @documentation, "";
#			push @documentation, $p->{details};
#			push @documentation, "";
#		}

		push @documentation, "# " . '-' x 78;
		
		if (exists $userConfiguration{$name})
		{
			my $prefix = (defined $userConfiguration{$name}->{prefix} ? $userConfiguration{$name}->{prefix} : "");
			my $value = (defined $userConfiguration{$name}->{value} ? $userConfiguration{$name}->{value} : "");
			push @documentation, $prefix . $name . '=' . $value;
		}

		push @documentation, "";

	}
	
	return @documentation;
}

package Configurator::Loader;

use strict;
use warnings;
use Cwd;
use File::Spec::Functions qw(canonpath catfile);
use Data::Dumper;

# @param ignoreCase Specifies whether the parameter names are case-sensitive or case-insensitive
# @param directory Specifies the directory. The configuration file is located in directory/config. The default is the current working directory.
# @param file Specifies the name of the configuration file. The complete path is directory/config/file. The default is config.cfg.
sub new()
{
	# Create a class instance.
	my ($class, %args) = @_;
	my $self =
	{
		_config => {},
		_ignoreCase => $args{ignoreCase},
	};
	bless $self, $class;
	# Read the configuration file.
	my $cwd = (defined $args{directory} ? $args{directory} : Cwd::getcwd());
	my $cfgfile = (defined $args{file} ? $args{file} : 'config.cfg');
	my $url = canonpath(catfile($cwd, 'config', $cfgfile)) ;
	open(IN, $url) or SPL::CodeGen::exitln(TedaToolkitResource::TEDA_CANNOT_OPEN_CONFIGURATION_FILE($url, $!));
	my @content = <IN>;
	close(IN);
	# Remove \r and \n (Unix and Windows EOL style)
	foreach(@content)
	{
		s/[\r\n]$//;
	}
	# Grep for all non-comment and non-empty lines.
	@content = grep { ! ( m/^\s*#/ || m/^\s*$/ ) } @content;
	# Grep for for invalid lines.
	my @invalid = grep { ! m/^\s*[^ =]+\s*=/ } @content;
	if (scalar @invalid > 0)
	{
		
		foreach(@invalid)
		{
			SPL::CodeGen::errorln(TedaToolkitResource::TEDA_INVALID_LINE_IN_CONFIGURATION_FILE($url, $_));
		}
		SPL::CodeGen::exitln(TedaToolkitResource::TEDA_BAD_CONFIGURATION());
	}
	# Grep for key=value assignments.
	my @valid = grep { m/^\s*[^ =]+\s*=/ } @content;
	# Store each line.
	foreach(@valid)
	{
		# The equal sign is used as delimiter.
		my $original = $_;
		my @parts = split( '=', $_, 2 );
		my $name = Configurator::trim($parts[0]);
		my $key = ($self->{_ignoreCase} ? lc($name) : $name);
		my $value = $parts[1];
		# Replace environment variable references within the value.
		# The environment variable is provided as $ENV{NAME}.
		if (defined $value)
		{
			while($value =~ m/\$ENV\{([^\}]+)\}/)
			{
				my $envName = $1;
				unless (exists $ENV{$envName})
				{
					SPL::CodeGen::exitln(TedaToolkitResource::TEDA_PARAMETER_USES_UNKNOWN_ENVIRONMENT_VARIABLE($name, $envName, $url, $original));
				}
				$value =~ s/\$ENV\{([^\}]+)\}/$ENV{$envName}/ge;
			}
		}
		# Key must be unique.
		if (exists $self->{_config}->{$key})
		{
			SPL::CodeGen::exitln(TedaToolkitResource::TEDA_PARAMETER_IS_DECLARED_MULTIPLE_TIMES($name, $url));
		}
		# Store it for later use.
		$self->{_config}->{$key} = { name => $name, value => $value, original => $original };
	}
	return $self;
}

sub _get($)
{
	my ($self, $name) = @_;
	my $key = ($self->{_ignoreCase} ? lc($name) : $name);
	return unless (exists $self->{_config}->{$key});
	return $self->{_config}->{$key};
}

sub hasParam($)
{
    my ($self, $name) = @_;
    return (defined $self->_get($name) ? 1 : 0);
}

sub get($)
{
    my ($self, $name) = @_;
    my $p = $self->_get($name);
    return unless (defined $p);
    return $p->{value};
}

sub keys()
{
    my ($self) = @_;
    return keys %{$self->{_config}};	
}

1;
