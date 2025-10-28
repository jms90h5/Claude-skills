---
name: streams-toolkit
description: Generate complete IBM Streams toolkits - reusable collections of operators, functions, and types that can be shared across applications. Creates toolkit structure, metadata files, build configuration, and packaging. Use when creating toolkits, packaging operators for reuse, distributing functionality, or when user mentions toolkit, packaging, reusable operators, or library creation.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

# Streams Toolkit Generator

This skill helps you create IBM Streams toolkits - reusable collections of operators, functions, and types.

## 🚨 CRITICAL: Read CLAUDE.md First

**BEFORE generating any code, consult `/home/streamsadmin/workspace/teracloud/CLAUDE.md` for:**
- ❌ ABSOLUTE PROHIBITION on fake/placeholder/mock code
- ✅ Compilation requirements (ALL code must compile cleanly)
- ✅ Testing and verification standards
- ✅ Teracloud Streams specific conventions

**For SPL syntax questions, ALWAYS consult: https://doc.streams.teracloud.com/index.html**

## What this skill does

- Creates complete toolkit directory structure
- Generates toolkit.xml and info.xml configuration files
- Sets up namespaces and operators
- Creates build files and documentation
- Follows IBM Streams toolkit best practices

## Instructions

When the user asks to create a Streams toolkit:

1. **Ask clarifying questions:**
   - What is the toolkit's purpose?
   - What operators should it include?
   - What languages (Java/C++/Python)?
   - Any external dependencies?

2. **Generate the toolkit:**
   - Create directory structure
   - Generate toolkit.xml and info.xml
   - Create Makefiles
   - Set up namespaces
   - Add operator placeholders
   - Create sample application

3. **Explain the structure:**
   - Describe organization
   - Explain build process
   - Show how to add operators

4. **Provide next steps:**
   - How to build, test, document, package

## Toolkit Structure

```
com.company.toolkit/
├── toolkit.xml                    # Toolkit metadata (auto-generated)
├── info.xml                       # Toolkit information
├── Makefile                       # Build configuration
│
├── com.company.namespace/         # SPL namespace directories
│   ├── Operator1/                 # Primitive operator
│   │   └── Operator1.xml          # Operator model
│   ├── Composite1.spl             # Composite operator
│   └── types.spl                  # Type definitions
│
├── impl/                          # Implementation files
│   ├── java/                      # Java implementations
│   │   ├── src/
│   │   └── build.xml
│   ├── cpp/                       # C++ implementations
│   │   ├── src/
│   │   ├── include/
│   │   └── Makefile
│   └── python/                    # Python implementations
│
├── lib/                           # Compiled libraries
│   ├── liboperators.so
│   └── operators.jar
│
├── opt/                           # Optional resources
│   └── python/
│       └── streams/
│
├── etc/                           # Configuration files
└── samples/                       # Sample applications
    └── SampleApp/
        ├── Main.spl
        └── Makefile
```

## info.xml - Toolkit Metadata

```xml
<?xml version="1.0" encoding="UTF-8"?>
<info:toolkitInfoModel
  xmlns:common="http://www.ibm.com/xmlns/prod/streams/spl/common"
  xmlns:info="http://www.ibm.com/xmlns/prod/streams/spl/toolkitInfo">

  <info:identity>
    <info:name>com.company.toolkit</info:name>
    <info:description>
      Comprehensive description of what this toolkit provides.
    </info:description>
    <info:version>1.0.0</info:version>
    <info:requiredProductVersion>4.0.0</info:requiredProductVersion>
  </info:identity>

  <info:dependencies>
    <info:toolkit>
      <common:name>com.teracloud.streams.json</common:name>
      <common:version>[2.0.0,3.0.0)</common:version>
    </info:toolkit>
  </info:dependencies>
</info:toolkitInfoModel>
```

## Top-Level Makefile

```makefile
.PHONY: all clean toolkit java cpp python samples doc

TOOLKIT_NAME = com.company.toolkit
STREAMS_INSTALL = $(STREAMS_INSTALL)
SPLC = $(STREAMS_INSTALL)/bin/sc
SPLC_FLAGS = -a

all: toolkit

toolkit: java cpp python
	@echo "Building toolkit..."
	$(SPLC) $(SPLC_FLAGS) -M $(TOOLKIT_NAME) --no-mixed-mode-preprocessing
	@echo "Toolkit build complete"

java:
	@echo "Building Java operators..."
	@if [ -d "impl/java" ]; then \
		cd impl/java && ant; \
	fi

cpp:
	@echo "Building C++ operators..."
	@if [ -d "impl/cpp" ]; then \
		cd impl/cpp && $(MAKE); \
	fi

python:
	@echo "Python operators don't need compilation"

clean:
	@echo "Cleaning toolkit..."
	$(SPLC) $(SPLC_FLAGS) -C -M $(TOOLKIT_NAME)
	@if [ -d "impl/java" ]; then \
		cd impl/java && ant clean; \
	fi
	@if [ -d "impl/cpp" ]; then \
		cd impl/cpp && $(MAKE) clean; \
	fi
	rm -rf output
```

## Namespace Organization

### SPL Types File

```spl
namespace com.company.namespace;

/**
 * Message type for data exchange
 */
type Message = rstring key, rstring value, timestamp ts;

/**
 * Configuration type
 */
type Config = rstring host, int32 port, boolean secure;
```

### Composite Operators

```spl
namespace com.company.namespace;

/**
 * Composite operator that encapsulates common processing pattern
 */
public composite ProcessData(input In; output Out)
{
    param
        expression<rstring> $filter : ".*";
        expression<int32> $batchSize : 100;

    graph
        stream<In> Filtered = Filter(In)
        {
            param
                filter: matches(data, $filter);
        }

        stream<In> Out = Aggregate(Filtered)
        {
            window
                Filtered: tumbling, count($batchSize);
        }
}
```

## Toolkit Versioning

Follow Semantic Versioning (MAJOR.MINOR.PATCH):
- **MAJOR**: Incompatible API changes
- **MINOR**: Add functionality in backward-compatible manner
- **PATCH**: Backward-compatible bug fixes

## Toolkit Dependencies

```xml
<dependency>
    <common:name>com.teracloud.streams.kafka</common:name>
    <!-- Version range: >= 2.0.0 and < 3.0.0 -->
    <common:version>[2.0.0,3.0.0)</common:version>
</dependency>
```

## Packaging and Distribution

### Create Toolkit Archive

```bash
# Index the toolkit
sc -M com.company.toolkit

# Create archive
tar czf com.company.toolkit-1.0.0.tar.gz com.company.toolkit/
```

### Using the Toolkit

Users reference the toolkit by:

1. Environment variable:
```bash
export STREAMS_SPLPATH=/path/to/toolkits:$STREAMS_SPLPATH
```

2. Compiler flag:
```bash
sc -t /path/to/com.company.toolkit -M my.app::Main
```

## Documentation

### Generate SPLDoc

```bash
# Generate HTML documentation
sc -M com.company.toolkit --doc

# Documentation will be in doc/spldoc/html/
```

## Multi-Language Toolkit Example

```
com.company.analytics/
├── toolkit.xml
├── info.xml
├── Makefile
│
├── com.company.analytics/
│   ├── types.spl
│   ├── JavaFilter/
│   │   └── JavaFilter.xml
│   └── CppTransform/
│       ├── CppTransform.xml
│       ├── CppTransform_h.cgt
│       └── CppTransform_cpp.cgt
│
├── impl/
│   ├── java/
│   │   ├── src/com/company/analytics/
│   │   │   └── JavaFilter.java
│   │   └── build.xml
│   └── cpp/
│       ├── src/CppTransform.cpp
│       ├── include/CppTransform.h
│       └── Makefile
│
├── opt/
│   └── python/
│       └── streams/
│           └── analytics.py
│
└── lib/
    ├── analytics.jar
    └── libanalytics.so
```

## Documentation References

### Primary (Local - Can be READ by Claude)
See `/home/streamsadmin/workspace/Claude-skills/streams_docs/`:
- `com.ibm.streams.dev.doc/doc/toolkits.html` - Toolkit overview
- `com.ibm.streams.dev.doc/doc/creating_toolkits.html` - Creating toolkits guide
- `com.ibm.streams.dev.doc/doc/toolkitstructure.html` - Toolkit structure
- `com.ibm.streams.dev.doc/doc/versioningguidelines.html` - Versioning guidelines
- `com.ibm.streams.dev.doc/doc/packagingatoolkit.html` - Packaging guide
- `Streams2.0Redbook.pdf` - Advanced toolkit development techniques

### Supplementary (Online)
- **Teracloud Streams Docs**: https://doc.streams.teracloud.com/index.html
- Check `/opt/teracloud/streams/7.2.0.1/samples` for official examples

## Best Practices

### From CLAUDE.md (MANDATORY)
1. **NO FAKE CODE EVER**: Never use placeholders, mocks, or dummy implementations
2. **Clean Compilation**: ALL code must compile without warnings
3. **Verify Functionality**: Test with real data, document actual output
4. **No Shortcuts**: Never comment out functionality to avoid implementation

### Toolkit Specific
1. **Naming**: Use reverse domain notation (com.company.functionality)
2. **Versioning**: Follow semantic versioning strictly
3. **Organization**: Group related operators in same namespace
4. **Documentation**: Add comprehensive SPLDoc comments
5. **Testing**: Create sample applications
6. **Dependencies**: Minimize and document clearly
7. **Maintenance**: Use version control
8. **Build Files**: Include working Makefiles for all impl directories
