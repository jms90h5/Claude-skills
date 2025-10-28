# Getting Started with SPL Streams

This guide will help you get started with the SPL Streams skill and create your first Teracloud Streams application.

## Prerequisites

Before using this skill, you should have:

1. **Teracloud Streams** installed (version 7.1.0 or later)
   - Download from: https://streams.teracloud.com/downloads/streams-studio

2. **Basic understanding** of:
   - Stream processing concepts
   - Programming fundamentals
   - Data flow concepts

3. **Development environment**:
   - Text editor or IDE
   - Command line access
   - Java Runtime Environment (required by Streams)

## Installation Options

### Option 1: Teracloud Streams (Recommended)

Teracloud Streams is the modern evolution of IBM Streams with enhanced features and support.

1. Visit https://streams.teracloud.com/
2. Download Streams Studio for your platform
3. Follow the installation guide

### Option 2: IBM Streams

If you have access to IBM Streams 4.x:

1. Install IBM Streams from IBM Fix Central
2. Configure your environment
3. Install Streams Studio IDE

## Your First SPL Application

### Step 1: Create a Workspace

```bash
mkdir -p ~/streams-projects/hello-world
cd ~/streams-projects/hello-world
```

### Step 2: Create Your SPL File

Create a file named `HelloWorld.spl`:

```spl
namespace examples.hello;

composite HelloWorld {
    graph
        stream<rstring message> Greetings = Beacon() {
            param
                iterations: 5u;
            output
                Greetings: message = "Hello from SPL!";
        }

        () as Printer = Custom(Greetings) {
            logic
                onTuple Greetings: {
                    printStringLn(message);
                }
        }
}
```

### Step 3: Compile the Application

```bash
sc -M HelloWorld.spl -a
```

This creates a Streams Application Bundle (SAB file) in the `output` directory.

### Step 4: Run the Application

#### Standalone Mode (Quick Testing)
```bash
output/bin/standalone
```

#### Distributed Mode (Production)
```bash
streamtool submitjob output/HelloWorld.sab -d <domain> -i <instance>
```

### Step 5: Verify Output

You should see:
```
Hello from SPL!
Hello from SPL!
Hello from SPL!
Hello from SPL!
Hello from SPL!
```

## Using Claude with SPL Skills

### Example Conversation Flow

**You**: "I need help creating an SPL application that reads CSV files and calculates averages"

**Claude** (using SPL Streams skill):
1. Asks clarifying questions about your data
2. Suggests appropriate operators (FileSource, Aggregate)
3. Provides complete working code
4. Explains key concepts
5. Suggests best practices

### Common Requests

Here are some ways to engage the SPL skill:

1. **Create from scratch**:
   - "Help me create an SPL app that processes stock trades"
   - "I need a real-time analytics pipeline for sensor data"

2. **Modify existing code**:
   - "Add error handling to this SPL application"
   - "How can I optimize this aggregation?"

3. **Understand concepts**:
   - "Explain how tumbling windows work in SPL"
   - "What's the difference between Functor and Custom operators?"

4. **Debug issues**:
   - "Why isn't my join producing results?"
   - "How do I handle null values in SPL?"

5. **Learn patterns**:
   - "Show me how to implement an ETL pipeline"
   - "What's the best way to handle late-arriving data?"

## Learning Path

### Beginner Level

1. **Start with examples**:
   - Run `01-hello-world.spl`
   - Modify parameters and observe changes
   - Add logging statements

2. **Basic operators**:
   - Learn Beacon, FileSource, FileSink
   - Understand Custom operator
   - Try Filter and Functor

3. **Simple applications**:
   - Read a file and print contents
   - Filter data based on conditions
   - Write results to output file

### Intermediate Level

1. **Windowing**:
   - Implement tumbling windows
   - Try sliding windows
   - Understand partitioning

2. **Aggregations**:
   - Calculate averages, sums, counts
   - Group by key fields
   - Handle time-based windows

3. **Type system**:
   - Define custom types
   - Work with lists and maps
   - Handle nested structures

### Advanced Level

1. **Stream joins**:
   - Inner joins
   - Outer joins
   - Multi-way joins

2. **Performance tuning**:
   - Operator fusion
   - Parallel channels
   - Buffer management

3. **Complex patterns**:
   - Pattern detection
   - State management
   - Late data handling

## Example Workflows

### Workflow 1: File Processing

```
Read CSV → Parse → Validate → Filter → Transform → Write Results
```

See: `examples/02-file-processing.spl`

### Workflow 2: Real-Time Analytics

```
Data Stream → Window → Aggregate → Alert on Threshold → Dashboard
```

See: `examples/03-realtime-analytics.spl`

### Workflow 3: ETL Pipeline

```
Multiple Sources → Clean → Enrich → Aggregate → Multiple Outputs
```

See: `examples/05-etl-pipeline.spl`

## Common Pitfalls and Solutions

### Pitfall 1: Type Mismatches

**Problem**: Output type doesn't match input type of next operator

**Solution**: Use explicit type declarations and Functor to transform

```spl
stream<rstring name, int32 age> Output = Functor(Input) {
    output
        Output:
            name = Input.fullName,
            age = (int32)Input.years;
}
```

### Pitfall 2: Empty Windows

**Problem**: Aggregation produces no results

**Solution**: Check window size and ensure data is arriving

```spl
// Add logging to debug
() as Debug = Custom(Input) {
    logic
        state: { mutable int32 count = 0; }
        onTuple Input: {
            count++;
            printStringLn("Received tuple #" + (rstring)count);
        }
}
```

### Pitfall 3: File Not Found

**Problem**: FileSource can't find input file

**Solution**: Use absolute paths or getApplicationDir()

```spl
stream<...> Data = FileSource() {
    param
        file: getApplicationDir() + "/data/input.csv";
}
```

## Resources

### Documentation
- [Teracloud Streams Docs](https://doc.streams.teracloud.com/)
- [Quick Reference](QUICKREF.md)
- [Skill Documentation](README.md)

### Examples
- All examples in `examples/` directory
- IBM Streams samples: http://ibmstreams.github.io/streamsx.documentation/samples/

### Community
- Teracloud Streams support
- IBM Streams forums
- Stack Overflow (tag: ibm-streams)

## Next Steps

1. **Run all examples**: Go through each example in order
2. **Modify examples**: Change parameters, add operators, experiment
3. **Build your own**: Start with a simple use case from your domain
4. **Optimize**: Learn about performance tuning and best practices
5. **Share**: Contribute your own patterns and examples

## Getting Help

When asking Claude for help:

1. **Be specific**: Describe your data and requirements
2. **Share context**: Show existing code if modifying
3. **State your goal**: What should the application do?
4. **Mention constraints**: Performance, latency, data volume
5. **Ask questions**: Don't hesitate to ask about concepts

Example good request:

> "I have a CSV file with columns: timestamp, sensor_id, temperature, humidity.
> I need an SPL application that:
> 1. Reads the file
> 2. Calculates average temperature per sensor over 5-minute windows
> 3. Generates alerts when temperature exceeds 100
> 4. Writes results to an output file
>
> Can you help me build this?"

## Troubleshooting

### Compilation Errors

```bash
# Enable verbose output
sc -M MyApp.spl -a --verbose-mode

# Check toolkit paths
sc -M MyApp.spl -a -t /path/to/toolkits
```

### Runtime Errors

```bash
# View application logs
streamtool getlog -d domain -i instance --job 0

# Check job health
streamtool lsjobs -d domain -i instance

# Cancel stuck job
streamtool canceljob -d domain -i instance --job 0
```

### Performance Issues

- Check operator metrics
- Review window sizes
- Consider partitioning
- Enable operator fusion

## Ready to Build?

You're now ready to start building SPL applications! Start with the examples, experiment with modifications, and don't hesitate to ask Claude for help.

**Happy streaming!**
