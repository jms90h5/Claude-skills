# Claude-skills for IBM Streams

This repository contains Claude skills for IBM Streams development, along with comprehensive samples and documentation.

## Overview

This project provides AI-assisted development tools for IBM Streams through Claude skills. These skills help developers create Streams applications, operators, and toolkits using best practices and real-world examples.

## Repository Contents

### 📚 Skills (`skills/`)
Five comprehensive Claude skills for Streams development:
- **streams-spl-app.md**: Create SPL applications
- **streams-java-operator.md**: Create Java primitive operators
- **streams-cpp-operator.md**: Create C++ primitive operators
- **streams-python-operator.md**: Create Python primitive operators
- **streams-toolkit.md**: Create complete Streams toolkits

See [skills/README.md](skills/README.md) for detailed information about each skill.

### 📁 Samples (`samples/`)
30+ complete Streams toolkit samples including:
- Kafka integration
- JSON processing
- Network packet processing
- Geospatial operations
- HBase and HDFS integration
- WebSocket and REST APIs
- And many more...

### 📖 Documentation (`streams_docs/`)
Complete IBM Streams documentation:
- **3,000+ HTML files**: API references, guides, and examples
- **IBM Redbooks (PDF)**: Comprehensive reference guides
  - Stream1.0Redbook_sg248108.pdf (8.6MB) - IBM Streams Version 1.0
  - Streams2.0Redbook.pdf (9.0MB) - IBM Streams Version 2.0
  - In-depth architecture, development patterns, and deployment strategies
- Application development guides
- Operator implementation references
- Toolkit creation documentation
- Performance tuning and best practices

## Quick Start

### Using the Skills

1. **With Claude Code**: These skills can be integrated with Claude Code for automatic assistance during Streams development.

2. **As Reference**: Share skill files with Claude in any conversation for Streams development help.

3. **Example Workflow**:
   ```
   1. Use streams-spl-app.md to create your application structure
   2. Use operator skills to create custom operators
   3. Use streams-toolkit.md to package for reuse
   ```

### Exploring Samples

Browse the samples directory to find examples for your use case:
```bash
cd samples/
ls com.teracloud.streams.*
```

Each sample includes:
- Complete source code
- Makefile for building
- README with usage instructions
- Sample data and configuration files

### Accessing Documentation

The `streams_docs/` directory contains comprehensive documentation organized by topic:
- `com.ibm.streams.dev.doc/` - Development documentation
- `com.ibm.streams.admin.doc/` - Administration documentation
- `com.ibm.streams.ref.doc/` - API references
- `com.ibm.streams.toolkits.doc/` - Toolkit documentation

## What You Can Build

With these skills, you can create:

- **Stream Processing Applications**: Real-time data processing pipelines
- **Custom Operators**: Java, C++, or Python operators for specific tasks
- **Data Integration**: Connect to Kafka, databases, files, APIs
- **Analytics**: Real-time analytics, machine learning, complex event processing
- **Toolkits**: Reusable operator libraries for your organization

## Example Use Cases

### Create a Real-Time Analytics Application
```
User: Create a Streams application that:
- Reads sensor data from Kafka
- Filters by threshold values
- Calculates moving averages
- Writes alerts to a database
```

### Build a Custom Operator
```
User: Create a Java operator that:
- Calls a REST API to enrich data
- Caches results to improve performance
- Handles errors gracefully
- Supports configurable timeouts
```

### Package a Toolkit
```
User: Create a toolkit for our data quality operators:
- Include validation operators
- Add data cleansing operators
- Package with documentation
- Version for distribution
```

## Skills Features

Each skill provides:
- ✅ Real, working code examples from samples
- ✅ Complete directory structures
- ✅ Build files (Makefile, build.xml)
- ✅ Documentation and comments
- ✅ Type mappings and API references
- ✅ Best practices and patterns
- ✅ Testing and deployment guidance

## Technology Stack

- **IBM Streams**: Stream processing platform
- **SPL (Streams Processing Language)**: Primary application language
- **Java**: For business logic operators
- **C++**: For high-performance operators
- **Python**: For rapid development and ML integration
- **Claude AI**: For intelligent code generation

## Project Structure

```
Claude-skills/
├── README.md                  # This file
├── skills/                    # Claude skills for Streams development
│   ├── README.md             # Skills documentation
│   ├── streams-spl-app.md
│   ├── streams-java-operator.md
│   ├── streams-cpp-operator.md
│   ├── streams-python-operator.md
│   └── streams-toolkit.md
├── samples/                   # 30+ Streams toolkit samples
│   ├── com.teracloud.streams.kafka/
│   ├── com.teracloud.streams.json/
│   ├── com.teracloud.streams.network/
│   └── ... (27 more toolkits)
└── streams_docs/              # Complete Streams documentation
    ├── com.ibm.streams.dev.doc/
    ├── com.ibm.streams.admin.doc/
    ├── com.ibm.streams.ref.doc/
    └── ... (more doc categories)
```

## Contributing

To contribute to this project:

1. Add new samples to `samples/`
2. Update documentation in `streams_docs/`
3. Enhance skills in `skills/`
4. Test with real Streams deployments
5. Submit pull requests

## Requirements

To use the generated code, you need:
- IBM Streams or Teracloud Streams (4.0+)
- Java JDK 8+ (for Java operators)
- C++ compiler with C++11 support (for C++ operators)
- Python 3.6+ (for Python operators)

## Resources

- **IBM Streams Documentation**: Included in `streams_docs/`
- **Samples**: Included in `samples/`
- **IBM Streams**: https://www.ibm.com/products/streams
- **Teracloud Streams**: For additional resources and support

## License

This project includes samples and documentation from IBM Streams. Refer to individual files for specific license information.

## Support

For issues or questions:
- Check the documentation in `streams_docs/`
- Review similar examples in `samples/`
- Consult the skill files in `skills/`
- Refer to IBM Streams official documentation

## Acknowledgments

- IBM Streams team for the platform and documentation
- Teracloud ApS for Streams samples and extensions
- Claude AI by Anthropic for intelligent development assistance

---

**Note**: This project provides AI-assisted development tools and references. Always review and test generated code before deploying to production.
