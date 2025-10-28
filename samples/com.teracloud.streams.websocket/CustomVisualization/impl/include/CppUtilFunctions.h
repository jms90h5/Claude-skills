/*
==============================================
# Licensed Materials - Property of IBM
# Copyright IBM Corp. 2020
==============================================
*/

/*
============================================================
This file contains commonly used C++ native functions
in the Streams PoC for UAE-RTA.

First created on: Jun/27/2020
Last modified on: Sep/10/2024
============================================================
*/
#ifndef FUNCTIONS_H_
#define FUNCTIONS_H_

// Include this SPL file so that we can use the SPL functions and types in this C++ code.
#include "SPL/Runtime/Function/SPLFunctions.h"
#include <vector>
#include <sstream>
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <dirent.h>
#include <boost/algorithm/string.hpp>
#include <boost/archive/iterators/binary_from_base64.hpp>
#include <boost/archive/iterators/remove_whitespace.hpp>
#include <boost/archive/iterators/transform_width.hpp>
#include <string>

// Define a C++ namespace that will contain our native function code.
namespace cpp_util_functions {
	// By including this line, we will have access to the SPL namespace and anything defined within that.
	using namespace SPL;
	using namespace std;
	using namespace boost::archive::iterators;
	using it_base64_t = binary_from_base64<std::string::const_iterator>;
	using it_whitespace_removed_t = remove_whitespace<it_base64_t>;
	using it_binary_t = transform_width<it_whitespace_removed_t, 8, 6>;	

	// Prototype for our native functions are declared here.
	void base64_decode(rstring & base64, rstring & result);

	// Base64 decode the given string.
    // It assigns the decoded string to the second refernce string argument.
	inline void base64_decode(rstring & base64, rstring & result) {
		// IMPORTANT:
		// For performance reasons, we are not passing a const string to this method.
		// Instead, we are passing a directly modifiable reference. Caller should be aware that
		// the string they passed to this method gets altered during the base64 decoding logic below.
		// After this method returns back to the caller, it is not advisable to use that modified string.
		typedef transform_width< binary_from_base64<remove_whitespace<string::const_iterator> >, 8, 6 > it_binary_t;

		unsigned int paddChars = count(base64.begin(), base64.end(), '=');
		std::replace(base64.begin(),base64.end(),'=','A'); // replace '=' by base64 encoding of '\0'
		result = string(it_binary_t(base64.begin()), it_binary_t(base64.end())); // decode
		result.erase(result.end()-paddChars,result.end());  // erase padding '\0' characters
	}

}
#endif
