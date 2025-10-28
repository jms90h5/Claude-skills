# Streams Java Primitive Operator Generator

## Description
This skill helps you create IBM Streams primitive operators implemented in Java using the Java Operator API. Java operators can be source operators, sink operators, or transformation operators.

## What this skill does
- Creates Java primitive operators with proper structure
- Generates operator model XML files
- Creates build files and directory structure
- Follows IBM Streams Java Operator API best practices
- Provides lifecycle management and parameter handling

## Usage
Ask questions like:
- "Create a Java source operator that reads from a REST API"
- "Generate a Java operator that filters tuples based on custom logic"
- "Create a Java sink operator that writes to a database"
- "Build a Java operator with windowing support"

## Java Operator Structure

### Directory Structure
```
ToolkitName/
├── com.company.namespace.operators/
│   └── OperatorName/
│       └── OperatorName.xml (operator model)
├── impl/
│   └── java/
│       └── src/
│           └── com/company/operators/
│               └── OperatorName.java (implementation)
├── lib/
│   └── operators.jar (compiled operator)
└── toolkit.xml
```

### Operator Model XML (OperatorName.xml)

Example from samples/spl/feature/JavaOperators/com.ibm.streams.javaprimitivesamples.sources/RandomBeacon/RandomBeacon.xml:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<operatorModel xmlns="http://www.ibm.com/xmlns/prod/streams/spl/operator"
               xmlns:cmn="http://www.ibm.com/xmlns/prod/streams/spl/common"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xsi:schemaLocation="http://www.ibm.com/xmlns/prod/streams/spl/operator operatorModel.xsd">
  <javaOperatorModel>
    <context>
      <description>Sample source operator that creates tuples with random values</description>
      <metrics/>
      <executionSettings>
        <className>com.ibm.streams.operator.samples.sources.RandomBeacon</className>
      </executionSettings>
      <libraryDependencies>
        <library>
          <cmn:description>Operator class library</cmn:description>
          <cmn:managedLibrary>
            <cmn:libPath>../../lib/samples.jar</cmn:libPath>
          </cmn:managedLibrary>
        </library>
      </libraryDependencies>
    </context>
    <parameters>
      <parameter>
        <name>period</name>
        <description>Polling period in seconds</description>
        <optional>true</optional>
        <type>float64</type>
        <cardinality>1</cardinality>
      </parameter>
      <parameter>
        <name>iterations</name>
        <description>Number of tuples to submit (0 for infinite)</description>
        <optional>true</optional>
        <type>int32</type>
        <cardinality>1</cardinality>
      </parameter>
    </parameters>
    <inputPorts/>
    <outputPorts>
      <outputPortSet>
        <description>Port that produces generated tuples</description>
        <windowPunctuationOutputMode>Generating</windowPunctuationOutputMode>
        <cardinality>1</cardinality>
        <optional>false</optional>
      </outputPortSet>
    </outputPorts>
  </javaOperatorModel>
</operatorModel>
```

### Java Operator Implementation

#### Source Operator Template
```java
package com.company.operators;

import com.ibm.streams.operator.AbstractOperator;
import com.ibm.streams.operator.OperatorContext;
import com.ibm.streams.operator.OutputTuple;
import com.ibm.streams.operator.StreamingOutput;
import com.ibm.streams.operator.model.OutputPortSet;
import com.ibm.streams.operator.model.PrimitiveOperator;
import com.ibm.streams.operator.model.Parameter;

@PrimitiveOperator(
    name="MySourceOperator",
    namespace="com.company.operators",
    description="Custom source operator description"
)
@OutputPortSet(cardinality=1, description="Output port")
public class MySourceOperator extends AbstractOperator {

    private double period = 1.0;
    private int iterations = 0;
    private Thread producerThread;

    @Parameter(optional=true, description="Period between tuples in seconds")
    public void setPeriod(double value) {
        this.period = value;
    }

    @Parameter(optional=true, description="Number of tuples to produce (0=infinite)")
    public void setIterations(int value) {
        this.iterations = value;
    }

    @Override
    public synchronized void initialize(OperatorContext context) throws Exception {
        super.initialize(context);
        // Initialize resources
    }

    @Override
    public synchronized void allPortsReady() throws Exception {
        // Start tuple production
        producerThread = getOperatorContext().getThreadFactory().newThread(
            new Runnable() {
                @Override
                public void run() {
                    try {
                        produceTuples();
                    } catch (Exception e) {
                        // Handle error
                    }
                }
            });
        producerThread.setDaemon(false);
        producerThread.start();
    }

    private void produceTuples() throws Exception {
        StreamingOutput<OutputTuple> output = getOutput(0);
        int count = 0;

        while (!Thread.interrupted() && (iterations == 0 || count < iterations)) {
            OutputTuple tuple = output.newTuple();
            // Set tuple attributes
            tuple.setString("message", "Tuple " + count);
            tuple.setLong("timestamp", System.currentTimeMillis());

            output.submit(tuple);
            count++;

            if (period > 0) {
                Thread.sleep((long)(period * 1000));
            }
        }
    }

    @Override
    public synchronized void shutdown() throws Exception {
        if (producerThread != null) {
            producerThread.interrupt();
        }
        super.shutdown();
    }
}
```

#### Transformation Operator Template
```java
package com.company.operators;

import com.ibm.streams.operator.AbstractOperator;
import com.ibm.streams.operator.OperatorContext;
import com.ibm.streams.operator.OutputTuple;
import com.ibm.streams.operator.StreamingInput;
import com.ibm.streams.operator.StreamingOutput;
import com.ibm.streams.operator.Tuple;
import com.ibm.streams.operator.model.InputPortSet;
import com.ibm.streams.operator.model.OutputPortSet;
import com.ibm.streams.operator.model.PrimitiveOperator;
import com.ibm.streams.operator.model.InputPortSet.WindowMode;
import com.ibm.streams.operator.model.InputPortSet.WindowPunctuationInputMode;
import com.ibm.streams.operator.model.Parameter;

@PrimitiveOperator(
    name="MyTransformOperator",
    namespace="com.company.operators",
    description="Custom transformation operator"
)
@InputPortSet(cardinality=1, description="Input port")
@OutputPortSet(cardinality=1, description="Output port")
public class MyTransformOperator extends AbstractOperator {

    private String filterAttribute;

    @Parameter(optional=false, description="Attribute to use for filtering")
    public void setFilterAttribute(String value) {
        this.filterAttribute = value;
    }

    @Override
    public synchronized void initialize(OperatorContext context) throws Exception {
        super.initialize(context);
    }

    @Override
    public void process(StreamingInput<Tuple> stream, Tuple tuple) throws Exception {
        StreamingOutput<OutputTuple> output = getOutput(0);

        // Transform the tuple
        OutputTuple outTuple = output.newTuple();
        outTuple.assign(tuple);

        // Apply custom logic
        String value = tuple.getString(filterAttribute);
        if (shouldProcess(value)) {
            outTuple.setString("processed", "YES");
            output.submit(outTuple);
        }
    }

    private boolean shouldProcess(String value) {
        // Custom processing logic
        return value != null && !value.isEmpty();
    }
}
```

#### Sink Operator Template
```java
package com.company.operators;

import com.ibm.streams.operator.AbstractOperator;
import com.ibm.streams.operator.OperatorContext;
import com.ibm.streams.operator.StreamingInput;
import com.ibm.streams.operator.Tuple;
import com.ibm.streams.operator.model.InputPortSet;
import com.ibm.streams.operator.model.PrimitiveOperator;
import com.ibm.streams.operator.model.Parameter;

@PrimitiveOperator(
    name="MySinkOperator",
    namespace="com.company.operators",
    description="Custom sink operator"
)
@InputPortSet(cardinality=1, description="Input port")
public class MySinkOperator extends AbstractOperator {

    private String outputPath;

    @Parameter(optional=false, description="Output file path")
    public void setOutputPath(String value) {
        this.outputPath = value;
    }

    @Override
    public synchronized void initialize(OperatorContext context) throws Exception {
        super.initialize(context);
        // Initialize output connection (file, database, etc.)
    }

    @Override
    public void process(StreamingInput<Tuple> stream, Tuple tuple) throws Exception {
        // Write tuple to output
        String data = tuple.toString();
        writeToOutput(data);
    }

    private void writeToOutput(String data) {
        // Implement output logic
    }

    @Override
    public synchronized void shutdown() throws Exception {
        // Close output connection
        super.shutdown();
    }
}
```

## Operator Lifecycle Methods

1. **initialize(OperatorContext)**: Called once when operator starts
   - Initialize resources
   - Set up connections
   - Validate parameters

2. **allPortsReady()**: Called after all ports are connected
   - Start background threads (for source operators)
   - Begin processing

3. **process(StreamingInput, Tuple)**: Called for each input tuple
   - Process incoming tuples
   - Submit output tuples

4. **processPunctuation(StreamingInput, Punctuation)**: Handle punctuation marks
   - Window markers
   - Final markers

5. **shutdown()**: Called when operator is stopping
   - Clean up resources
   - Close connections
   - Stop threads

## Common Annotations

- **@PrimitiveOperator**: Marks the class as a primitive operator
- **@InputPortSet**: Defines input port characteristics
- **@OutputPortSet**: Defines output port characteristics
- **@Parameter**: Marks parameter setter methods
- **@ContextCheck**: Validation method run at compile time

## Build Configuration

### build.xml for Ant
```xml
<project name="MyOperator" default="all" basedir=".">
    <property name="streams.install" location="${env.STREAMS_INSTALL}"/>
    <property name="src" location="impl/java/src"/>
    <property name="build" location="impl/java/classes"/>
    <property name="lib" location="lib"/>

    <path id="cp.streams">
        <pathelement location="${streams.install}/lib/com.ibm.streams.operator.jar"/>
        <pathelement location="${streams.install}/lib/com.ibm.streams.operator.samples.jar"/>
    </path>

    <target name="all" depends="jar"/>

    <target name="compile">
        <mkdir dir="${build}"/>
        <javac srcdir="${src}" destdir="${build}" classpathref="cp.streams"
               debug="true" includeantruntime="no"/>
    </target>

    <target name="jar" depends="compile">
        <mkdir dir="${lib}"/>
        <jar destfile="${lib}/myoperator.jar" basedir="${build}"/>
    </target>

    <target name="clean">
        <delete dir="${build}"/>
        <delete dir="${lib}"/>
    </target>
</project>
```

## Documentation References

See streams_docs/com.ibm.streams.dev.doc/doc/ for detailed documentation:
- `javaoperatorapioverview.html` - Java Operator API overview
- `javaprimitiveoperators.html` - Java primitive operators guide
- `javapperatorlifecycle.html` - Operator lifecycle
- `implementingoperusingjavaapi.html` - Implementation guide
- `threadinginjavaoperator.html` - Threading considerations

## Best Practices

1. **Thread Safety**: Use `synchronized` for methods that access shared state
2. **Resource Management**: Clean up in `shutdown()` method
3. **Error Handling**: Catch and handle exceptions appropriately
4. **Performance**: Minimize object creation in `process()` method
5. **Logging**: Use `getOperatorContext().getLogger()` for logging
6. **Metrics**: Define custom metrics using `@CustomMetric`
7. **Parameters**: Validate parameters in `@ContextCheck` methods
8. **Punctuation**: Handle window and final punctuation markers

## Instructions

When the user asks to create a Java primitive operator:

1. Determine operator type (source, transformation, or sink)
2. Ask clarifying questions:
   - What data does it process?
   - What parameters are needed?
   - What are the input/output schemas?
   - Does it need windowing support?

3. Generate the operator:
   - Create Java class with appropriate annotations
   - Implement lifecycle methods
   - Add parameter methods with @Parameter
   - Create operator model XML file
   - Generate build file

4. Explain the code:
   - Describe the operator's purpose
   - Explain key methods and logic
   - Point out customization points

5. Provide build and test instructions
