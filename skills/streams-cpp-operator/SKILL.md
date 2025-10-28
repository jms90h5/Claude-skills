---
name: streams-cpp-operator
description: Generate high-performance IBM Streams primitive operators implemented in C++ using code generation templates. Creates operators with optimal performance for compute-intensive operations. Use when creating C++ operators, processing network packets, handling high-throughput data, or when user mentions C++, performance, or low-latency requirements.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

# Streams C++ Primitive Operator Generator

This skill helps you create IBM Streams primitive operators implemented in C++ using the Streams C++ Operator API.

## 🚨 CRITICAL: Read CLAUDE.md First

**BEFORE generating any code, consult `/home/streamsadmin/workspace/teracloud/CLAUDE.md` for:**
- ❌ ABSOLUTE PROHIBITION on fake/placeholder/mock code
- ✅ Compilation requirements (ALL code must compile cleanly with no warnings)
- ✅ Testing and verification standards
- ✅ Teracloud Streams specific conventions

**For SPL syntax questions, ALWAYS consult: https://doc.streams.teracloud.com/index.html**

## What this skill does

- Creates C++ primitive operators with proper structure
- Generates operator model XML files
- Creates code generation templates (.cgt files)
- Generates header and implementation files
- Follows IBM Streams C++ Operator development best practices
- **Generates ONLY real, functional code - never fake/placeholder implementations**

## Instructions

When the user asks to create a C++ primitive operator:

1. **Determine operator type** (source, transformation, or sink)

2. **Ask clarifying questions:**
   - What processing does it perform?
   - What are the performance requirements?
   - Does it need custom threads?
   - What are the input/output schemas?

3. **Generate the operator:**
   - Create operator model XML
   - Generate header template (.cgt)
   - Generate implementation template (.cgt)
   - Create helper classes if needed (in impl/)
   - Generate Makefile

4. **Explain the code:**
   - Describe lifecycle methods
   - Explain threading model
   - Point out thread-safety mechanisms

## C++ Operator Structure

Directory Structure:
```
ToolkitName/
├── OperatorName/
│   ├── OperatorName.xml (operator model)
│   ├── OperatorName_h.cgt (header template)
│   ├── OperatorName_cpp.cgt (implementation template)
│   └── OperatorNameCommon.pm (optional Perl helper)
├── impl/
│   ├── include/
│   │   └── HelperClass.h
│   └── src/
│       └── HelperClass.cpp
└── impl/Makefile
```

## Header Template (OperatorName_h.cgt)

```cpp
<%SPL::CodeGen::headerPrologue($model);%>

class MY_OPERATOR : public MY_BASE_OPERATOR
{
public:
    MY_OPERATOR();
    virtual ~MY_OPERATOR();
    void allPortsReady();
    void prepareToShutdown();
    void process(uint32_t idx);
    void process(Tuple const & tuple, uint32_t port);
    void process(Punctuation const & punct, uint32_t port);

private:
    Mutex mutex_;
    uint64_t counter_;
    OPort0Type otuple_;
};

<%SPL::CodeGen::headerEpilogue($model);%>
```

## Implementation Template (OperatorName_cpp.cgt)

```cpp
<%SPL::CodeGen::implementationPrologue($model);%>

MY_OPERATOR::MY_OPERATOR() : counter_(0) {
    // Initialize members
}

MY_OPERATOR::~MY_OPERATOR() {
    // Cleanup
}

void MY_OPERATOR::allPortsReady() {
    // Start processing - create threads if needed
}

void MY_OPERATOR::prepareToShutdown() {
    // Stop processing threads
}

void MY_OPERATOR::process(Tuple const & tuple, uint32_t port) {
    AutoPortMutex apm(mutex_, *this);
    IPort0Type const & ituple = static_cast<IPort0Type const &>(tuple);
    
    otuple_.clear();
    otuple_.set_outputAttr(ituple.get_inputAttr());
    submit(otuple_, 0);
}

void MY_OPERATOR::process(Punctuation const & punct, uint32_t port) {
    forwardWindowPunctuation(punct);
}

<%SPL::CodeGen::implementationEpilogue($model);%>
```

## Key C++ Operator API Components

- **MY_BASE_OPERATOR**: Base class for your operator
- **MY_OPERATOR**: Your operator implementation
- **IPort0Type, OPort0Type**: Input/output port types
- **submit(tuple, portIndex)**: Submit tuple to output port
- **Mutex, AutoPortMutex**: Thread safety
- **getContext(), getPE()**: Access operator context

## Build Configuration

Makefile for impl directory:
```makefile
STREAMS_INSTALL = $(STREAMS_INSTALL)
STREAMS_INCLUDE = $(STREAMS_INSTALL)/include

CXX = g++
CXXFLAGS = -O3 -Wall -std=c++11 -I$(STREAMS_INCLUDE) -I./include

SOURCES = $(wildcard src/*.cpp)
OBJECTS = $(SOURCES:src/%.cpp=lib/%.o)
LIBRARY = lib/libmyoperator.so

all: $(LIBRARY)

$(LIBRARY): $(OBJECTS)
	@mkdir -p lib
	$(CXX) -shared -o $@ $^

lib/%.o: src/%.cpp
	@mkdir -p lib
	$(CXX) $(CXXFLAGS) -fPIC -c $< -o $@

clean:
	rm -rf lib
```

## Documentation References

### Primary (Local - Can be READ by Claude)
See `/home/streamsadmin/workspace/Claude-skills/streams_docs/`:
- `com.ibm.streams.dev.doc/doc/creatingprimitiveoperators.html` - Creating primitive operators
- `com.ibm.streams.dev.doc/doc/operatorimplementation.html` - Operator implementation guide
- `com.ibm.streams.dev.doc/doc/codegen.html` - Code generation
- `com.ibm.streams.dev.doc/doc/multi_threading_considerations.html` - Threading
- `Streams2.0Redbook.pdf` - Advanced C++ operator techniques

### Operator Code Generation API (Local)
- `/opt/teracloud/streams/7.2.0.1/doc/spl/operator/api` - C++ Operator API reference
- `/opt/teracloud/streams/7.2.0.1/doc/spl/operator/code-generation-api` - Code generation Perl API

### Supplementary (Online)
- **Teracloud Streams Docs**: https://doc.streams.teracloud.com/index.html
- Check `/opt/teracloud/streams/7.2.0.1/samples` for official examples

## Best Practices

### From CLAUDE.md (MANDATORY)
1. **NO FAKE CODE EVER**: Never use placeholders, mocks, or dummy implementations
2. **Clean Compilation**: ALL code must compile without warnings (-Wall -Wextra)
3. **Proper Type Casting**: Use static_cast<> for size_t vs int comparisons
4. **Verify Functionality**: Test with real data, document actual output
5. **No Shortcuts**: Never comment out functionality to avoid implementation

### C++ Operator Specific
1. **Thread Safety**: Use AutoPortMutex or Mutex to protect shared state
2. **Resource Management**: Use RAII pattern - cleanup in destructor
3. **Error Handling**: Throw SPLRuntimeException for errors
4. **Performance**: Minimize locking in process() methods
5. **Memory**: Be careful with dynamic allocation in process()
6. **Const Correctness**: Use const where appropriate
7. **Loop Indices**: Use size_t for container.size() comparisons
