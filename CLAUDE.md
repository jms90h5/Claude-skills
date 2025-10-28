# CLAUDE.md - Teracloud Streams Development Guide

## Critical Engineering Standards - ZERO TOLERANCE

### ABSOLUTE PROHIBITIONS

#### 1. NO FAKE/PLACEHOLDER/MOCK CODE - EVER
**FAKE CODE INCLUDES:**
- Hardcoded return values that don't reflect actual computation
- Mock implementations that bypass real functionality
- Dummy data that doesn't come from actual processing (e.g., `torch.randn()`, `random()`, "sample output")
- Simplified implementations that gut required features
- Commented out functionality to avoid implementation work
- Any code that produces fake results instead of real processing

**WHEN CODE CANNOT WORK:**
- **THROW FATAL ERRORS IMMEDIATELY** with clear error messages
- **CRASH THE SYSTEM** rather than return fake results
- Use `raise NotImplementedError("FATAL: [specific issue]")`
- Use `sys.exit(1)` with error message if needed
- **NEVER HIDE PROBLEMS** with fake functionality

**REMEMBER:** Better a broken system that fails loudly than a "working" system producing fake results.

#### 2. NEVER CLAIM "PRODUCTION-READY" OR DEPLOYMENT READINESS
**PROHIBITED CLAIMS:**
- "production-ready"
- "ready for production"
- "production deployment ready"
- "enterprise-ready"
- Any claim about deployment readiness without explicit user validation

#### 3. COMPILATION MUST BE CLEAN - NO WARNINGS
**COMPILATION REQUIREMENTS:**
- ALL C++ code must compile without ANY warnings (`-Wall -Wextra`)
- Use proper type casting (`static_cast<>`) for size_t vs int comparisons
- Use `size_t` for loop indices when comparing with `container.size()`
- Use proper const correctness and initialization
- Fix signedness warnings immediately - never ignore them
- Test compilation before claiming code changes are complete

#### 4. NEVER MODIFY WORKING SYSTEMS WITHOUT VERIFICATION
**ABSOLUTE PROHIBITIONS:**
- Never modify working systems without user-specified real testing FIRST
- Never use synthetic/fake data (sine waves, noise) for validation
- Never make multiple simultaneous changes without incremental testing
- Never claim "working" or "success" without actual verification
- Never ignore explicit user safety constraints

---

## Mandatory Verification Process

### Before Making ANY Changes:
1. **Read ALL existing code** to understand current implementation
2. **Verify end-to-end functionality** with REAL data
3. **Test each component individually** with actual inputs/outputs
4. **Trace data flow** through entire pipeline
5. **Question ANY identical/repetitive results** immediately

### Definition of "Working" - CRITICAL
**"RUNS WITHOUT CRASHING" IS NOT SUFFICIENT**

For systems to be considered working:
- Must verify actual functionality produces **correct output**
- Must test with **real data** and verify expected results
- Must document **specific output that proves functionality**

**For Speech-to-Text Systems Specifically:**
- Empty transcripts = COMPLETE FAILURE
- Wrong transcripts = COMPLETE FAILURE
- No crashes but no results = COMPLETE FAILURE
- ONLY correct transcription output proves the system works
- Technical infrastructure working = MEANINGLESS without correct functional output

---

## Teracloud Streams Specifics

### Documentation Resources
**ALWAYS consult official documentation for SPL syntax questions:**
- Primary Documentation: https://doc.streams.teracloud.com/index.html
- Working Examples: `/opt/teracloud/streams/7.2.0.0/samples`

**Before changing SPL code:**
1. Check the documentation at https://doc.streams.teracloud.com/index.html
2. Look at working examples in `/opt/teracloud/streams/7.2.0.0/samples`

---

## Essential Command-Line Tools

### `sc` - Streams Compiler
Compiles SPL source code (`.spl`) into a deployable Streams Application Bundle (`.sab`).

**Basic Usage:**
```bash
sc -M <namespace>::<MainComposite> [options]
```

**Common Options:**

| Option | Alias | Description | Example |
|--------|-------|-------------|---------|
| `--main-composite <name>` | `-M` | **Required.** Specifies the main composite operator to compile | `-M my.namespace::MyApp` |
| `--toolkit-path <dir>` | `-t` | Adds a directory to the toolkit search path (use multiple times if needed) | `-t ../myToolkit -t /opt/streams/spl` |
| `--output-directory <dir>` | `-o` | Specifies the directory for output artifacts (incl. `.sab`). Default: `./output` | `-o build/output` |
| `--data-directory <dir>` | `-d` | Specifies the default data directory for the application. Default: `./data` | `-d /app/data` |
| `--standalone-compile` | `-T` | Compile for standalone execution (single process, useful for testing/debugging) | `-T` |
| `--makefile-generation` | `-m` | Generate a Makefile instead of compiling directly | `-m` |

**Example:**
```bash
sc -M com.mycompany.fraud::FraudDetectionEngine \
   -t ./toolkits/common \
   -t ./toolkits/rules \
   --output-directory ./build/output
```

### `streamtool` - Instance & Job Management
Manages Streams domains, instances, jobs, PEs, configuration, and monitoring.

**Basic Usage:**
```bash
streamtool <subcommand> [options] [arguments]
```
*(Requires authentication with the Streams instance)*

**Common Commands:**

| Command | Description | Common Options | Example |
|---------|-------------|----------------|---------|
| `submitjob` | Submits a `.sab` file to run as a job | `<file.sab>`, `-P param=value`, `-J group`, `--jobname name`, `-C config=value` | `submitjob myapp.sab -P inputTopic=prod.data` |
| `lsjobs` | Lists jobs in the instance (ID, Name, Status, Health) | `--jobs <id>`, `--jobnames <name>`, `-i <instance_id>` | `lsjobs` |
| `canceljob` | Cancels running jobs | `-j <id>`, `--jobnames <name>`, `--force`, `--collectlogs` | `canceljob -j 123 --force` |
| `lspes` | Lists Processing Elements (PEs) | `--jobs <id>`, `--pes <id>`, `-i <instance_id>` | `lspes --jobs 123` |
| `getlog` | Retrieves log/trace files for jobs, PEs, or instance components | `--jobs <id>`, `--pes <id>`, `--output-directory <dir>` | `getlog --jobs 123 -o /tmp/job123_logs` |
| `startinstance` | Starts a stopped Streams instance | `-i <instance_id>` | `startinstance -i MyStreamsInstance` |
| `stopinstance` | Stops a running Streams instance | `-i <instance_id>` | `stopinstance -i MyStreamsInstance` |
| `mkinstance` | Creates a new Streams instance within a domain | `-i <instance_id>`, `-d <domain_id>` | `mkinstance -i NewInst -d MyDomain` |
| `rminstance` | Removes a Streams instance | `-i <instance_id>` | `rminstance -i OldInst` |
| `startdomain` | Starts a Streams domain | `-d <domain_id>` | `startdomain -d MyDomain` |
| `stopdomain` | Stops a Streams domain | `-d <domain_id>` | `stopdomain -d MyDomain` |

**Example:**
```bash
streamtool submitjob ./build/output/com.mycompany.fraud.FraudDetectionEngine.sab \
  -i production \
  --jobname FraudEngineProd \
  -P kafkaBrokers=prod-kafka:9092 \
  -P databaseHost=prod-db.internal
```

---

## SPL Coding Guidelines

### Naming Conventions
Consistent naming improves readability and maintainability:

| Artifact Type | Convention | Example |
|---------------|------------|---------|
| Namespace | `lower.dot` | `com.example.analytics` |
| Composite Operator | `PascalCase` | `StockTradeProcessor` |
| Function (SPL/Native) | `camelCase` | `calculateAvgPrice()` |
| Type (Tuple/Enum) | `PascalCase` | `TradeData`, `OrderType` |
| Stream | `camelCase` | `validTrades`, `rawData` |
| Attribute (Tuple) | `camelCase` | `tickerSymbol`, `price` |
| Parameter | `camelCase` | `windowSize`, `fileName` |

**Guidelines:**
- Function names should clearly indicate their action
- Use descriptive names that convey purpose

### Structure Best Practices

**Namespaces:**
- Group related SPL artifacts (composites, functions, types) into logical namespaces
- Mirror toolkit directory structure
- Prevents conflicts, improves modularity

**Composite Operators:**
- Encapsulate reusable stream processing logic (subgraphs)
- Define input/output ports and parameters for modular design

**Graph Clause:**
- Core of a composite (including main) defining data flow
- Invoke operators and connect streams
- Structure should reflect the processing pipeline clearly

### Documentation Standards

**Comment Types:**
- `//` for single-line comments
- `/* ... */` for multi-line comments
- `/** SPLDOC */` for public artifact documentation

**SPLDOC Usage:**
Use SPLDOC markup for documenting public artifacts:
- Namespaces (in `namespace-info.spl`)
- Composites
- Functions
- Types

**SPLDOC Should Include:**
- Purpose and description
- Parameters (type, range, default)
- Ports (schema/type)
- Windowing behavior
- Exceptions (`@throws`)
- Configuration constraints
- Concrete usage examples (`@sample`)

**For Primitives/Native Functions:**
- Use `<description>` in XML model

**Generating Documentation:**
```bash
spl-make-doc  # Generates HTML documentation from SPLDOC comments and models
```

### Key Design Patterns

**1. Operator Granularity**
- Design operators (primitive & composite) for a single, well-defined task
- Enhances reusability, testability, understandability

**2. Leverage Toolkits**
- Use standard/specialized toolkits
- Avoid reimplementing common functions

**3. Parameterization**
- Use operator `param` clause for configurability
- Avoid hardcoding values
- Use application configuration objects for sensitive data securely

**4. Windowing for State**
- Employ built-in windowing (tumbling, sliding, partitioned) via `window` clause
- Use for stateful operations (aggregations, joins)

**5. Robust Error Handling**
- Explicitly handle potential errors (invalid input, external connection failures)
- Use `@catch` or logic checks

**6. Control Ports**
- Use dedicated control input ports for dynamic behavior adjustment based on signals

**7. Clear Output Assignments**
- Use `output` clause or custom output functions
- Define how output tuple attributes are populated

### Anti-Patterns to Avoid

**Spaghetti Code**
- Avoid complex graphs with tangled streams or convoluted operator logic
- Use composites to break down complexity

**Hardcoding / Magic Values**
- Do not embed config (paths, servers, keys, thresholds, literals) in code
- Makes adaptation hard
- Use parameters, app config, or named constants

**God Operators/Composites**
- Resist operators/composites with too many disparate responsibilities
- Violates granularity, hinders testing/reuse/maintenance

**Ignoring Errors**
- Failing to check for errors leads to silent failures or unpredictable behavior
- Always handle errors explicitly

**Monolithic Application Design**
- Decompose complex apps into smaller, reusable composites in toolkits

**Chatty Interactions**
- Avoid designs where operators need excessive back-and-forth with external systems
- Can cause bottlenecks
- Batch interactions if possible

---

## Project-Specific Information Template

**📝 CUSTOMIZE THIS SECTION FOR YOUR SPECIFIC PROJECT**

### Build Command
```bash
# Example: Compile the main application
sc -M com.mycompany.fraud::FraudDetectionEngine \
   -t ./toolkits/common \
   -t ./toolkits/rules \
   --output-directory ./build/output
```

### Submission Command
```bash
# Example: Submit job to 'production' instance with specific parameters
streamtool submitjob ./build/output/com.mycompany.fraud.FraudDetectionEngine.sab \
  -i production \
  --jobname FraudEngineProd \
  -P kafkaBrokers=prod-kafka:9092 \
  -P databaseHost=prod-db.internal
```

### Key Custom Toolkits
- `./toolkits/common`: Contains shared types and utility functions
- `./toolkits/rules`: Implements the core fraud detection rule operators
- `./toolkits/[your_toolkit]`: **[DESCRIBE PURPOSE]**

### Primary Main Composite(s)
- `com.mycompany.fraud::FraudDetectionEngine`
- **[ADD OTHER MAIN COMPOSITES]**

### Test Execution
```bash
# Example: Run unit tests
make test-unit

# Example: Run integration tests (requires running instance)
pytest tests/integration --instance-id production
```

### Target Streams Instance(s)
- **Development:** `streams-dev`
- **Production:** `streams-prod`
- **[ADD/MODIFY INSTANCES AS NEEDED]**

### Key Configuration Parameters
*(Submission-time `-P` or Application Configuration)*

- `kafkaBrokers`: Comma-separated list of Kafka broker host:port pairs
- `databaseHost`: Hostname for the reporting database
- `alertThreshold`: Numeric threshold for triggering alerts
- **[ADD OTHER IMPORTANT PARAMETERS]**

---

## Quick Reference Checklist

### Before Starting Development:
- [ ] Read all existing code and understand current implementation
- [ ] Identify relevant documentation at https://doc.streams.teracloud.com/index.html
- [ ] Review working examples in `/opt/teracloud/streams/7.2.0.0/samples`
- [ ] Understand the data flow and pipeline architecture

### During Development:
- [ ] Follow naming conventions (PascalCase for composites, camelCase for functions/streams)
- [ ] Use proper parameterization (no hardcoded values)
- [ ] Implement robust error handling
- [ ] Add SPLDOC comments for public artifacts
- [ ] Test incrementally with real data
- [ ] Ensure clean compilation (no warnings for C++)

### Before Claiming Completion:
- [ ] Verify end-to-end functionality with REAL data
- [ ] Confirm correct output (not just "no crashes")
- [ ] Document specific outputs that prove functionality
- [ ] Test all error paths
- [ ] Review code for anti-patterns (God operators, hardcoding, etc.)

---

**Version:** 1.0
**Last Updated:** [UPDATE DATE]
**Maintained By:** [YOUR TEAM/NAME]
