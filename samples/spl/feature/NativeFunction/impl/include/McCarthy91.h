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
#ifndef MC_CARTHY_91_H_
#define MC_CARTHY_91_H_
// Define SPL types and functions
#include "SPL/Runtime/Function/SPLFunctions.h"

// We are in directory sample/McCarthy. This translates to namespace
// sample.McCarthy in SPL and spl::sample::McCarthy in C++

// All spl parameters are passed by reference. non 'mutable' ones are const
namespace sample {
    namespace McCarthy {
        SPL::uint32 getMcCarthy91_recursive(SPL::uint32 const & m); 
        SPL::uint32 getMcCarthy91_iterative(SPL::uint32 const & m); 

        template<class T>
        T getMcCarthy91_recursive_generic(T const & m)
        {
            if(m>100) 
                return m-10;
            return getMcCarthy91_recursive_generic(
                       getMcCarthy91_recursive_generic(m+11));
        }
    }
}

#endif /* MC_CARTHY_91_H_ */
