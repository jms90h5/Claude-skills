/* begin_generated_IBM_Teracloud_ApS_copyright_prolog               */
/*                                                                  */
/* This is an automatically generated copyright prolog.             */
/* After initializing,  DO NOT MODIFY OR MOVE                       */
/* **************************************************************** */
/* THIS SAMPLE CODE IS PROVIDED ON AN "AS IS" BASIS.                */
/* TERACLOUD APS AND IBM MAKES NO REPRESENTATIONS OR WARRANTIES,    */
/* EXPRESS OR IMPLIED, CONCERNING  USE OF THE SAMPLE CODE, OR THE   */
/* COMPLETENESS OR ACCURACY OF THE SAMPLE CODE. TERACLOUD APS       */
/* AND IBM DOES NOT WARRANT UNINTERRUPTED OR ERROR-FREE OPERATION   */
/* OF THIS SAMPLE CODE. TERACLOUD APS AND IBM IS NOT RESPONSIBLE FOR THE */
/* RESULTS OBTAINED FROM THE USE OF THE SAMPLE CODE OR ANY PORTION  */
/* OF THIS SAMPLE CODE.                                             */
/*                                                                  */
/* LIMITATION OF LIABILITY. IN NO EVENT WILL IBM BE LIABLE TO ANY   */
/* PARTY FOR ANY DIRECT, INDIRECT, SPECIAL OR OTHER CONSEQUENTIAL   */
/* DAMAGES FOR ANY USE OF THIS SAMPLE CODE, THE USE OF CODE FROM    */
/* THIS [ SAMPLE PACKAGE,] INCLUDING, WITHOUT LIMITATION, ANY LOST  */
/* PROFITS, BUSINESS INTERRUPTION, LOSS OF PROGRAMS OR OTHER DATA   */
/* ON YOUR INFORMATION HANDLING SYSTEM OR OTHERWISE.                */
/*                                                                  */
/* (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2010, 2011     */
/* All Rights reserved.                                             */
/*                                                                  */
/* end_generated_IBM_Teracloud_ApS_copyright_prolog                 */
package sample;

import java.io.File;

import com.ibm.streams.operator.AbstractOperator;
import com.ibm.streams.operator.OperatorContext;
import com.ibm.streams.operator.OutputTuple;
import com.ibm.streams.operator.StreamingInput;
import com.ibm.streams.operator.Tuple;
/**
 * Sample Java operator that expects a stream containing
 * system properties and for any incoming tuple with its
 * attribute <code>name</code> listed in the parameter <code>listDirectory</code>
 * the output attribute <code>files</code> is set to the set of files
 * and directories in the directory specified by <code>value</code>. 
 *
 */
public class DirectoryPropertyLister extends AbstractOperator {
    
    /**
     * For each incoming tuple submit an outgoing tuple with
     * matching attributes copied across and files filled in
     * with the contents of the directory specified by <code>value</code>,
     * if <code>name</code> is contained in the parameter <code>listDirectory</code>.
     */
    @Override
    public void process(StreamingInput<Tuple> port, Tuple tuple) throws Exception {
        
        // Create an tuple for the output port and copy all
        // matching attributes from the incoming tuple.
        OutputTuple outTuple = getOutput(0).newTuple();
        outTuple.assign(tuple);
        
        if (getOperatorContext().getParameterValues("listDirectory").contains(
                tuple.getString("name"))){
            
            String directory = tuple.getString("value");
            
            File dir = new File(directory);
            String[] files = dir.list();
            if (files != null)
                outTuple.setObject("files", files);
        }
        
        getOutput(0).submit(outTuple);
    }

}
