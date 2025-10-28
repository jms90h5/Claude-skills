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
#ifndef SUDOKU_SOLVER_H_
#define SUDOKU_SOLVER_H_
// Define SPL types and functions
#include <SPL/Runtime/Function/SPLFunctions.h>
#include "sudoku_solver_core.h"
#include <sstream>

// We are in directory sample/sudoku. This translates to namespace
// sample.sudoku in SPL and spl::sample::sudoku in C++
namespace sample { namespace sudoku {

  inline SPL::rstring solve(SPL::rstring const & puzzle, SPL::int32 & error)
  {
      std::istringstream istr(puzzle);
      std::ostringstream ostr;
      board<3> b;
      istr >> b; 
      if(!istr) {
          error = 1;
          return "error: cannot parse puzzle!";
      }
      bool unique = true;
      try {
          unique = b.solve_unique();
      } catch(...) {
          error = 2;
          return "error: cannot solve puzle!";
      }
      if (!unique) {
          error = 3;
          return "error: no-unique solution!";
      }
      ostr << b;
      error = 0;
      return ostr.str();
  }
  inline SPL::rstring format(SPL::rstring const & puzzle, SPL::int32 & error)
  {
      std::istringstream istr(puzzle);
      std::ostringstream ostr;
      board<3> b;
      istr >> b;
      if(!istr) {
          error = 1;
          return "error: cannot parse puzzle!";
      }
      ostr << b;
      error = 0;
      return ostr.str();
  }

} }

#endif /* SUDOKU_SOLVER_H_ */
