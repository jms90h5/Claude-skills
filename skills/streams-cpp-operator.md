# Streams C++ Primitive Operator Generator

## Description
This skill helps you create IBM Streams primitive operators implemented in C++ using the Streams C++ Operator API. C++ operators provide high performance for compute-intensive operations.

## What this skill does
- Creates C++ primitive operators with proper structure
- Generates operator model XML files
- Creates code generation templates (.cgt files)
- Generates header and implementation files
- Follows IBM Streams C++ Operator development best practices

## Usage
Ask questions like:
- "Create a C++ operator that processes network packets"
- "Generate a high-performance C++ transformation operator"
- "Create a C++ source operator with custom threading"
- "Build a C++ operator with windowing support"

## C++ Operator Structure

### Directory Structure
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

### Operator Model XML

Example from samples/spl/feature/LinuxPipe/sample/LinuxPipe/LinuxPipe.xml:

```xml
<?xml version="1.0" ?>
<operatorModel
  xmlns="http://www.ibm.com/xmlns/prod/streams/spl/operator"
  xmlns:cmn="http://www.ibm.com/xmlns/prod/streams/spl/common"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.ibm.com/xmlns/prod/streams/spl/operator operatorModel.xsd">
  <cppOperatorModel>
    <context>
      <description>
The `LinuxPipe` operator runs a Linux pipe command on the contents of
the input stream and emits the results from stdout and stderr on output streams.
      </description>
      <libraryDependencies>
        <library>
          <cmn:description>my-lib</cmn:description>
          <cmn:managedLibrary>
            <cmn:lib>LinuxPipe</cmn:lib>
            <cmn:libPath>../../impl/lib</cmn:libPath>
            <cmn:includePath>../../impl/include</cmn:includePath>
          </cmn:managedLibrary>
        </library>
      </libraryDependencies>
      <providesSingleThreadedContext>Never</providesSingleThreadedContext>
    </context>
    <parameters>
      <allowAny>false</allowAny>
      <parameter>
        <name>command</name>
        <description>The Linux pipe command to execute</description>
        <optional>false</optional>
        <rewriteAllowed>true</rewriteAllowed>
        <expressionMode>AttributeFree</expressionMode>
        <type>rstring</type>
        <cardinality>1</cardinality>
      </parameter>
    </parameters>
    <inputPorts>
      <inputPortSet>
        <description>Port that ingests data to be processed</description>
        <tupleMutationAllowed>false</tupleMutationAllowed>
        <windowingMode>NonWindowed</windowingMode>
        <windowPunctuationInputMode>Oblivious</windowPunctuationInputMode>
        <cardinality>1</cardinality>
        <optional>false</optional>
      </inputPortSet>
    </inputPorts>
    <outputPorts>
      <outputPortSet>
        <description>Port that emits data from stdout</description>
        <expressionMode>Nonexistent</expressionMode>
        <autoAssignment>false</autoAssignment>
        <completeAssignment>false</completeAssignment>
        <rewriteAllowed>false</rewriteAllowed>
        <windowPunctuationOutputMode>Free</windowPunctuationOutputMode>
        <tupleMutationAllowed>true</tupleMutationAllowed>
        <cardinality>1</cardinality>
        <optional>false</optional>
      </outputPortSet>
    </outputPorts>
  </cppOperatorModel>
</operatorModel>
```

### Code Generation Templates

C++ operators use Perl-based code generation templates (.cgt files) to generate the actual C++ code.

#### Header Template (OperatorName_h.cgt)
```cpp
<%SPL::CodeGen::headerPrologue($model);%>

class MY_OPERATOR : public MY_BASE_OPERATOR
{
public:
    // Constructor
    MY_OPERATOR();

    // Destructor
    virtual ~MY_OPERATOR();

    // Notification that all ports are ready
    void allPortsReady();

    // Notification that shutdown has been requested
    void prepareToShutdown();

    // Tuple processing for mutating ports
    void process(uint32_t idx);

    // Tuple processing for non-mutating ports
    void process(Tuple const & tuple, uint32_t port);

    // Punctuation processing
    void process(Punctuation const & punct, uint32_t port);

private:
    // Members
    Mutex mutex_;
    uint64_t counter_;

    // Output tuple
    OPort0Type otuple_;
};

<%SPL::CodeGen::headerEpilogue($model);%>
```

#### Implementation Template (OperatorName_cpp.cgt)
```cpp
<%SPL::CodeGen::implementationPrologue($model);%>

// Constructor
MY_OPERATOR::MY_OPERATOR()
    : counter_(0)
{
    // Initialize members
}

// Destructor
MY_OPERATOR::~MY_OPERATOR()
{
    // Cleanup
}

// Notification that all ports are ready
void MY_OPERATOR::allPortsReady()
{
    // Start processing - create threads if needed
}

// Notification that shutdown has been requested
void MY_OPERATOR::prepareToShutdown()
{
    // Stop processing threads
}

// Tuple processing for non-mutating ports
void MY_OPERATOR::process(Tuple const & tuple, uint32_t port)
{
    // Process incoming tuple
    AutoPortMutex apm(mutex_, *this);

    IPort0Type const & ituple = static_cast<IPort0Type const &>(tuple);

    // Transform data
    otuple_.clear();
    otuple_.set_outputAttr(ituple.get_inputAttr());

    // Submit output tuple
    submit(otuple_, 0);
}

// Punctuation processing
void MY_OPERATOR::process(Punctuation const & punct, uint32_t port)
{
    // Forward punctuation
    forwardWindowPunctuation(punct);
}

<%SPL::CodeGen::implementationEpilogue($model);%>
```

## Common Operator Patterns

### Source Operator Pattern
```cpp
// Header
class MY_OPERATOR : public MY_BASE_OPERATOR
{
public:
    MY_OPERATOR();
    virtual ~MY_OPERATOR();
    void allPortsReady();
    void prepareToShutdown();
    void process(uint32_t idx);

private:
    void producetuples();
    Thread *processThread_;
    volatile bool shutdown_;
};

// Implementation
void MY_OPERATOR::allPortsReady()
{
    shutdown_ = false;
    processThread_ = getContext().getThreadFactory().newThread(
        boost::bind(&MY_OPERATOR::produceTuples, this));
}

void MY_OPERATOR::produceTuples()
{
    while (!shutdown_) {
        OPort0Type otuple;
        // Generate tuple data
        otuple.set_data("some data");
        submit(otuple, 0);

        // Sleep if needed
        getPE().blockUntilShutdownRequest(1.0);
    }
}

void MY_OPERATOR::prepareToShutdown()
{
    shutdown_ = true;
    if (processThread_ != nullptr) {
        processThread_->join();
        delete processThread_;
    }
}
```

### Transformation Operator Pattern
```cpp
void MY_OPERATOR::process(Tuple const & tuple, uint32_t port)
{
    AutoPortMutex apm(mutex_, *this);
    IPort0Type const & ituple = static_cast<IPort0Type const &>(tuple);

    // Transform input to output
    OPort0Type otuple;
    otuple.set_id(ituple.get_id());
    otuple.set_value(ituple.get_value() * 2.0);

    submit(otuple, 0);
}
```

### Sink Operator Pattern
```cpp
void MY_OPERATOR::process(Tuple const & tuple, uint32_t port)
{
    AutoPortMutex apm(mutex_, *this);
    IPort0Type const & ituple = static_cast<IPort0Type const &>(tuple);

    // Write to external system
    writeToOutput(ituple.get_data());
}

void MY_OPERATOR::process(Punctuation const & punct, uint32_t port)
{
    if (punct == Punctuation::FinalMarker) {
        // Flush output on final marker
        flushOutput();
    }
}
```

## Key C++ Operator API Components

### Operator Base Class
- **MY_BASE_OPERATOR**: Base class for your operator
- **MY_OPERATOR**: Your operator implementation

### Port Access
- **IPort0Type, IPort1Type...**: Input port types
- **OPort0Type, OPort1Type...**: Output port types
- **submit(tuple, portIndex)**: Submit tuple to output port

### Thread Safety
- **Mutex**: Mutual exclusion lock
- **AutoPortMutex**: Automatic mutex for port operations
- **CV**: Condition variable

### Parameters
- Access via: `<%=$model->getParameterByName("paramName")->getValueAt(0)->getCppExpression()%>`

### Context
- **getContext()**: Get operator context
- **getPE()**: Get processing element
- **getContext().getThreadFactory()**: Create threads

### Logging
- **SPLAPPTRC()**: Trace logging
- **SPLAPPLOG()**: Application logging

## Build Configuration

### Makefile for impl directory
```makefile
.PHONY: all clean

STREAMS_INSTALL = $(STREAMS_INSTALL)
STREAMS_BOOST_INCLUDE = $(STREAMS_INSTALL)/include
STREAMS_INCLUDE = $(STREAMS_INSTALL)/include

CXX = g++
CXXFLAGS = -O3 -Wall -std=c++11 -I$(STREAMS_INCLUDE) -I$(STREAMS_BOOST_INCLUDE) -I./include

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

## Code Generation Perl Utilities

### Common Perl Functions in .cgt files
```perl
# Get parameter value
my $param = $model->getParameterByName("paramName")->getValueAt(0)->getCppExpression();

# Get number of input/output ports
my $numInputs = $model->getNumberOfInputPorts();
my $numOutputs = $model->getNumberOfOutputPorts();

# Get port attributes
my $iport = $model->getInputPortAt(0);
my $iportType = $iport->getCppTupleType();
my @iattrs = $iport->getAttributes();

# Check if operator has windows
my $hasWindow = $iport->getWindow() != undef;

# Generate code
%>
// Generated code here
<%
```

## Documentation References

### HTML Documentation
See streams_docs/com.ibm.streams.dev.doc/doc/ for detailed documentation:
- `creatingprimitiveoperators.html` - Creating primitive operators
- `operatorimplementation.html` - Operator implementation guide
- `codegen.html` - Code generation
- `implementinggenericoperators.html` - Generic operators
- `multi_threading_considerations.html` - Threading
- `windowshandling.html` - Window handling

### IBM Redbooks
The streams_docs directory includes comprehensive IBM Redbooks:

- **Stream1.0Redbook_sg248108.pdf** - IBM Streams Version 1.0 Redbook
  - C++ operator development fundamentals
  - Code generation template (.cgt) patterns
  - Memory management and performance
  - Native operator implementation

- **Streams2.0Redbook.pdf** - IBM Streams Version 2.0 Redbook
  - Advanced C++ operator techniques
  - High-performance operator patterns
  - Threading and synchronization
  - Low-latency processing examples

These Redbooks provide in-depth coverage of C++ operator development for maximum performance.

## Best Practices

1. **Thread Safety**: Use AutoPortMutex or Mutex to protect shared state
2. **Resource Management**: Use RAII pattern - cleanup in destructor
3. **Error Handling**: Throw SPLRuntimeException for errors
4. **Performance**:
   - Minimize locking in process() methods
   - Use move semantics where possible
   - Avoid unnecessary tuple copies
5. **Memory**: Be careful with dynamic allocation in process()
6. **Threads**: Create threads in allPortsReady(), join in prepareToShutdown()
7. **Punctuation**: Forward window punctuation appropriately
8. **Logging**: Use SPLAPPTRC for debug, SPLAPPLOG for important events

## Common Data Types

### SPL to C++ Type Mapping
- `int8/16/32/64` → `int8_t, int16_t, int32_t, int64_t`
- `uint8/16/32/64` → `uint8_t, uint16_t, uint32_t, uint64_t`
- `float32/64` → `float, double`
- `rstring` → `SPL::rstring`
- `ustring` → `SPL::ustring`
- `boolean` → `boolean`
- `list<T>` → `SPL::list<T>`
- `map<K,V>` → `SPL::map<K,V>`
- `set<T>` → `SPL::set<T>`

## Instructions

When the user asks to create a C++ primitive operator:

1. Determine operator type (source, transformation, or sink)
2. Ask clarifying questions:
   - What processing does it perform?
   - What are the performance requirements?
   - Does it need custom threads?
   - What are the input/output schemas?
   - Does it need windowing support?

3. Generate the operator:
   - Create operator model XML
   - Generate header template (.cgt)
   - Generate implementation template (.cgt)
   - Create helper classes if needed (in impl/)
   - Generate Makefile

4. Explain the code:
   - Describe lifecycle methods
   - Explain threading model
   - Point out thread-safety mechanisms
   - Describe data flow

5. Provide build and test instructions
