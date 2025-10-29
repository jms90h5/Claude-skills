---
name: streams-native-function
description: Generate IBM Streams native functions implemented in C++ or Java. Creates function model XML, implementation code, and build files. Use when extending SPL with custom computational functions, mathematical operations, external library integration, or when user mentions native functions, C++/Java functions, or SPL function extensions.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

# Streams Native Function Generator

This skill helps you create IBM Streams native functions - SPL-callable functions implemented in C++ or Java.

## 🚨 CRITICAL: Read CLAUDE.md First

**BEFORE generating any code, consult `/home/streamsadmin/workspace/teracloud/CLAUDE.md` for:**
- ❌ ABSOLUTE PROHIBITION on fake/placeholder/mock code
- ✅ Compilation requirements (ALL code must compile cleanly with no warnings)
- ✅ Testing and verification standards
- ✅ Teracloud Streams specific conventions

**For SPL syntax questions, ALWAYS consult: https://doc.streams.teracloud.com/index.html**

## What this skill does

- Creates native function definitions (function.xml)
- Generates C++ or Java implementation code
- Creates proper namespace structure
- Generates build files (Makefile, build.xml)
- Follows IBM Streams native function development best practices

## Native Functions vs Operators

**Native Functions:**
- Stateless computational functions
- Called within SPL expressions
- Return a value based on inputs
- Cannot access tuples or ports directly
- Examples: math functions, string manipulation, encoding/decoding

**Primitive Operators:**
- Stateful processing units
- Process streams of tuples
- Can have input/output ports
- Maintain state across invocations
- Examples: filters, aggregators, sources, sinks

## Instructions

When the user asks to create a native function:

1. **Determine function type** (C++ or Java)

2. **Ask clarifying questions:**
   - What does the function compute?
   - What are the input/output types?
   - Is it generic (template) or specific?
   - Any external library dependencies?

3. **Generate the function:**
   - Create `native.function/function.xml` (function model)
   - Generate C++/Java implementation files
   - Create build files (Makefile or build.xml)
   - Set up proper namespace structure

4. **Explain the structure:**
   - Describe the namespace mapping
   - Explain SPL to C++/Java type mapping
   - Point out dependency configuration

## Directory Structure

```
ToolkitName/
├── namespace/
│   └── SubNamespace/
│       └── native.function/
│           └── function.xml          # Function model
├── impl/
│   ├── include/
│   │   └── MyFunctions.h            # C++ header
│   ├── src/
│   │   └── MyFunctions.cpp          # C++ implementation
│   ├── java/
│   │   ├── src/
│   │   │   └── com/company/Functions.java
│   │   └── build.xml
│   ├── lib/                          # Compiled libraries
│   │   ├── libMyFunctions.so         # C++ shared library
│   │   └── functions.jar             # Java JAR
│   └── Makefile
```

## C++ Native Function

### Function Model XML (function.xml)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<functionModel
   xmlns="http://www.ibm.com/xmlns/prod/streams/spl/function"
   xmlns:cmn="http://www.ibm.com/xmlns/prod/streams/spl/common"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://www.ibm.com/xmlns/prod/streams/spl/function functionModel.xsd">
  <functionSet>
    <!-- Header file to include from C++ code -->
    <headerFileName>MyFunctions.h</headerFileName>

    <!-- C++ namespace (optional) -->
    <cppNamespaceName>com::company::myfunctions</cppNamespaceName>

    <!-- Function prototypes -->
    <functions>
      <!-- Simple function -->
      <function>
        <description>Computes the square of a number</description>
        <prototype><![CDATA[ public int32 square(int32 x) ]]></prototype>
      </function>

      <!-- Generic (template) function -->
      <function>
        <description>Returns the maximum of two values</description>
        <prototype><![CDATA[ <numeric T> public T maximum(T a, T b) ]]></prototype>
      </function>

      <!-- Multiple parameters -->
      <function>
        <description>Linear interpolation between two values</description>
        <prototype><![CDATA[ public float64 lerp(float64 a, float64 b, float64 t) ]]></prototype>
      </function>
    </functions>

    <!-- Dependencies -->
    <dependencies>
      <library>
        <cmn:description>My Functions Library</cmn:description>
        <cmn:managedLibrary>
          <!-- Library name (used as -lMyFunctions) -->
          <cmn:lib>MyFunctions</cmn:lib>
          <!-- Library path relative to toolkit root -->
          <cmn:libPath>impl/lib</cmn:libPath>
          <!-- Include path relative to toolkit root -->
          <cmn:includePath>impl/include</cmn:includePath>
        </cmn:managedLibrary>
      </library>
    </dependencies>
  </functionSet>
</functionModel>
```

### C++ Header (impl/include/MyFunctions.h)

```cpp
#ifndef MY_FUNCTIONS_H_
#define MY_FUNCTIONS_H_

#include "SPL/Runtime/Function/SPLFunctions.h"

// Namespace must match directory structure:
// namespace/SubNamespace -> namespace::SubNamespace in SPL
//                        -> spl::namespace_::SubNamespace in C++

namespace com {
namespace company {
namespace myfunctions {

    // All SPL parameters are passed by const reference
    // Return types can be by value or reference

    // Simple function
    SPL::int32 square(SPL::int32 const & x);

    // Generic (template) function - implemented in header
    template<class T>
    T maximum(T const & a, T const & b) {
        return (a > b) ? a : b;
    }

    // Multiple parameters
    SPL::float64 lerp(SPL::float64 const & a,
                      SPL::float64 const & b,
                      SPL::float64 const & t);

} // namespace myfunctions
} // namespace company
} // namespace com

#endif /* MY_FUNCTIONS_H_ */
```

### C++ Implementation (impl/src/MyFunctions.cpp)

```cpp
#include "MyFunctions.h"
#include <cmath>

namespace com {
namespace company {
namespace myfunctions {

    using namespace SPL;

    int32 square(int32 const & x) {
        return x * x;
    }

    float64 lerp(float64 const & a,
                 float64 const & b,
                 float64 const & t) {
        return a + t * (b - a);
    }

} // namespace myfunctions
} // namespace company
} // namespace com
```

### Build Makefile (impl/Makefile)

```makefile
STREAMS_INSTALL = $(STREAMS_INSTALL)
STREAMS_INCLUDE = $(STREAMS_INSTALL)/include

CXX = g++
CXXFLAGS = -O3 -Wall -Wextra -std=c++11 -fPIC
CXXFLAGS += -I$(STREAMS_INCLUDE) -I./include

SOURCES = $(wildcard src/*.cpp)
OBJECTS = $(SOURCES:src/%.cpp=lib/%.o)
LIBRARY = lib/libMyFunctions.so

.PHONY: all clean

all: $(LIBRARY)

$(LIBRARY): $(OBJECTS)
	@mkdir -p lib
	$(CXX) -shared -o $@ $^

lib/%.o: src/%.cpp
	@mkdir -p lib
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -rf lib
```

## Java Native Function

### Function Model XML (function.xml)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<functionModel
   xmlns="http://www.ibm.com/xmlns/prod/streams/spl/function"
   xmlns:cmn="http://www.ibm.com/xmlns/prod/streams/spl/common"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://www.ibm.com/xmlns/prod/streams/spl/function functionModel.xsd">
  <functionSet>
    <!-- Generated header for Java JNI -->
    <headerFileName>SPL_JNIFunctions_com_company_myfunctions.h</headerFileName>
    <cppNamespaceName>SPL::JNIFunctions::com::company::myfunctions::SPL_JNIFunctions</cppNamespaceName>

    <functions>
      <function>
        <description>Factorial function</description>
        <prototype><![CDATA[ public int64 factorial(int32 n) ]]></prototype>
        <!-- Fully qualified Java method name -->
        <javaFunctionName>public static long com.company.MathFunctions.factorial(int)</javaFunctionName>
      </function>

      <function>
        <description>String reversal</description>
        <prototype><![CDATA[ public rstring reverse(rstring str) ]]></prototype>
        <javaFunctionName>public static java.lang.String com.company.StringFunctions.reverse(java.lang.String)</javaFunctionName>
      </function>
    </functions>

    <dependencies>
      <library>
        <cmn:description>C++ interface to Java native functions</cmn:description>
        <cmn:managedLibrary>
          <cmn:lib>streams-stdtk-javaop</cmn:lib>
          <cmn:lib>streams-stdtk-runtime</cmn:lib>
          <cmn:includePath>.</cmn:includePath>
        </cmn:managedLibrary>
      </library>
      <library>
        <cmn:description>Java JNI</cmn:description>
        <cmn:managedLibrary>
          <cmn:lib>pthread</cmn:lib>
          <cmn:lib>dl</cmn:lib>
          <cmn:includePath>@JAVA_HOME@/include</cmn:includePath>
          <cmn:includePath>@JAVA_HOME@/include/linux</cmn:includePath>
        </cmn:managedLibrary>
      </library>
    </dependencies>
  </functionSet>
</functionModel>
```

### Java Implementation

```java
package com.company;

public class MathFunctions {

    /**
     * Computes n factorial
     * @param n The input number
     * @return n!
     */
    public static long factorial(int n) {
        if (n <= 1) return 1;
        return n * factorial(n - 1);
    }

    /**
     * Computes the greatest common divisor
     */
    public static int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}
```

### Java Build File (impl/java/build.xml)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project name="MyFunctions" default="all" basedir=".">
    <property name="src" location="src"/>
    <property name="build" location="classes"/>
    <property name="lib" location="../lib"/>
    <property name="jar.file" value="${lib}/myfunctions.jar"/>

    <target name="init">
        <mkdir dir="${build}"/>
        <mkdir dir="${lib}"/>
    </target>

    <target name="all" depends="init">
        <javac srcdir="${src}" destdir="${build}"
               includeantruntime="false"
               debug="true"
               source="1.8" target="1.8"/>
        <jar jarfile="${jar.file}" basedir="${build}"/>
    </target>

    <target name="clean">
        <delete dir="${build}"/>
        <delete file="${jar.file}"/>
    </target>
</project>
```

## Type Mappings

### SPL to C++ Types

| SPL Type | C++ Type | Header |
|----------|----------|---------|
| `int8/16/32/64` | `SPL::int8/16/32/64` | SPL/Runtime/Type/SPLType.h |
| `uint8/16/32/64` | `SPL::uint8/16/32/64` | SPL/Runtime/Type/SPLType.h |
| `float32/64` | `SPL::float32/64` | SPL/Runtime/Type/SPLType.h |
| `boolean` | `SPL::boolean` | SPL/Runtime/Type/SPLType.h |
| `rstring` | `SPL::rstring` | SPL/Runtime/Type/String.h |
| `list<T>` | `SPL::list<T>` | SPL/Runtime/Type/List.h |
| `map<K,V>` | `SPL::map<K,V>` | SPL/Runtime/Type/Map.h |

### SPL to Java Types

| SPL Type | Java Type |
|----------|-----------|
| `int8/16/32` | `int` |
| `int64` | `long` |
| `uint8/16/32/64` | Use signed equivalents |
| `float32` | `float` |
| `float64` | `double` |
| `boolean` | `boolean` |
| `rstring` | `java.lang.String` |
| `list<T>` | `java.util.List<T>` |
| `map<K,V>` | `java.util.Map<K,V>` |

## Namespace Mapping

SPL namespace structure maps to C++ and Java:

```
SPL directory:     com/company/math/native.function/function.xml
SPL namespace:     com.company.math
C++ namespace:     com::company::math  (or spl::com::company::math)
Java package:      com.company.math
```

## Generic (Template) Functions

C++ supports template functions for type-generic operations:

```xml
<!-- In function.xml -->
<function>
  <prototype><![CDATA[ <numeric T> public T abs(T x) ]]></prototype>
</function>
```

```cpp
// In header file
template<class T>
T abs(T const & x) {
    return (x < 0) ? -x : x;
}
```

## Building and Testing

### Build the Native Functions

```bash
cd toolkit/impl
make
```

### Use in SPL

```spl
namespace com.example;

// Import functions from namespace
use com.company.math::*;

composite Main {
    graph
        stream<int32 x> Numbers = Beacon() {
            output Numbers: x = (int32)IterationCount();
        }

        stream<int32 result> Squares = Functor(Numbers) {
            output Squares: result = square(x);  // Call native function
        }
}
```

## Documentation References

### Primary (Local - Can be READ by Claude)
See `/home/streamsadmin/workspace/Claude-skills/streams_docs/`:
- `com.ibm.streams.dev.doc/doc/creatingnativefunctions.html` - Creating native functions
- `com.ibm.streams.dev.doc/doc/nativefunctionartifacts.html` - Native function artifacts
- `com.ibm.streams.dev.doc/doc/cfunctstoolkits.html` - C++ functions in toolkits
- `com.ibm.streams.dev.doc/doc/javanativefuncttoolkits.html` - Java functions in toolkits
- `com.ibm.streams.ref.doc/doc/nativefunctions.html` - Native function reference

### Samples (Local)
See `/home/streamsadmin/workspace/Claude-skills/samples/`:
- `spl/feature/NativeFunction/` - C++ native function example (McCarthy91)
- `spl/feature/JavaOperators/com.ibm.streams.javafunctionsamples.math/` - Java functions
- `com.teracloud.streams.dps/advanced/02_using_no_sql_db_in_spl_custom_operators_and_a_cpp_native_function/` - Real-world example

### Supplementary (Online)
- **Teracloud Streams Docs**: https://doc.streams.teracloud.com/index.html
- Check `/opt/teracloud/streams/7.2.0.1/samples` for official examples

## Best Practices

### From CLAUDE.md (MANDATORY)
1. **NO FAKE CODE EVER**: Never use placeholders, mocks, or dummy implementations
2. **Clean Compilation**: ALL code must compile without warnings (-Wall -Wextra)
3. **Proper Type Casting**: Use static_cast<> for conversions
4. **Verify Functionality**: Test functions with real inputs, document actual outputs
5. **No Shortcuts**: Never comment out functionality to avoid implementation

### Native Function Specific

#### C++ Functions
1. **Pass by const reference**: All parameters are `T const &`
2. **Namespace matching**: C++ namespace must match SPL namespace structure
3. **Template functions**: Implement generic functions in header files
4. **Include guards**: Use proper header guards
5. **SPL types**: Use `SPL::int32`, `SPL::rstring`, etc.
6. **Thread safety**: Functions must be thread-safe (called from multiple threads)
7. **No state**: Functions should be stateless (pure functions)
8. **Error handling**: Throw `SPLRuntimeException` for errors

#### Java Functions
1. **Static methods**: All functions must be `public static`
2. **Fully qualified names**: Use complete package names in function.xml
3. **Type mapping**: Follow SPL to Java type conversions carefully
4. **JAR location**: Place compiled JAR in `impl/lib/`
5. **JNI dependencies**: Include proper JNI libraries in function.xml
6. **Exception handling**: Let exceptions propagate, SPL will catch them

#### Function Model XML
1. **CDATA sections**: Use `<![CDATA[...]]>` for prototypes with `<>`
2. **Library paths**: Use relative paths from toolkit root
3. **Dependencies**: Include all required libraries
4. **Descriptions**: Add clear function descriptions
5. **Validation**: XML must validate against functionModel.xsd

#### Performance
1. **Avoid allocations**: Minimize memory allocation in hot paths
2. **Efficient algorithms**: Use optimal algorithms for computation
3. **Inline small functions**: Mark trivial functions `inline`
4. **Cache results**: Precompute constants, use lookup tables where appropriate

## Common Patterns

### Mathematical Functions

```cpp
namespace math {
    // Trigonometric
    SPL::float64 degrees(SPL::float64 const & radians) {
        return radians * 180.0 / M_PI;
    }

    // Statistical
    SPL::float64 clamp(SPL::float64 const & value,
                       SPL::float64 const & min,
                       SPL::float64 const & max) {
        if (value < min) return min;
        if (value > max) return max;
        return value;
    }
}
```

### String Manipulation

```cpp
namespace strings {
    SPL::rstring toUpper(SPL::rstring const & str) {
        SPL::rstring result = str;
        std::transform(result.begin(), result.end(),
                      result.begin(), ::toupper);
        return result;
    }
}
```

### Encoding/Decoding

```cpp
namespace encoding {
    SPL::rstring base64Encode(SPL::rstring const & data) {
        // Use external base64 library
        return base64::encode(data);
    }

    SPL::rstring base64Decode(SPL::rstring const & encoded) {
        return base64::decode(encoded);
    }
}
```

## Troubleshooting

### Linker Errors
- **Problem**: `undefined reference to function`
- **Solution**: Ensure library is built and path in function.xml is correct

### Type Mismatch
- **Problem**: SPL compiler error about incompatible types
- **Solution**: Verify type mapping between SPL and C++/Java

### Function Not Found
- **Problem**: SPL can't find the function
- **Solution**: Check namespace matches directory structure and function.xml

### Java ClassNotFoundException
- **Problem**: Runtime error loading Java class
- **Solution**: Ensure JAR is in `impl/lib/` and included in classpath

## Advanced Topics

### Using External Libraries

```xml
<dependencies>
  <library>
    <cmn:description>Boost libraries</cmn:description>
    <cmn:managedLibrary>
      <cmn:lib>boost_regex</cmn:lib>
      <cmn:libPath>/usr/lib/x86_64-linux-gnu</cmn:libPath>
      <cmn:includePath>/usr/include</cmn:includePath>
    </cmn:managedLibrary>
  </library>
</dependencies>
```

### Mutable Parameters

For functions that modify parameters:

```spl
// SPL prototype
public void modifyInPlace(mutable list<int32> data)
```

```cpp
// C++ implementation - non-const reference
void modifyInPlace(SPL::list<SPL::int32> & data) {
    data.push_back(42);
}
```
