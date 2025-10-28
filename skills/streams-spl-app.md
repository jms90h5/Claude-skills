# Streams SPL Application Generator

## Description
This skill helps you create IBM Streams SPL (Streams Processing Language) applications with proper structure and best practices.

## What this skill does
- Creates a complete SPL application with proper namespace and structure
- Generates Makefile, info.xml, and other required files
- Provides examples based on real Streams applications
- Follows IBM Streams best practices and conventions

## Usage
Ask questions like:
- "Create a Streams SPL application that reads from Kafka and writes to a file"
- "Generate an SPL app with a custom operator"
- "Create an SPL application with multiple composite operators"

## Reference Materials

### Sample SPL Application Structure
A typical Streams SPL application has this structure:
```
MyApplication/
├── Makefile
├── info.xml
├── com.company.namespace/
│   └── Main.spl
├── etc/
│   └── (configuration files)
└── data/
    └── (input/output data)
```

### Example SPL Application
Based on samples/com.teracloud.streams.kafka/KafkaSample/com.teracloud.streams.kafka.sample/KafkaSample.spl

```spl
namespace com.teracloud.streams.kafka.sample ;

use com.teracloud.streams.kafka::KafkaConsumer ;
use com.teracloud.streams.kafka::KafkaProducer ;

/*
 * This is a very basic sample demonstrating how to use the KafkaConsumer
 * and KafkaProducer operators.
 */
public composite KafkaSample
{
	type
		Message = rstring key, rstring message;
	graph
		(stream<Message> KafkaConsumer_1_out0) as KafkaConsumer_1 =
			KafkaConsumer()
		{
			param
				topic : "test" ;
				propertiesFile : "etc/consumer.properties";
		}

		() as Custom_2 = Custom(KafkaConsumer_1_out0)
		{
			logic
				onTuple KafkaConsumer_1_out0:
				{
					println(KafkaConsumer_1_out0);
				}
		}

		() as KafkaProducer_3 = KafkaProducer(Beacon_4_out0)
		{
			param
				topic : "test" ;
				propertiesFile : "etc/producer.properties";
		}

		(stream<Message> Beacon_4_out0) as Beacon_4 = Beacon()
		{
			param
				iterations : 10u;
				initDelay : 5f;
			output Beacon_4_out0:
				key = "key_" + (rstring)IterationCount(),
				message = "msg_" + (rstring)IterationCount();
		}
}
```

### Key SPL Application Concepts

1. **Namespace**: Every SPL application must have a namespace
   - Format: `namespace com.company.application ;`
   - Use reverse domain notation

2. **Composite Operators**: Main application is a composite operator
   - Use `public composite` for the main application
   - Use `composite` for helper composites

3. **Types**: Define custom types for structured data
   ```spl
   type
       Message = rstring key, rstring message;
       Record = int64 id, rstring name, float64 value;
   ```

4. **Graph**: Contains the operator graph defining data flow
   ```spl
   graph
       (stream<Type> OutputName) as OperatorAlias = Operator(InputStream)
       {
           param
               parameter1 : value1;
           logic
               onTuple InputStream: { /* logic */ }
       }
   ```

5. **Common Operators**:
   - **Beacon**: Generates tuples at regular intervals
   - **FileSource**: Reads from files
   - **FileSink**: Writes to files
   - **Filter**: Filters tuples based on conditions
   - **Custom**: Custom processing logic
   - **Functor**: Transforms tuples

### Makefile Template
```makefile
.PHONY: all clean

SPLC_FLAGS = -a
SPLC = sc

SPL_CMD_ARGS ?=
SPL_MAIN_COMPOSITE = com.company.namespace::MainComposite

all: data
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) -t ../.. $(SPL_CMD_ARGS)

clean:
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE)
	rm -rf output

data:
	mkdir -p data
```

### info.xml Template
```xml
<?xml version="1.0" encoding="UTF-8"?>
<info:toolkitInfoModel xmlns:common="http://www.ibm.com/xmlns/prod/streams/spl/common"
 xmlns:info="http://www.ibm.com/xmlns/prod/streams/spl/toolkitInfo">
 <info:identity>
   <info:name>ApplicationName</info:name>
   <info:description>Description of the application</info:description>
   <info:version>1.0.0</info:version>
   <info:requiredProductVersion>4.0.0.0</info:requiredProductVersion>
 </info:identity>
 <info:dependencies/>
</info:toolkitInfoModel>
```

## Documentation References

### HTML Documentation
See streams_docs/com.ibm.streams.dev.doc/doc/ for detailed documentation:
- `application_development.html` - Application development guide
- `stream_applications.html` - Streams application basics
- `operators.html` - Operator reference
- `data_streams.html` - Data streams concepts
- `compilingsplapps.html` - Compiling SPL applications

### IBM Redbooks
The streams_docs directory includes comprehensive IBM Redbooks:

- **Stream1.0Redbook_sg248108.pdf** - IBM Streams Version 1.0 Redbook
  - Comprehensive guide to Streams fundamentals
  - Application development patterns
  - Operator implementation examples
  - Deployment and administration

- **Streams2.0Redbook.pdf** - IBM Streams Version 2.0 Redbook
  - Updated features and capabilities
  - Advanced application patterns
  - Performance tuning
  - Real-world use cases and best practices

These Redbooks provide in-depth coverage of Streams concepts, architecture, and development practices.

## Available Samples

The following sample applications are available in the samples directory:
- **Kafka**: samples/com.teracloud.streams.kafka/
- **JSON**: samples/com.teracloud.streams.json/
- **Network**: samples/com.teracloud.streams.network/
- **HBase**: samples/com.teracloud.streams.hbase/
- **HDFS**: samples/com.teracloud.streams.hdfs/
- **Geospatial**: samples/com.teracloud.streams.geospatial/
- **And many more**: samples/com.teracloud.streams.*/

## Best Practices

1. **Use meaningful names** for operators, streams, and variables
2. **Add comments** to explain complex logic
3. **Define types** for structured data
4. **Handle errors** properly with error ports
5. **Use configuration files** for properties (in etc/ directory)
6. **Organize code** into logical composites
7. **Follow naming conventions**: CamelCase for composites, lowercase with underscores for streams

## Instructions

When the user asks to create an SPL application:

1. Ask clarifying questions:
   - What should the application do?
   - What are the data sources and sinks?
   - What transformations are needed?
   - What toolkit operators should be used?

2. Generate the application:
   - Create proper directory structure
   - Write the main SPL file with namespace, types, and graph
   - Create Makefile and info.xml
   - Add configuration files if needed
   - Include sample data if appropriate

3. Explain the generated code:
   - Describe the operator graph
   - Explain data flow
   - Point out key parameters and configuration

4. Provide next steps:
   - How to compile the application
   - How to run it
   - How to test it
   - How to extend it
