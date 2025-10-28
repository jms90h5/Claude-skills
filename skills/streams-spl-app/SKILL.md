---
name: streams-spl-app
description: Generate IBM Streams SPL (Streams Processing Language) applications with proper structure, Makefiles, and configuration files. Use when creating streaming applications, data pipelines, SPL programs, or when user mentions Streams applications, Kafka integration, or real-time data processing.
---

# Streams SPL Application Generator

This skill helps you create IBM Streams SPL (Streams Processing Language) applications with proper structure and best practices.

## 🚨 CRITICAL: Read CLAUDE.md First

**BEFORE generating any code, consult `/home/streamsadmin/workspace/teracloud/CLAUDE.md` for:**
- ❌ ABSOLUTE PROHIBITION on fake/placeholder/mock code
- ✅ SPL syntax verification requirements
- ✅ Teracloud Streams specific conventions
- ✅ Compilation standards

**For SPL syntax questions, ALWAYS check:**
1. First: https://doc.streams.teracloud.com/index.html
2. Second: Local samples in `/opt/teracloud/streams/7.2.0.1/samples`
3. Third: Documentation in `/home/streamsadmin/workspace/Claude-skills/streams_docs/`

## What this skill does

- Creates a complete SPL application with proper namespace and structure
- Generates Makefile, info.xml, and other required files
- Provides examples based on real Streams applications
- Follows IBM Streams best practices and conventions

## Instructions

When the user asks to create an SPL application:

1. **Ask clarifying questions:**
   - What should the application do?
   - What are the data sources and sinks?
   - What transformations are needed?
   - What toolkit operators should be used?

2. **Generate the application:**
   - Create proper directory structure
   - Write the main SPL file with namespace, types, and graph
   - Create Makefile and info.xml
   - Add configuration files if needed
   - Include sample data if appropriate

3. **Explain the generated code:**
   - Describe the operator graph
   - Explain data flow
   - Point out key parameters and configuration

4. **Provide next steps:**
   - How to compile the application
   - How to run it
   - How to test it
   - How to extend it

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

Based on samples/com.teracloud.streams.kafka/KafkaSample/:

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

## Available Samples

Reference examples from these sample directories:
- `samples/com.teracloud.streams.kafka/` - Kafka integration
- `samples/com.teracloud.streams.json/` - JSON processing
- `samples/com.teracloud.streams.network/` - Network packet processing
- `samples/com.teracloud.streams.geospatial/` - Geospatial operations
- `samples/com.teracloud.streams.hbase/` - HBase integration
- `samples/com.teracloud.streams.hdfs/` - HDFS file operations

## Documentation References

### Primary (Local - Can be READ by Claude)
See `/home/streamsadmin/workspace/Claude-skills/streams_docs/`:
- `com.ibm.streams.dev.doc/doc/application_development.html` - Application development guide
- `com.ibm.streams.dev.doc/doc/stream_applications.html` - Streams application basics
- `com.ibm.streams.dev.doc/doc/operators.html` - Operator reference
- `com.ibm.streams.dev.doc/doc/compilingsplapps.html` - Compiling SPL applications
- `Stream1.0Redbook_sg248108.pdf` - Comprehensive guide to Streams fundamentals
- `Streams2.0Redbook.pdf` - Updated features and advanced patterns

### Supplementary (Online)
- **Teracloud Streams Docs**: https://doc.streams.teracloud.com/index.html
- Check `/opt/teracloud/streams/7.2.0.1/samples` for official examples
- Sample code: `/home/streamsadmin/workspace/Claude-skills/samples/`

## Best Practices

### From CLAUDE.md (MANDATORY)
1. **NO FAKE CODE EVER**: Never use placeholders, mocks, or dummy implementations
2. **Verify SPL Syntax**: Check Teracloud docs before using unfamiliar SPL constructs
3. **Clean Compilation**: Code must compile without errors
4. **Test Functionality**: Verify applications work with real data
5. **No Shortcuts**: Never comment out functionality to avoid implementation

### SPL Application Specific
1. **Use meaningful names** for operators, streams, and variables
2. **Add comments** to explain complex logic
3. **Define types** for structured data
4. **Handle errors** properly with error ports
5. **Use configuration files** for properties (in etc/ directory)
6. **Organize code** into logical composites
7. **Follow naming conventions**: CamelCase for composites, camelCase for streams
