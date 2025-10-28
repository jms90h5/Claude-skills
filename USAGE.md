# Using Claude Skills for IBM Streams Development

This guide explains how to use the Claude skills in different scenarios.

## Scenario 1: Working in This Repository

If you're working directly in the `Claude-skills` repository, the skills are already set up and ready to use!

### What's Already Configured

The repository includes a `.claude/skills` symlink that points to the `skills/` directory. This means Claude Code automatically finds and uses the skills when you're in this repository.

### How to Use

1. **Open Claude Code in this repository:**
   ```bash
   cd /path/to/Claude-skills
   # Claude Code should already be running, or start it
   ```

2. **Ask Claude to use the skills:**
   ```
   "Create a Streams SPL application that reads from Kafka"
   "Generate a Java operator that filters data"
   "Build a Python operator for machine learning"
   "Create a complete toolkit for data transformation"
   ```

3. **Claude will automatically:**
   - Reference the skill files in `skills/`
   - Use examples from `samples/`
   - Consult documentation in `streams_docs/`
   - Reference the IBM Redbooks

## Scenario 2: Working in Another Project

If you want to use these skills in a different project (e.g., your own Streams application), you have several options:

### Option A: Symlink to Skills (Recommended)

Create a symlink in your project:

```bash
cd /path/to/your-streams-project
mkdir -p .claude
ln -s /path/to/Claude-skills/skills .claude/skills
```

### Option B: Copy Skills to Your Project

Copy the skills directory:

```bash
cd /path/to/your-streams-project
mkdir -p .claude
cp -r /path/to/Claude-skills/skills .claude/
```

### Option C: Global Skills Installation

Install skills globally for all projects:

```bash
mkdir -p ~/.claude/skills
cp /path/to/Claude-skills/skills/* ~/.claude/skills/
```

Or with a symlink:
```bash
mkdir -p ~/.claude
ln -s /path/to/Claude-skills/skills ~/.claude/skills
```

### Option D: Reference Skills Manually

In any Claude Code session, you can manually share a skill:

```
"I need help creating a Streams application. Here's a skill that can help:"
[Paste contents of skills/streams-spl-app.md]
```

## Scenario 3: Dev Container Setup

If you're working in a dev container:

### 1. Mount the Skills in Your Dev Container

Add to your `.devcontainer/devcontainer.json`:

```json
{
  "name": "Streams Development",
  "mounts": [
    "source=/path/to/Claude-skills,target=/workspace/claude-skills,type=bind"
  ],
  "postCreateCommand": "ln -sf /workspace/claude-skills/skills ~/.claude/skills"
}
```

### 2. Or Clone This Repository in the Container

```bash
# In your dev container
git clone https://github.com/your-org/Claude-skills.git ~/claude-skills
mkdir -p ~/.claude
ln -s ~/claude-skills/skills ~/.claude/skills
```

## How to Verify Skills Are Available

Check if Claude Code can see the skills:

```bash
# List skills directory
ls -la .claude/skills/

# Should show:
# README.md
# streams-spl-app.md
# streams-java-operator.md
# streams-cpp-operator.md
# streams-python-operator.md
# streams-toolkit.md
```

## Using Skills in Claude Code

### Explicit Skill Invocation

You can explicitly mention the skill you want to use:

```
"Using the streams-spl-app skill, create an application that..."
"Use the streams-java-operator skill to generate a source operator"
```

### Implicit Skill Usage

Claude Code will automatically use relevant skills based on your request:

```
"Create a Streams application"          → Uses streams-spl-app.md
"Build a Java operator"                 → Uses streams-java-operator.md
"Create a high-performance C++ operator" → Uses streams-cpp-operator.md
"Generate a Python ML operator"         → Uses streams-python-operator.md
"Package operators into a toolkit"      → Uses streams-toolkit.md
```

## Example Workflows

### Create a New Streams Application

```
User: Create a Streams application that:
- Reads JSON data from a file
- Parses and validates it
- Writes results to Kafka

Claude: [Uses streams-spl-app.md skill]
I'll create a complete SPL application for you...
[Generates Main.spl, Makefile, etc.]
```

### Add a Custom Operator

```
User: I need a Java operator that calls a REST API to enrich data

Claude: [Uses streams-java-operator.md skill]
I'll create a Java primitive operator for REST API enrichment...
[Generates operator model XML, Java class, build.xml]
```

### Package as a Toolkit

```
User: Package these operators into a reusable toolkit

Claude: [Uses streams-toolkit.md skill]
I'll create a complete toolkit structure...
[Generates toolkit.xml, directory structure, Makefile]
```

## Access to Samples and Documentation

When working in or referencing the Claude-skills repository, Claude has access to:

### Samples (samples/)
- 30+ complete toolkit samples
- Real working code examples
- Best practices implementations

### Documentation (streams_docs/)
- 3,000+ HTML documentation files
- IBM Redbooks (PDFs)
- Complete API references

### Usage in Skills

The skills automatically reference:
```
"Based on samples/com.teracloud.streams.kafka/KafkaSample/..."
"See streams_docs/com.ibm.streams.dev.doc/doc/..."
"Refer to Stream1.0Redbook_sg248108.pdf for..."
```

## Troubleshooting

### Skills Not Found

If Claude doesn't seem to use the skills:

1. **Check symlink exists:**
   ```bash
   ls -la .claude/skills
   ```

2. **Verify skills directory:**
   ```bash
   ls .claude/skills/
   ```

3. **Check path is correct:**
   ```bash
   readlink .claude/skills
   ```

4. **Try explicit mention:**
   ```
   "Using the skills in .claude/skills/, help me create..."
   ```

### Samples/Docs Not Accessible

If working outside the Claude-skills repository:

1. **Clone or mount the repository:**
   ```bash
   git clone <repo-url> ~/claude-skills
   ```

2. **Reference explicitly:**
   ```
   "Use examples from ~/claude-skills/samples/..."
   ```

## Tips for Best Results

1. **Be Specific**: Mention what you want to build
   - ✅ "Create a Java source operator that reads from MySQL"
   - ❌ "Create an operator"

2. **Reference Samples**: Mention similar examples
   - "Like the Kafka sample, but for PostgreSQL"

3. **Specify Requirements**: List your needs
   - "Include error handling"
   - "Add metrics"
   - "Support checkpointing"

4. **Iterative Development**: Build incrementally
   - Start with basic structure
   - Add features one at a time
   - Test between changes

## Environment Setup

### Required Tools

For generated code to work, ensure you have:

```bash
# IBM Streams or Teracloud Streams
export STREAMS_INSTALL=/path/to/streams

# Java (for Java operators)
java -version  # Should be 8+

# C++ compiler (for C++ operators)
g++ --version  # Should support C++11

# Python (for Python operators)
python3 --version  # Should be 3.6+
```

### Environment Variables

```bash
# Add to ~/.bashrc or ~/.zshrc
export STREAMS_INSTALL=/path/to/streams
export PATH=$STREAMS_INSTALL/bin:$PATH
export STREAMS_SPLPATH=/path/to/toolkits:$STREAMS_SPLPATH
```

## Next Steps

1. **Try the examples** in this document
2. **Explore the samples** directory for inspiration
3. **Read the skills** to understand what they provide
4. **Start building** your Streams applications!

## Getting Help

- Check `skills/README.md` for skill descriptions
- Review samples in `samples/`
- Consult documentation in `streams_docs/`
- Read the Redbooks for in-depth guidance

Happy Streams development! 🚀
