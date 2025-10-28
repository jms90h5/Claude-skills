#!/usr/bin/perl -w
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

use strict ;
use Getopt::Long qw(HelpMessage VersionMessage);
use FindBin;
use lib $FindBin::Bin; # include bin directory to @INC
use Configurator;
unshift @INC, (reverse(glob(sprintf("%s/toolkits/com.teracloud.streams.teda*/impl/nl/include", $ENV{STREAMS_INSTALL}))))[0];
require TedaToolkitResource;

my $full = 0;
my $fsep=' ';
my $lsep="\n";
my $selector;

sub help()
{
    print TedaToolkitResource::TEDA_GETCFG_HELP($0);
    exit(0);
}

exit(1) unless GetOptions(
        "d=s" => \$fsep,
        "r=s" => \$lsep,
        "f" => \$full,
        "s=s" => \$selector,
        "help|h|?" => sub { HelpMessage(help()); },
    );

if ($selector eq "LookupManager")
{
	$selector = Configurator::ParameterSet::LookupManager();
}
elsif ($selector eq "ITE")
{
	$selector = Configurator::ParameterSet::ITE();
}
elsif (defined $selector)
{
	die TedaToolkitResource::TEDA_INVALID_SELECTOR($selector) . "\n";
}
else
{
	die TedaToolkitResource::TEDA_UNDEFINED_OPTION("-s") . "\n";
}
  
my $configurator = new Configurator(warnings => 1, selector => $selector);

foreach my $p (@ARGV)
{
	my ($v, $dummy) = $configurator->_get($p);
   	$full and print $p."=";
   	defined $v or next;
   	ref $v eq 'ARRAY' and $v = join($fsep,@{$v});
   	print $v.$lsep;
}
