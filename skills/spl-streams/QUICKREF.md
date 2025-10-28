# SPL Quick Reference Guide

A concise reference for Stream Processing Language (SPL) syntax and common patterns.

## Basic Structure

```spl
namespace com.example.app;

use spl.file::*;  // Import toolkit

composite MyApp {
    param
        expression<rstring> $configParam : "defaultValue";

    graph
        // Define stream processing graph here
}
```

## Type Definitions

### Built-in Types
- `rstring` - Variable-length string
- `int32`, `int64` - Integers
- `float32`, `float64` - Floating point
- `boolean` - Boolean
- `timestamp` - Timestamp
- `blob` - Binary data

### Custom Types
```spl
type Person =
    rstring name,
    int32 age,
    float64 salary;

type Location =
    float64 latitude,
    float64 longitude;
```

## Stream Declaration

```spl
stream<rstring name, int32 value> MyStream = Operator() {
    // operator configuration
}
```

## Common Operators

### Beacon (Generate Data)
```spl
stream<int32 id> Numbers = Beacon() {
    param
        iterations: 100u;      // Generate 100 tuples
        period: 1.0;           // Every 1 second
    output
        Numbers: id = (int32)IterationCount();
}
```

### FileSource (Read Files)
```spl
stream<rstring line> Lines = FileSource() {
    param
        file: "input.txt";
        format: line;          // or csv, bin
}
```

### FileSink (Write Files)
```spl
() as Writer = FileSink(MyStream) {
    param
        file: "output.csv";
        format: csv;
        flush: 1u;             // Flush frequency
}
```

### Filter (Filter Tuples)
```spl
stream<...> Filtered = Filter(Input) {
    param
        filter: value > 100 && status == "active";
}
```

### Functor (Transform)
```spl
stream<rstring name, int32 doubled> Transformed = Functor(Input) {
    output
        Transformed:
            name = upper(Input.name),
            doubled = Input.value * 2;
}
```

### Custom (Custom Logic)
```spl
stream<...> Output = Custom(Input) {
    logic
        state: {
            mutable int32 counter = 0;
        }

        onTuple Input: {
            counter++;
            if (Input.value > 0) {
                submit({...}, Output);
            }
        }

        onPunct Input: {
            if (currentPunct() == Sys.FinalMarker) {
                // Finalization logic
            }
        }
}
```

### Aggregate (Aggregations)
```spl
stream<rstring key, float64 avg, int32 count> Stats = Aggregate(Input) {
    window
        Input: tumbling, time(60.0), partitioned;
    param
        partitionBy: key;
    output
        Stats:
            avg = Average(value),
            count = Count(),
            total = Sum(value),
            minVal = Min(value),
            maxVal = Max(value);
}
```

### Join (Join Streams)
```spl
stream<...> Joined = Join(StreamA; StreamB) {
    window
        StreamA: sliding, count(100);
        StreamB: sliding, count(100);
    param
        match: StreamA.id == StreamB.id;
        algorithm: inner;      // or leftOuter, rightOuter, fullOuter
}
```

### Split (Route Tuples)
```spl
(stream<...> HighValue; stream<...> LowValue) = Split(Input) {
    param
        index: (value > 1000) ? 0 : 1;
}
```

## Window Types

### Tumbling (Non-overlapping)
```spl
window
    Input: tumbling, time(60.0);      // 60 second windows
    Input: tumbling, count(1000);     // 1000 tuple windows
```

### Sliding (Overlapping)
```spl
window
    Input: sliding, time(300.0), delta(60.0);  // 5 min window, 1 min slide
    Input: sliding, count(1000), delta(100);    // 1000 tuples, slide 100
```

### Partitioned
```spl
window
    Input: tumbling, time(60.0), partitioned;
param
    partitionBy: userId;
```

## Common Functions

### String Functions
- `upper(str)`, `lower(str)` - Case conversion
- `length(str)` - String length
- `substring(str, start, len)` - Substring
- `csvTokenize(str)` - Parse CSV
- `concat(str1, str2)` - Concatenate

### Math Functions
- `abs(x)` - Absolute value
- `sqrt(x)` - Square root
- `pow(x, y)` - Power
- `max(a, b)`, `min(a, b)` - Min/max
- `random()` - Random [0, 1)

### Time Functions
- `getTimestamp()` - Current timestamp
- `ctime(timestamp)` - Format timestamp
- `getSeconds(timestamp)` - Extract seconds

### Aggregate Functions (in Aggregate operator)
- `Average(attr)` - Average
- `Sum(attr)` - Sum
- `Count()` - Count tuples
- `Min(attr)`, `Max(attr)` - Min/max
- `First(attr)`, `Last(attr)` - First/last value

### Collection Functions
- `size(list)` - List size
- `has(map, key)` - Check map key
- `clearM(map)` - Clear map

## Parameters

### Submission-Time Parameters
```spl
param
    expression<rstring> $inputFile : getSubmissionTimeValue("inputFile", "default.csv");
    expression<int32> $threshold : (int32)getSubmissionTimeValue("threshold", "100");
```

Usage:
```bash
streamtool submitjob MyApp.sab -P inputFile=data.csv -P threshold=200
```

## Logic Sections

### State Variables
```spl
logic
    state: {
        mutable int32 counter = 0;
        mutable map<rstring, float64> cache;
        mutable list<rstring> buffer;
    }
```

### Tuple Processing
```spl
onTuple Input: {
    // Process tuple
    submit({...}, Output);
}
```

### Punctuation Handling
```spl
onPunct Input: {
    if (currentPunct() == Sys.WindowMarker) {
        // Window ended
    }
    if (currentPunct() == Sys.FinalMarker) {
        // Stream ended
    }
}
```

## Logging and Debugging

### Application Tracing
```spl
appTrc(Trace.error, "Error message");
appTrc(Trace.warn, "Warning message");
appTrc(Trace.info, "Info message");
appTrc(Trace.debug, "Debug message");
```

### Console Output
```spl
printStringLn("Message: " + (rstring)value);
```

## Error Handling

```spl
try {
    // Risky operation
    float64 result = (float64)inputString;
} catch (Exception e) {
    appTrc(Trace.error, "Parse error: " + e);
}
```

## Compilation and Execution

### Compile
```bash
sc -M MyApp.spl -t /path/to/toolkits
```

### Submit Job
```bash
streamtool submitjob output/MyApp.sab -d domain -i instance
```

### Cancel Job
```bash
streamtool canceljob -d domain -i instance --job 0
```

### View Logs
```bash
streamtool getlog -d domain -i instance --job 0
```

## Best Practices

1. **Use namespaces** to organize code
2. **Parameterize configuration** with submission-time values
3. **Handle errors** with try-catch blocks
4. **Log appropriately** using `appTrc()` with correct levels
5. **Choose window types carefully** for performance
6. **Use partitioning** for parallel processing
7. **Flush sinks appropriately** for latency vs throughput
8. **Comment complex logic** for maintainability
9. **Test with small data** before scaling up
10. **Monitor performance** and tune as needed

## Documentation Links

- Teracloud Streams: https://doc.streams.teracloud.com/
- IBM Streams Samples: http://ibmstreams.github.io/streamsx.documentation/samples/
- Tutorials: https://ibmstreams.github.io/tutorials/

## Common Patterns

### Read → Transform → Write
```spl
stream<...> Input = FileSource() {...}
stream<...> Processed = Functor(Input) {...}
() as Output = FileSink(Processed) {...}
```

### Filter → Aggregate → Alert
```spl
stream<...> Filtered = Filter(Input) {...}
stream<...> Stats = Aggregate(Filtered) {...}
stream<...> Alerts = Filter(Stats) {...}
```

### Join → Enrich → Output
```spl
stream<...> Joined = Join(StreamA; StreamB) {...}
stream<...> Enriched = Functor(Joined) {...}
() as Output = FileSink(Enriched) {...}
```

### Split → Process → Merge
```spl
(stream<...> PathA; stream<...> PathB) = Split(Input) {...}
stream<...> ProcessedA = Functor(PathA) {...}
stream<...> ProcessedB = Functor(PathB) {...}
stream<...> Merged = Custom(ProcessedA, ProcessedB) {...}
```
