# SPL Streams Application Builder Skill

A comprehensive Claude Code skill for creating Teracloud Streams (formerly IBM Streams) applications using Stream Programming Language (SPL).

## Overview

This skill enables Claude to assist with creating, modifying, and understanding SPL applications for real-time stream processing. It provides expertise in:

- SPL language syntax and structure
- Common operators and their usage
- Application templates and patterns
- Best practices for stream processing
- Migration from IBM Streams to Teracloud Streams

## Installation

### Using this Skill in Claude Code

1. **Copy to Claude Code Skills Directory**:
   ```bash
   # If you have a .claude/skills directory
   cp -r skills/spl-streams ~/.claude/skills/

   # Or create a symlink
   ln -s $(pwd)/skills/spl-streams ~/.claude/skills/spl-streams
   ```

2. **Activate the Skill**:
   In Claude Code, you can reference this skill by saying:
   - "Use the SPL Streams skill to help me..."
   - "I need help creating an SPL application"
   - "Can you help me with Teracloud Streams?"

## Features

### Core Capabilities

- **Application Scaffolding**: Generate complete SPL application structures
- **Operator Assistance**: Help selecting and configuring operators
- **Code Generation**: Create working SPL code with proper syntax
- **Pattern Matching**: Suggest appropriate patterns for common use cases
- **Documentation Links**: Reference official Teracloud Streams and IBM Streams docs
- **Best Practices**: Recommend performance and maintainability improvements

### Supported Operators

#### Source Operators
- Beacon, FileSource, DirectoryScan, TCPSource, UDPSource

#### Processing Operators
- Functor, Filter, Aggregate, Sort, Join, Split, Custom

#### Sink Operators
- FileSink, TCPSink, UDPSink, Custom

## Usage Examples

### Example 1: Basic Hello World

**Prompt**: "Create a simple SPL application that prints Hello World"

**Generated Code**:
```spl
namespace examples.hello;

composite HelloWorld {
    graph
        stream<rstring message> Greetings = Beacon() {
            param
                iterations: 5u;
            output
                Greetings: message = "Hello World!";
        }

        () as Printer = Custom(Greetings) {
            logic
                onTuple Greetings: {
                    printStringLn(message);
                }
        }
}
```

### Example 2: File Processing

**Prompt**: "Create an SPL app that reads a CSV file, filters rows, and writes results"

**Generated Code**: See `examples/file-processing.spl`

### Example 3: Real-Time Analytics

**Prompt**: "Help me build a stream processor that calculates moving averages"

**Generated Code**: See `examples/realtime-analytics.spl`

## Application Templates

The skill includes several ready-to-use templates:

1. **File Processing Pipeline**: Read, process, and write files
2. **Real-Time Analytics**: Continuous computation on streaming data
3. **ETL Pipeline**: Extract, Transform, Load patterns
4. **Join Multiple Streams**: Correlate data from different sources
5. **Windowed Aggregation**: Time-based or count-based aggregations

## Documentation References

### Teracloud Streams (Latest)
- Documentation: https://doc.streams.teracloud.com/
- Version 7.2.0 Release Notes: https://streams.teracloud.com/releases/7.2.0
- Downloads: https://streams.teracloud.com/downloads/streams-studio

### IBM Streams (Compatible/Reference)
- SPL Samples: http://ibmstreams.github.io/streamsx.documentation/samples/
- Tutorials: https://ibmstreams.github.io/tutorials/
- Sample Catalog: https://ibmstreams.github.io/samples/

## Key Concepts

### Composites
The main building block of SPL applications. A composite defines a reusable stream processing graph.

```spl
composite MyApp {
    graph
        // Define your stream processing here
}
```

### Streams
Typed sequences of tuples flowing through the application.

```spl
stream<rstring name, int32 age> PersonStream = ...
```

### Operators
Functions that operate on streams. Operators can:
- Generate data (sources)
- Transform data (processing)
- Output data (sinks)

### Windows
Define how to group tuples for aggregation:
- **Tumbling**: Non-overlapping windows
- **Sliding**: Overlapping windows
- **Time-based**: Based on tuple timestamps
- **Count-based**: Based on number of tuples

## Common Use Cases

### Data Ingestion
- Read from files, databases, message queues
- Parse and validate incoming data
- Handle errors and malformed data

### Stream Analytics
- Real-time aggregations (count, sum, average)
- Pattern detection
- Anomaly detection
- Correlation across multiple streams

### Data Transformation
- Filtering and enrichment
- Format conversion
- Data cleansing and normalization

### Output and Integration
- Write to files, databases, or external systems
- Send alerts and notifications
- Publish to message queues or REST APIs

## Best Practices

1. **Use Namespaces**: Organize code logically
2. **Parameterize Configuration**: Use submission-time parameters
3. **Handle Errors Gracefully**: Implement try-catch blocks
4. **Log Appropriately**: Use `appTrc()` with appropriate trace levels
5. **Optimize Windows**: Choose window types carefully for performance
6. **Consider Parallelism**: Use partitioning for scalability
7. **Document Code**: Add comments explaining business logic

## Troubleshooting

### Common Issues

**Issue**: Tuple type mismatch between operators
**Solution**: Ensure output schema of one operator matches input schema of the next

**Issue**: Window not producing results
**Solution**: Check window size and trigger conditions

**Issue**: Performance bottlenecks
**Solution**: Consider using partitioned windows or operator parallelism

### Debugging Tips

- Use `appTrc()` to log tuple values and processing steps
- Start with simple operators and add complexity gradually
- Test with small data sets before scaling up
- Check operator fusion settings for performance tuning

## Contributing

If you'd like to enhance this skill:

1. Add more example applications
2. Include additional operator patterns
3. Add troubleshooting scenarios
4. Update documentation links

## License

This skill is provided as-is for use with Claude Code and Teracloud Streams applications.

## Version

**Version**: 1.0.0
**Last Updated**: October 2025
**Compatible With**: Teracloud Streams 7.2.0+, IBM Streams 4.x+
