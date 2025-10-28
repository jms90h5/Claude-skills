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
# (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2010, 2011     
# All Rights reserved.                                             
#                                                                  
# end_generated_IBM_Teracloud_ApS_copyright_prolog                 
package LinuxPipeCommon;
use strict;
use warnings;

sub verify($) 
{
    my ($model) = @_;
    my $inputPort = $model->getInputPortAt(0);
    my $inTupleType = $inputPort->getCppTupleType();
    my $outputPort0 = $model->getOutputPortAt(0);
    my $outTupleType = $outputPort0->getCppTupleType();
    SPL::CodeGen::exitln("Input port at index 0 should have a single attribute of type 'rstring'", 
                         $inputPort->getSourceLocation())
        if($inputPort->getNumberOfAttributes() != 1 ||
           !SPL::CodeGen::Type::isRString($inputPort->getAttributeAt(0)->getSPLType()));

    SPL::CodeGen::exitln("Output port at index 0 should have a single attribute of type 'rstring'", 
                         $outputPort0->getSourceLocation())
        if($outputPort0->getNumberOfAttributes() != 1 ||
           !SPL::CodeGen::Type::isRString($outputPort0->getAttributeAt(0)->getSPLType()));
    
    if($model->getNumberOfOutputPorts()==2) {
        my $outputPort1 = $model->getOutputPortAt(1);
        my $outTupleType = $outputPort1->getCppTupleType();
        SPL::CodeGen::exitln("Output port at index 1 should have a single attribute of type 'rstring'", 
                             $outputPort1->getSourceLocation())
            if($outputPort1->getNumberOfAttributes() != 1 ||
               !SPL::CodeGen::Type::isRString($outputPort1->getAttributeAt(0)->getSPLType()));        
    }
}

1;
