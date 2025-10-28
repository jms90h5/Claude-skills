# Installing Skills on Your Local Machine

## Quick Install (One Command)

On your local machine where Claude Code CLI is installed:

```bash
# Clone this repository
git clone <your-repo-url> ~/claude-skills

# Run the installer
cd ~/claude-skills
./install-local.sh
```

The installer will:
- Create `~/.claude/skills/` directory
- Copy or symlink all 5 skills
- Make them available to Claude Code

## Manual Install

If you prefer manual installation:

```bash
# On your local machine
mkdir -p ~/.claude/skills
cd ~/claude-skills/skills
cp *.md ~/.claude/skills/
```

## Using Skills After Installation

With skills installed in `~/.claude/skills/`, you can reference them in Claude Code:

### Option 1: Explicit Reference
```
"Using the guidance in ~/.claude/skills/streams-spl-app.md,
create a Streams application that reads from Kafka"
```

### Option 2: Ask Claude to Read It
```
"Read the streams-spl-app skill and help me create a Streams application"
```

### Option 3: Paste Skill Name in Context
```
"I need help with IBM Streams. Use the streams-java-operator skill
to create a Java operator that..."
```

## What Gets Installed

Five comprehensive skills:
- `streams-spl-app.md` - SPL application generator
- `streams-java-operator.md` - Java operator generator
- `streams-cpp-operator.md` - C++ operator generator
- `streams-python-operator.md` - Python operator generator
- `streams-toolkit.md` - Toolkit generator

Each skill includes:
- Complete templates and examples
- Real code from 30+ sample toolkits
- API references and best practices
- Links to 3,000+ documentation files
- IBM Redbooks references

## Keeping Skills Updated

### If You Used Symlinks (Recommended)
```bash
cd ~/claude-skills
git pull
# Skills automatically update!
```

### If You Copied Files
```bash
cd ~/claude-skills
git pull
./install-local.sh
# Choose option 2 to re-copy
```

## Accessing Samples and Documentation

The skills reference files in this repository:
- `samples/` - 30+ toolkit examples
- `streams_docs/` - Documentation and Redbooks

### Make Samples Available

For Claude Code to access examples:

```bash
# Create a symlink in your working directory
cd ~/your-streams-project
ln -s ~/claude-skills/samples .
ln -s ~/claude-skills/streams_docs .

# Now Claude can reference them:
"Look at samples/com.teracloud.streams.kafka/ for an example"
```

Or reference absolute paths:
```
"Use examples from ~/claude-skills/samples/com.teracloud.streams.kafka/"
```

## Troubleshooting

### Skills Not Being Used

If Claude doesn't seem aware of the skills:

1. **Verify installation:**
   ```bash
   ls ~/.claude/skills/
   ```

2. **Check file contents:**
   ```bash
   head ~/.claude/skills/streams-spl-app.md
   ```

3. **Use explicit reference:**
   ```
   "Please read the file at ~/.claude/skills/streams-spl-app.md
   and use it as guidance to help me..."
   ```

### Samples/Docs Not Found

```bash
# Make sure repo is cloned locally
ls ~/claude-skills/samples/
ls ~/claude-skills/streams_docs/

# Reference with absolute paths
"Use examples from /Users/your-username/claude-skills/samples/"
```

## Different Approach: Project-Specific Skills

If you want skills per-project instead of global:

```bash
cd ~/your-streams-project
mkdir -p .claude/skills
ln -s ~/claude-skills/skills/*.md .claude/skills/
```

Then Claude Code will find them in the project directory.

## Uninstall

```bash
# Remove global skills
rm -rf ~/.claude/skills

# Remove local clone
rm -rf ~/claude-skills
```

## Support

- Check `USAGE.md` for detailed usage scenarios
- Read `skills/README.md` for skill descriptions
- Browse `samples/` for code examples
- Consult `streams_docs/` for API references
