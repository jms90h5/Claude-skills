# Streams Python Primitive Operator Generator

## Description
This skill helps you create IBM Streams primitive operators implemented in Python using the streamsx.spl decorator-based API. Python operators provide rapid development and easy integration with Python libraries.

## What this skill does
- Creates Python primitive operators using decorators
- Generates operators for sources, transformations, and sinks
- Integrates Python logic into SPL applications
- Provides access to Python ecosystem (NumPy, pandas, scikit-learn, etc.)

## Usage
Ask questions like:
- "Create a Python source operator that generates data"
- "Generate a Python operator that uses machine learning"
- "Create a Python transformation operator with custom logic"
- "Build a Python operator that processes JSON data"

## Python Operator Overview

Python operators in IBM Streams are created using the `streamsx.spl` package and decorators. Python code is executed within a C++ primitive operator that embeds the Python runtime.

### Key Decorators

- **@spl.source()**: Marks a class or function as a source operator
- **@spl.primitive_operator()**: Creates a primitive operator with custom ports
- **@spl.input_port()**: Marks a method as an input port handler
- **@spl.for_each**: Creates a simple transformation operator
- **@spl.filter**: Creates a filter operator
- **@spl.map**: Creates a mapping operator

## Source Operators

### Function-based Source
```python
from streamsx.spl import spl

def spl_namespace():
    return "com.company.operators"

@spl.source()
def MySource():
    """Generate a sequence of numbers."""
    return zip(range(100))
```

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
        """
        Args:
            count: Number of tuples to generate
            period: Time between tuples in seconds
        """
        self.count = count
        self.period = period

    def __iter__(self):
        for i in range(self.count):
            # Return tuple as a Python tuple
            yield (i, "message_" + str(i), time.time())
            time.sleep(self.period)
```

### Source with Multiple Output Ports
```python
from streamsx.spl import spl

def spl_namespace():
    return "com.company.operators"

@spl.source(output_ports=['OUT1', 'OUT2'])
class MultiOutputSource(spl.PrimitiveOperator):
    """Source with two output ports."""

    def __init__(self, iterations=10):
        self.iterations = iterations

    def __enter__(self):
        # Called when operator initializes
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        # Called when operator shuts down
        pass

    def __iter__(self):
        for i in range(self.iterations):
            # Submit to different ports based on logic
            if i % 2 == 0:
                # Submit to port 0 (OUT1)
                self.submit('OUT1', (i, "even"))
            else:
                # Submit to port 1 (OUT2)
                self.submit('OUT2', (i, "odd"))
        return iter([])  # End iteration
```

## Transformation Operators

### Simple For-Each Operator
```python
from streamsx.spl import spl

def spl_namespace():
    return "com.company.operators"

@spl.for_each
def Transform(value, message):
    """
    Transform input tuples.

    Input schema: tuple<int32 value, rstring message>
    Output schema: tuple<int32 value, rstring message, int32 doubled>
    """
    # Return tuple with additional computed value
    return (value, message, value * 2)
```

### Filter Operator
```python
from streamsx.spl import spl

def spl_namespace():
    return "com.company.operators"

@spl.filter
def PositiveFilter(value):
    """
    Filter tuples, keeping only positive values.

    Returns:
        True if tuple should be submitted, False otherwise
    """
    return value > 0
```

### Map Operator
```python
from streamsx.spl import spl

def spl_namespace():
    return "com.company.operators"

@spl.map
def ToUpper(message):
    """Convert message to uppercase."""
    return message.upper()
```

### Primitive Operator with Custom Ports
```python
from streamsx.spl import spl

def spl_namespace():
    return "com.company.operators"

@spl.primitive_operator(output_ports=['MATCH', 'NO_MATCH'])
class Classifier(spl.PrimitiveOperator):
    """
    Classify input tuples and route to different output ports.
    """

    def __init__(self, threshold=0.5):
        self.threshold = threshold

    @spl.input_port()
    def process(self, **tuple_):
        """
        Process input tuples.

        Args:
            **tuple_: Keyword arguments representing tuple attributes
        """
        score = self.calculate_score(tuple_)

        if score >= self.threshold:
            # Submit to MATCH port (port 0)
            self.submit('MATCH', tuple_)
        else:
            # Submit to NO_MATCH port (port 1)
            self.submit('NO_MATCH', tuple_)

    def calculate_score(self, tuple_dict):
        # Custom scoring logic
        return tuple_dict.get('value', 0) / 100.0
```

## Sink Operators

### Simple Sink
```python
from streamsx.spl import spl

def spl_namespace():
    return "com.company.operators"

@spl.for_each
def PrintSink(id, message):
    """
    Print incoming tuples.
    Note: Returns None, so no output tuple is submitted.
    """
    print(f"ID: {id}, Message: {message}")
    # Returning None means no output tuple
```

### Sink with State
```python
from streamsx.spl import spl

def spl_namespace():
    return "com.company.operators"

@spl.primitive_operator()
class StatefulSink(spl.PrimitiveOperator):
    """Sink that maintains state across tuples."""

    def __init__(self, output_file):
        self.output_file = output_file
        self.count = 0
        self.file_handle = None

    def __enter__(self):
        """Initialize operator - open file."""
        self.file_handle = open(self.output_file, 'w')
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        """Cleanup operator - close file."""
        if self.file_handle:
            self.file_handle.close()

    @spl.input_port()
    def process(self, **tuple_):
        """Process each input tuple."""
        self.count += 1
        line = f"{self.count}: {tuple_}\n"
        self.file_handle.write(line)
        self.file_handle.flush()
```

## Operator Lifecycle Methods

### For PrimitiveOperator Classes

- **\_\_init\_\_(self, ...)**:Constructor with operator parameters
- **\_\_enter\_\_(self)**: Called when operator initializes (like allPortsReady())
- **\_\_exit\_\_(self, exc_type, exc_value, traceback)**: Called on shutdown
- **@spl.input_port()**: Method called for each input tuple

## Accessing Tuple Attributes

### Positional Arguments
```python
@spl.for_each
def Transform(id, name, value):
    # Attributes passed by position
    return (id, name.upper(), value * 2)
```

### Keyword Arguments (**kwargs)
```python
@spl.for_each
def Transform(**tuple_):
    # Access attributes by name
    id = tuple_['id']
    name = tuple_['name']
    value = tuple_['value']
    return (id, name.upper(), value * 2)
```

## Submitting Output Tuples

### Return Value (Simple Operators)
```python
@spl.for_each
def MyOperator(x, y):
    # Return Python tuple
    return (x + y, x * y)
```

### submit() Method (Primitive Operators)
```python
@spl.primitive_operator(output_ports=['OUT1', 'OUT2'])
class MyOperator(spl.PrimitiveOperator):
    @spl.input_port()
    def process(self, **tuple_):
        # Submit to specific port by name
        self.submit('OUT1', (tuple_['x'], tuple_['y']))
        # Or by index
        self.submit(1, (tuple_['x'] * 2,))
```

## Using Python Libraries

### Example with NumPy and scikit-learn
```python
from streamsx.spl import spl
import numpy as np
from sklearn.linear_model import LinearRegression

def spl_namespace():
    return "com.company.operators"

@spl.primitive_operator()
class MLPredictor(spl.PrimitiveOperator):
    """Use scikit-learn model to make predictions."""

    def __init__(self, model_file):
        self.model_file = model_file
        self.model = None

    def __enter__(self):
        # Load model during initialization
        import pickle
        with open(self.model_file, 'rb') as f:
            self.model = pickle.load(f)
        return self

    @spl.input_port()
    def predict(self, **tuple_):
        # Extract features
        features = np.array([
            tuple_['feature1'],
            tuple_['feature2'],
            tuple_['feature3']
        ]).reshape(1, -1)

        # Make prediction
        prediction = self.model.predict(features)[0]

        # Return input plus prediction
        output = dict(tuple_)
        output['prediction'] = float(prediction)
        return output
```

### Example with pandas
```python
from streamsx.spl import spl
import pandas as pd

def spl_namespace():
    return "com.company.operators"

@spl.primitive_operator()
class DataFrameProcessor(spl.PrimitiveOperator):
    """Process tuples using pandas."""

    def __init__(self, window_size=10):
        self.window_size = window_size
        self.buffer = []

    @spl.input_port()
    def process(self, **tuple_):
        self.buffer.append(tuple_)

        if len(self.buffer) >= self.window_size:
            # Convert to DataFrame
            df = pd.DataFrame(self.buffer)

            # Compute statistics
            mean_value = df['value'].mean()

            # Submit result
            self.submit(0, {
                'mean': mean_value,
                'count': len(df)
            })

            # Clear buffer
            self.buffer = []
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

## Operator Parameters

Parameters are passed to the `__init__` method:

```python
@spl.source()
class MySource(object):
    def __init__(self, iterations=100, period=1.0, prefix="data"):
        """
        Args:
            iterations (int): Number of tuples to generate
            period (float): Seconds between tuples
            prefix (str): Prefix for generated messages
        """
        self.iterations = iterations
        self.period = period
        self.prefix = prefix
```

In SPL, use like:
```spl
stream<int32 id, rstring msg> Data = MySource() {
    param
        iterations: 50;
        period: 2.0;
        prefix: "test";
}
```

## Type Mapping

### SPL to Python Types

- `int8/16/32/64` → `int`
- `uint8/16/32/64` → `int`
- `float32/64` → `float`
- `rstring` → `str`
- `boolean` → `bool`
- `timestamp` → `streamsx.spl.types.Timestamp`
- `list<T>` → `list`
- `map<K,V>` → `dict`
- `set<T>` → `set`
- `tuple<...>` → `dict` or tuple

## Documentation References

See streams_docs/com.ibm.streams.dev.doc/doc/ for detailed documentation:
- `python_operator_api_overview.html` - Python Operator API overview
- `dev-python-prim-oper.html` - Developing Python primitive operators
- `implementing_an_operator_using_the_python_operator_api.html` - Implementation guide
- `python_operator_lifecycle.html` - Operator lifecycle
- `operators_implemented_in_python.html` - Python operators overview

## Best Practices

1. **Namespace**: Always define `spl_namespace()` function
2. **Documentation**: Add docstrings - they become operator descriptions
3. **Initialization**: Use `__enter__` for setup, `__exit__` for cleanup
4. **State**: Store state as instance variables
5. **Performance**: Minimize work in `process()` method
6. **Libraries**: Install required libraries in Streams Python environment
7. **Typing**: Use type hints for better code clarity
8. **Error Handling**: Use try/except to handle errors gracefully
9. **Logging**: Use Python's logging module for debugging
10. **Testing**: Test operators standalone before integrating

## Package Requirements

Create `requirements.txt` in your toolkit:
```
numpy>=1.19.0
pandas>=1.1.0
scikit-learn>=0.23.0
```

## Using in SPL Applications

```spl
use com.company.operators::MySource;
use com.company.operators::Transform;
use com.company.operators::MySink;

composite Main {
    graph
        stream<int32 id, rstring msg> Data = MySource() {
            param
                count: 100;
                period: 1.0;
        }

        stream<int32 id, rstring msg, float64 score> Enriched = Transform(Data) {
        }

        () as Sink = MySink(Enriched) {
            param
                outputFile: "results.txt";
        }
}
```

## Instructions

When the user asks to create a Python primitive operator:

1. Determine operator type (source, transformation, or sink)
2. Ask clarifying questions:
   - What processing does it perform?
   - What Python libraries are needed?
   - What are the input/output schemas?
   - Does it need to maintain state?
   - How many input/output ports?

3. Generate the operator:
   - Create Python file in opt/python/streams/
   - Define `spl_namespace()` function
   - Use appropriate decorator (@spl.source, @spl.primitive_operator, etc.)
   - Implement required methods
   - Add docstrings

4. Explain the code:
   - Describe the operator's purpose
   - Explain key methods
   - Show how to use in SPL

5. Provide setup instructions:
   - Required Python packages
   - How to install dependencies
   - Testing approach
