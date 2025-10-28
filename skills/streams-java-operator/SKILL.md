---
name: streams-java-operator
description: Generate IBM Streams primitive operators implemented in Java using the Java Operator API. Creates source, transformation, or sink operators with proper lifecycle management, operator model XML, and build files. Use when creating Java operators, integrating with Java libraries, or when user mentions Java, REST APIs, databases, or Java-specific functionality.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

# Streams Java Primitive Operator Generator

This skill helps you create IBM Streams primitive operators implemented in Java using the Java Operator API.

## What this skill does

- Creates Java primitive operators with proper structure
- Generates operator model XML files
- Creates build files and directory structure
- Follows IBM Streams Java Operator API best practices
- Provides lifecycle management and parameter handling

## Instructions

When the user asks to create a Java primitive operator:

1. **Determine operator type** (source, transformation, or sink)

2. **Ask clarifying questions:**
   - What data does it process?
   - What parameters are needed?
   - What are the input/output schemas?
   - Does it need windowing support?

3. **Generate the operator:**
   - Create Java class with appropriate annotations
   - Implement lifecycle methods
   - Add parameter methods with @Parameter
   - Create operator model XML file
   - Generate build file

4. **Explain the code:**
   - Describe the operator's purpose
   - Explain key methods and logic
   - Point out customization points

5. **Provide build and test instructions**

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

### Source Operator Template

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

### Transformation Operator Template

```java
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
    public void process(StreamingInput<Tuple> stream, Tuple tuple) throws Exception {
        StreamingOutput<OutputTuple> output = getOutput(0);
        OutputTuple outTuple = output.newTuple();
        outTuple.assign(tuple);

        String value = tuple.getString(filterAttribute);
        if (shouldProcess(value)) {
            outTuple.setString("processed", "YES");
            output.submit(outTuple);
        }
    }

    private boolean shouldProcess(String value) {
        return value != null && !value.isEmpty();
    }
}
```

## Operator Lifecycle Methods

1. **initialize(OperatorContext)**: Called once when operator starts
2. **allPortsReady()**: Called after all ports are connected
3. **process(StreamingInput, Tuple)**: Called for each input tuple
4. **shutdown()**: Called when operator is stopping

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

### Primary (Local - Can be READ by Claude)
See `/home/streamsadmin/workspace/Claude-skills/streams_docs/`:
- `com.ibm.streams.dev.doc/doc/javaoperatorapioverview.html` - Java Operator API overview
- `com.ibm.streams.dev.doc/doc/javaprimitiveoperators.html` - Java primitive operators guide
- `com.ibm.streams.dev.doc/doc/javapperatorlifecycle.html` - Operator lifecycle
- `com.ibm.streams.dev.doc/doc/implementingoperusingjavaapi.html` - Implementation guide
- `Streams2.0Redbook.pdf` - Advanced Java operator techniques

### Supplementary (Online)
- **Teracloud Streams Docs**: https://doc.streams.teracloud.com/index.html
- Check `/opt/teracloud/streams/7.2.0.1/samples` for official examples

## Best Practices

### From CLAUDE.md (MANDATORY)
1. **NO FAKE CODE EVER**: Never use placeholders, mocks, or dummy implementations
2. **Clean Compilation**: ALL code must compile without errors
3. **Verify Functionality**: Test with real data, document actual output
4. **No Shortcuts**: Never comment out functionality to avoid implementation
5. **Real Implementations**: All REST APIs, database connections, etc. must be functional

### Java Operator Specific
1. **Thread Safety**: Use `synchronized` for methods that access shared state
2. **Resource Management**: Clean up in `shutdown()` method
3. **Error Handling**: Catch and handle exceptions appropriately
4. **Performance**: Minimize object creation in `process()` method
5. **Logging**: Use `getOperatorContext().getLogger()` for logging
6. **Dependencies**: Document all external JARs needed
7. **Null Safety**: Check for null values from tuple methods
