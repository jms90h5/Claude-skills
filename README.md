# Claude Skills for Development

A collection of specialized skills for Claude Code to assist with various development tasks. These skills extend Claude's capabilities by providing domain-specific expertise, templates, and best practices.

## What are Claude Skills?

Claude Skills are specialized knowledge modules that enhance Claude Code's ability to help with specific technologies, frameworks, or domains. Each skill contains:

- Domain expertise and best practices
- Code templates and examples
- Documentation references
- Common patterns and anti-patterns
- Troubleshooting guides

## Available Skills

### SPL Streams Application Builder

**Location**: `skills/spl-streams/`

A comprehensive skill for creating Teracloud Streams (formerly IBM Streams) applications using Stream Processing Language (SPL).

**Features**:
- Complete SPL language reference
- Common operator patterns
- Application templates (ETL, analytics, file processing)
- Window-based processing examples
- Stream joins and aggregations
- Real-time analytics patterns
- Best practices and optimization tips

**Use Cases**:
- Real-time data processing
- Stream analytics and monitoring
- ETL pipelines
- Event processing
- Time-series analysis

**Documentation**: See [skills/spl-streams/README.md](skills/spl-streams/README.md)

**Quick Reference**: See [skills/spl-streams/QUICKREF.md](skills/spl-streams/QUICKREF.md)

## Repository Structure

```
Claude-skills/
├── README.md                           # This file
├── skills/                             # Skills directory
│   └── spl-streams/                    # SPL Streams skill
│       ├── skill.md                    # Skill prompt/implementation
│       ├── README.md                   # Skill documentation
│       ├── QUICKREF.md                 # Quick reference guide
│       └── examples/                   # Example applications
│           ├── 01-hello-world.spl
│           ├── 02-file-processing.spl
│           ├── 03-realtime-analytics.spl
│           ├── 04-stream-join.spl
│           └── 05-etl-pipeline.spl
```

## Using Skills with Claude Code

### Method 1: Direct Reference

Simply mention the skill in your conversation:

```
"Use the SPL Streams skill to help me create a real-time analytics application"
```

### Method 2: Load Skill Content

Claude can read the skill files directly from this repository:

```
"Read the SPL streams skill and help me build a file processing pipeline"
```

### Method 3: Reference Examples

Point to specific examples:

```
"Look at the realtime-analytics.spl example and help me modify it for my use case"
```

## Skill Development

### Creating a New Skill

1. **Create skill directory**:
   ```bash
   mkdir -p skills/my-new-skill
   ```

2. **Create skill.md** with the skill prompt and expertise

3. **Add README.md** with documentation:
   - Overview and features
   - Usage instructions
   - Examples
   - Best practices
   - References

4. **Include examples** in an `examples/` subdirectory

5. **Add a quick reference** (optional but recommended)

### Skill Structure Guidelines

A well-designed skill should include:

1. **Core Expertise**:
   - Language/framework fundamentals
   - Common patterns and idioms
   - Best practices

2. **Practical Examples**:
   - Hello World / Getting Started
   - Common use cases
   - Advanced patterns

3. **References**:
   - Official documentation links
   - Community resources
   - Related tooling

4. **Interaction Guidelines**:
   - How to help users effectively
   - What questions to ask
   - How to structure responses

### Skill Template

See `skills/spl-streams/` as a reference implementation.

## Contributing

We welcome contributions of new skills! Areas of interest:

- Programming languages (Python, Go, Rust, etc.)
- Frameworks (React, Django, Express, etc.)
- Cloud platforms (AWS, Azure, GCP)
- Databases (PostgreSQL, MongoDB, Redis, etc.)
- DevOps tools (Docker, Kubernetes, Terraform, etc.)
- Data processing (Spark, Kafka, Airflow, etc.)
- Machine Learning (TensorFlow, PyTorch, scikit-learn, etc.)

### Contribution Guidelines

1. Follow the skill structure outlined above
2. Include comprehensive examples
3. Provide working code that users can copy and use
4. Reference official documentation
5. Test your skill by using it with Claude Code
6. Update this README with your new skill

## Skill Ideas

Some skills we'd love to see:

- [ ] Apache Kafka application development
- [ ] Kubernetes manifest creation
- [ ] Terraform infrastructure as code
- [ ] React component development
- [ ] Python data science workflows
- [ ] SQL query optimization
- [ ] Docker containerization
- [ ] CI/CD pipeline creation
- [ ] REST API design
- [ ] GraphQL schema development
- [ ] Apache Spark applications
- [ ] Machine learning model deployment

## License

This repository is provided as-is for use with Claude Code. Individual skills may reference external documentation and resources which have their own licenses.

## Feedback and Support

For issues or suggestions:
- Open an issue in this repository
- Contribute improvements via pull requests
- Share your own skills with the community

## Related Resources

- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- [Teracloud Streams Documentation](https://doc.streams.teracloud.com/)
- [IBM Streams Resources](http://ibmstreams.github.io/)

---

**Version**: 1.0.0
**Last Updated**: October 2025
