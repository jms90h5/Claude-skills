---
name: streams-python-operator
description: Generate IBM Streams primitive operators implemented in Python using decorators and the streamsx.spl API. Enables rapid development and integration with Python libraries like NumPy, pandas, and scikit-learn. Use when creating Python operators, machine learning operations, data science workflows, or when user mentions Python, ML, pandas, NumPy, or rapid prototyping.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

# Streams Python Primitive Operator Generator

This skill helps you create IBM Streams primitive operators implemented in Python using the streamsx.spl decorator-based API.

## 🚨 CRITICAL: Read CLAUDE.md First

**BEFORE generating any code, consult `/home/streamsadmin/workspace/teracloud/CLAUDE.md` for:**
- ❌ ABSOLUTE PROHIBITION on fake/placeholder/mock code (including torch.randn(), random(), etc.)
- ✅ Testing and verification standards
- ✅ Teracloud Streams specific conventions
- ❌ NEVER use fake data generation (no torch.randn, no random fake results)

**For SPL syntax questions, ALWAYS consult: https://doc.streams.teracloud.com/index.html**

## What this skill does

- Creates Python primitive operators using decorators
- Generates operators for sources, transformations, and sinks
- Integrates Python logic into SPL applications
- Provides access to Python ecosystem (NumPy, pandas, scikit-learn, etc.)
- **Generates ONLY real, functional code - never fake/placeholder implementations**

## Instructions

When the user asks to create a Python primitive operator:

1. **Determine operator type** (source, transformation, or sink)

2. **Ask clarifying questions:**
   - What processing does it perform?
   - What Python libraries are needed?
   - What are the input/output schemas?
   - Does it need to maintain state?

3. **Generate the operator:**
   - Create Python file in opt/python/streams/
   - Define `spl_namespace()` function
   - Use appropriate decorator (@spl.source, @spl.primitive_operator, etc.)
   - Implement required methods
   - Add docstrings

4. **Explain the code:**
   - Describe the operator's purpose
   - Explain key methods
   - Show how to use in SPL

## Python Operator Overview

Python operators are created using the `streamsx.spl` package and decorators.

### Key Decorators

- **@spl.source()**: Marks a class or function as a source operator
- **@spl.primitive_operator()**: Creates a primitive operator with custom ports
- **@spl.for_each**: Creates a simple transformation operator
- **@spl.filter**: Creates a filter operator
- **@spl.map**: Creates a mapping operator

## Source Operators

### Class-based Source
```python
from streamsx.spl import spl
import time

def spl_namespace():
    return "com.company.operators"

@spl.source()
class PeriodicSource(object):
    """Source that generates tuples periodically."""

    def __init__(self, count, period=1.0):
        self.count = count
        self.period = period

    def __iter__(self):
        for i in range(self.count):
            yield (i, "message_" + str(i), time.time())
            time.sleep(self.period)
```

### Source with Multiple Output Ports
```python
@spl.source(output_ports=['OUT1', 'OUT2'])
class MultiOutputSource(spl.PrimitiveOperator):
    def __init__(self, iterations=10):
        self.iterations = iterations

    def __iter__(self):
        for i in range(self.iterations):
            if i % 2 == 0:
                self.submit('OUT1', (i, "even"))
            else:
                self.submit('OUT2', (i, "odd"))
        return iter([])
```

## Transformation Operators

### Simple For-Each Operator
```python
@spl.for_each
def Transform(value, message):
    """Transform input tuples."""
    return (value, message, value * 2)
```

### Primitive Operator with Custom Ports
```python
@spl.primitive_operator(output_ports=['MATCH', 'NO_MATCH'])
class Classifier(spl.PrimitiveOperator):
    def __init__(self, threshold=0.5):
        self.threshold = threshold

    @spl.input_port()
    def process(self, **tuple_):
        score = self.calculate_score(tuple_)
        if score >= self.threshold:
            self.submit('MATCH', tuple_)
        else:
            self.submit('NO_MATCH', tuple_)

    def calculate_score(self, tuple_dict):
        return tuple_dict.get('value', 0) / 100.0
```

## Sink Operators

### Sink with State
```python
@spl.primitive_operator()
class StatefulSink(spl.PrimitiveOperator):
    def __init__(self, output_file):
        self.output_file = output_file
        self.count = 0
        self.file_handle = None

    def __enter__(self):
        self.file_handle = open(self.output_file, 'w')
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        if self.file_handle:
            self.file_handle.close()

    @spl.input_port()
    def process(self, **tuple_):
        self.count += 1
        line = f"{self.count}: {tuple_}\n"
        self.file_handle.write(line)
        self.file_handle.flush()
```

## Using Python Libraries

### Example with scikit-learn
```python
from streamsx.spl import spl
import numpy as np
from sklearn.linear_model import LinearRegression

@spl.primitive_operator()
class MLPredictor(spl.PrimitiveOperator):
    def __init__(self, model_file):
        self.model_file = model_file
        self.model = None

    def __enter__(self):
        import pickle
        with open(self.model_file, 'rb') as f:
            self.model = pickle.load(f)
        return self

    @spl.input_port()
    def predict(self, **tuple_):
        features = np.array([
            tuple_['feature1'],
            tuple_['feature2'],
            tuple_['feature3']
        ]).reshape(1, -1)
        
        prediction = self.model.predict(features)[0]
        output = dict(tuple_)
        output['prediction'] = float(prediction)
        return output
```

## Directory Structure

```
ToolkitName/
├── opt/
│   └── python/
│       └── streams/
│           ├── __init__.py
│           └── my_operators.py  # Your Python operators
└── toolkit.xml
```

## Operator Lifecycle Methods

- **__init__(self, ...)**: Constructor with operator parameters
- **__enter__(self)**: Called when operator initializes
- **__exit__(self, exc_type, exc_value, traceback)**: Called on shutdown
- **@spl.input_port()**: Method called for each input tuple

## Type Mapping

SPL to Python Types:
- `int8/16/32/64` → `int`
- `float32/64` → `float`
- `rstring` → `str`
- `boolean` → `bool`
- `list<T>` → `list`
- `map<K,V>` → `dict`

## Documentation References

### Primary (Local - Can be READ by Claude)
See `/home/streamsadmin/workspace/Claude-skills/streams_docs/`:
- `com.ibm.streams.dev.doc/doc/python_operator_api_overview.html` - Python Operator API overview
- `com.ibm.streams.dev.doc/doc/dev-python-prim-oper.html` - Developing Python primitive operators
- `com.ibm.streams.dev.doc/doc/implementing_an_operator_using_the_python_operator_api.html` - Implementation guide
- `Streams2.0Redbook.pdf` - Python operator integration patterns

### Operator Code Generation API (Local)
- `/opt/teracloud/streams/7.2.0.1/doc/spl/operator/api` - Python Operator API reference

### Supplementary (Online)
- **Teracloud Streams Docs**: https://doc.streams.teracloud.com/index.html
- Check `/opt/teracloud/streams/7.2.0.1/samples` for official examples

## Best Practices

### From CLAUDE.md (MANDATORY - ESPECIALLY FOR PYTHON/ML)
1. **NO FAKE CODE EVER**: Never use torch.randn(), random(), or fake data generation
2. **NO MOCK DATA**: Never return hardcoded "sample transcription" or dummy results
3. **FAIL LOUDLY**: Throw errors if functionality cannot work, don't hide problems
4. **Verify Functionality**: Test with real data, document actual output
5. **Real ML Models**: Use actual trained models, not random number generators

### Python Operator Specific
1. **Namespace**: Always define `spl_namespace()` function
2. **Documentation**: Add docstrings - they become operator descriptions
3. **Initialization**: Use `__enter__` for setup, `__exit__` for cleanup
4. **State**: Store state as instance variables
5. **Performance**: Minimize work in `process()` method
6. **Libraries**: Install required libraries in Streams Python environment
7. **Error Handling**: Use proper exception handling, let errors propagate
