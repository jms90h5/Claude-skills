# IBM Streams Claude Skills

This directory contains Claude skills for IBM Streams development. These skills help developers create Streams applications, operators, and toolkits using best practices and real examples.

## Available Skills

### 1. Streams SPL Application Generator (`streams-spl-app.md`)
Creates complete SPL (Streams Processing Language) applications with proper structure, Makefiles, and configuration files.

**Use when you want to:**
- Create a new Streams application
- Build data processing pipelines
- Integrate multiple operators into a cohesive application

**Example prompts:**
- "Create a Streams SPL application that reads from Kafka and writes to a file"
- "Generate an SPL app that processes JSON data"
- "Build a streaming analytics application"

### 2. Java Primitive Operator Generator (`streams-java-operator.md`)
Creates IBM Streams primitive operators implemented in Java using the Java Operator API.

**Use when you want to:**
- Create custom operators in Java
- Integrate with Java libraries and frameworks
- Build source, transformation, or sink operators

**Example prompts:**
- "Create a Java source operator that reads from a REST API"
- "Generate a Java operator that filters tuples based on custom logic"
- "Build a Java operator with windowing support"

### 3. C++ Primitive Operator Generator (`streams-cpp-operator.md`)
Creates high-performance IBM Streams primitive operators implemented in C++ with code generation templates.

**Use when you want to:**
- Create high-performance operators
- Process data with minimal overhead
- Implement compute-intensive operations

**Example prompts:**
- "Create a C++ operator that processes network packets"
- "Generate a high-performance C++ transformation operator"
- "Build a C++ source operator with custom threading"

### 4. Python Primitive Operator Generator (`streams-python-operator.md`)
Creates IBM Streams primitive operators implemented in Python using decorators and the streamsx.spl API.

**Use when you want to:**
- Rapid prototyping of operators
- Use Python libraries (NumPy, pandas, scikit-learn, etc.)
- Implement machine learning or data science operations

**Example prompts:**
- "Create a Python operator that uses machine learning"
- "Generate a Python operator that processes JSON data"
- "Build a Python source operator that generates test data"

### 5. Streams Toolkit Generator (`streams-toolkit.md`)
Creates complete IBM Streams toolkits - reusable collections of operators, functions, and types.

**Use when you want to:**
- Package operators for reuse
- Create a library of Streams functionality
- Distribute operators to other developers

**Example prompts:**
- "Create a Streams toolkit for data transformation"
- "Generate a toolkit with Java and C++ operators"
- "Build a toolkit that wraps a REST API"

## Reference Materials

All skills have access to:

### Samples
The `samples/` directory contains 30+ Streams toolkit samples including:
- com.teracloud.streams.kafka - Kafka integration
- com.teracloud.streams.json - JSON processing
- com.teracloud.streams.network - Network packet processing
- com.teracloud.streams.geospatial - Geospatial operations
- com.teracloud.streams.hbase - HBase integration
- com.teracloud.streams.hdfs - HDFS file operations
- And many more...

### Documentation
The `streams_docs/` directory contains comprehensive documentation:
- **3,000+ HTML files** covering all aspects of Streams development
  - Application development guides
  - Operator implementation references
  - Toolkit creation documentation
  - API references and examples
  - Best practices and performance tuning

- **IBM Redbooks (PDF)** - Comprehensive reference guides
  - **Stream1.0Redbook_sg248108.pdf** (8.6MB) - IBM Streams Version 1.0
  - **Streams2.0Redbook.pdf** (9.0MB) - IBM Streams Version 2.0
  - In-depth coverage of architecture, development, and deployment
  - Real-world use cases and implementation patterns

## How to Use These Skills

### With Claude Code CLI
If these skills are integrated with Claude Code, they will be automatically available when working on Streams projects.

### As Reference Documents
You can share these skill files directly with Claude in any conversation to get assistance with Streams development.

### Example Usage

```
User: I need to create a Streams application that reads Twitter data,
filters tweets by keyword, and writes results to Kafka.

Claude: [Uses streams-spl-app.md skill to generate the application with
proper structure, including source operators, filtering logic, and Kafka sink]

User: Now I need a custom Java operator that enriches the tweets with
sentiment analysis.

Claude: [Uses streams-java-operator.md skill to create a Java operator
that integrates with a sentiment analysis library]

User: Finally, package everything into a reusable toolkit.

Claude: [Uses streams-toolkit.md skill to create a complete toolkit
structure with proper versioning and documentation]
```

## Skill Features

Each skill provides:

1. **Templates and Examples**: Real code from the samples directory
2. **Best Practices**: IBM Streams development guidelines
3. **Complete Structures**: Full directory layouts and build files
4. **Documentation References**: Links to relevant documentation
5. **Step-by-Step Instructions**: Clear guidance for common tasks
6. **Type Mappings**: SPL to Java/C++/Python type conversions
7. **Troubleshooting**: Common issues and solutions

## Skill Development

These skills are based on:
- Real samples from IBM Streams toolkits
- Official IBM Streams documentation
- Best practices from production deployments
- Common development patterns and idioms

## Updates and Maintenance

To update these skills with new samples or documentation:
1. Add new samples to the `samples/` directory
2. Update documentation in `streams_docs/`
3. Regenerate skills or manually update with new patterns
4. Test skills with real development scenarios

## Contributing

When adding new skills or updating existing ones:
- Include real, working examples from samples
- Reference official documentation
- Follow the existing skill structure
- Test the generated code
- Update this README with new skills

## Resources

- **Samples**: `../samples/` - 30+ toolkit examples
- **Documentation**: `../streams_docs/` - Complete API and guide documentation
- **IBM Streams**: https://www.ibm.com/products/streams
- **Teracloud Streams**: For additional resources and support

## License

These skills are based on IBM Streams samples and documentation. Refer to individual sample licenses for usage terms.
