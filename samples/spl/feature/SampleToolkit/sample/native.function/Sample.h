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
/* (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2009, 2011     */
/* All Rights reserved.                                             */
/*                                                                  */
/* end_generated_IBM_Teracloud_ApS_copyright_prolog                 */
// Define SPL types and functions
#include "SPL/Runtime/Function/SPLFunctions.h"

// We are in directory sample.  This translates
// to namespace sample in SPL, and
// to namespace sample in C++
//
// All spl parameters are passed by reference. non 'mutable' ones are const
namespace sample {
    // SPL: void incrementBy(mutable list<int32> l, int32 incr);
    // Define this inline just to demonstrate that we could
    void incrementBy(SPL::list<SPL::int32> & l, SPL::int32 const & incr)
    {
        uint32_t num = l.size();
        for (uint32_t i = 0; i < num; i++)
            l[i] += incr;
    }
    
    // SPL: list<int32> joinLists(list<int32> a, list<int32> b)
    SPL::list<SPL::int32> joinLists(SPL::list<SPL::int32> const & a,
                                    SPL::list<SPL::int32> const & b);
}
