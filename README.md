# TraceViz

[![Gem Version](https://badge.fury.io/rb/trace_viz.svg)](https://rubygems.org/gems/trace_viz)
[![Downloads](https://img.shields.io/gem/dt/trace_viz)](https://rubygems.org/gems/trace_viz)
[![Build Status](https://github.com/patrick204nqh/trace_viz/actions/workflows/main.yml/badge.svg)](https://github.com/patrick204nqh/trace_viz/actions)
[![Maintainability](https://api.codeclimate.com/v1/badges/e97579abe66f3477e71d/maintainability)](https://codeclimate.com/github/patrick204nqh/trace_viz/maintainability)
![License](https://img.shields.io/github/license/patrick204nqh/trace_viz)

TraceViz is a Ruby library designed to trace and visualize events executed in a block of code. It is useful for logging, debugging, and generating diagrams to understand code execution and flow.

> **Note:** The diagram generation feature is currently under development.

The gem allows you to customize how much detail you want to see, such as method calls, parameters, return values, and execution times.

## Demo

[![asciicast](https://asciinema.org/a/pKjqLFNPxQFQWucTzcGMpt6QE.svg)](https://asciinema.org/a/pKjqLFNPxQFQWucTzcGMpt6QE)

## Installation

Add this line to your application's Gemfile:

```bash
gem 'trace_viz'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install trace_viz
```

## Usage

Wrap your code inside the TraceViz.trace block to start tracing its execution. The tracing behavior can be customized using various options:

<details>
  <summary>Configuration Example</summary>

```ruby
TraceViz.trace(
  general: {
    tab_size: 4,
    show_indent: true,
    show_depth: true,
    max_display_depth: 3,
    show_method_name: true,
  },
  source_location: {
    show: false,
    truncate_length: 100,
  },
  params: {
    show: true,
    mode: :name_and_value,
    truncate_values: 50,
  },
  result: {
    show: true,
    truncate_length: 50,
  },
  execution: {
    show_time: true,
    show_trace_events: [:call, :return],
  },
  filters: [
    :exclude_internal_call,
    :exclude_default_classes,
    ...
  ],
  export: {
    enabled: true,
    path: "tmp",
    format: :txt,
    overwrite: false,
  }
) do
  # Your code here
end
```

</details>

<details>
  <summary>Example Code</summary>

```ruby
class Example
  def perform_task(x, y)
    result = add_numbers(x, y)
    log_result(result)
    result
  end

  def add_numbers(a, b)
    sleep(0.1)
    sum = a + b
    multiply_by_factor(sum, 2)
  end

  def multiply_by_factor(value, factor)
    sleep(0.05)
    value * factor
  end

  def log_result(result)
    sleep(0.02)
    puts "Final result: #{result}"
  end
end

TraceViz.trace(
  general: {
    tab_size: 4,
    show_indent: true,
    show_depth: true,
    max_display_depth: 3,
    show_method_name: true,
  },
  source_location: {
    show: false,
    truncate_length: 100,
  },
  params: {
    show: true,
    mode: :name_and_value,
    truncate_values: 50,
  },
  result: {
    show: true,
    truncate_length: 50,
  },
  execution: {
    show_time: true,
    show_trace_events: [:call, :return],
  },
  filters: [
    :exclude_internal_call,
    include_classes: [Example]
  ],
  export: {
    enabled: true,
    path: "tmp",
    format: :txt,
    overwrite: false,
  }
) do
  example = Example.new
  example.perform_task(5, 7)
end
```

</details>

**Output**

<details>
  <summary>Sample Output</summary>

```bash
🚀   [START]   #depth:0 Example#perform_task (5, 7)
🚀   [START]       #depth:1 Example#add_numbers (5, 7)
🚀   [START]           #depth:2 Example#multiply_by_factor (12, 2)
🏁   [FINISH]          #depth:2 Example#multiply_by_factor #=> 24
🏁   [FINISH]      #depth:1 Example#add_numbers #=> 24
🚀   [START]       #depth:1 Example#log_result (24)
Final result: 24
🏁   [FINISH]      #depth:1 Example#log_result #=> nil
🏁   [FINISH]  #depth:0 Example#perform_task #=> 24
```

</details>

### Configuration Options

TraceViz provides extensive configuration options to customize tracing behavior.

| Group             | Option                     | Type             | Default Value      | Description                                                       |
| ----------------- | -------------------------- | ---------------- | ------------------ | ----------------------------------------------------------------- |
| `general`         | `tab_size`                 | Integer          | 2                  | Number of spaces for indentation.                                 |
|                   | `show_indent`              | Boolean          | true               | Enables visual indentation for nested calls.                      |
|                   | `show_depth`               | Boolean          | true               | Displays the depth level of the method call.                      |
|                   | `max_display_depth`        | Integer          | 3                  | Maximum depth of calls to display.                                |
|                   | `show_method_name`         | Boolean          | true               | Logs the name of the method being executed.                       |
| `source_location` | `show`                     | Boolean          | false              | Logs the source file and line number for methods.                 |
|                   | `truncate_length`          | Integer          | 100                | Maximum length of displayed source location information.          |
| `params`          | `show`                     | Boolean          | true               | Logs method parameters.                                           |
|                   | `mode`                     | Symbol           | `:name_and_value`  | Parameter display mode (`:name`, `:value`, or `:name_and_value`). |
|                   | `truncate_values`          | Integer          | 50                 | Maximum length of parameter values to display.                    |
| `result`          | `show`                     | Boolean          | true               | Logs method return values.                                        |
|                   | `truncate_length`          | Integer          | 50                 | Maximum length of return value logs.                              |
| `execution`       | `show_time`                | Boolean          | true               | Logs execution time for methods.                                  |
|                   | `show_trace_events`        | Array of Symbols | `[:call, :return]` | Specifies the trace events to log (e.g., `:call`, `:return`).     |
| `filters`         | `:exclude_internal_call`   | Symbol           | N/A                | Exclude internal Ruby calls.                                      |
|                   | `:exclude_default_classes` | Symbol           | N/A                | Skip logging standard library classes.                            |
|                   | `:exclude_rails_framework` | Symbol           | N/A                | Ignore Rails framework classes and methods.                       |
|                   | `include_classes`          | Hash             | N/A                | Specify classes to include in tracing.                            |
|                   | - `classes`                | Array            | []                 | List of class names to include (e.g., `["ClassName"]`).           |
|                   | `exclude_classes`          | Hash             | N/A                | Specify classes to exclude from tracing.                          |
|                   | - `classes`                | Array            | []                 | List of class names to exclude (e.g., `["ClassName"]`).           |
|                   | `include_gems`             | Hash             | N/A                | Include specific gems or runtime application gems.                |
|                   | - `app_running`            | Boolean          | true               | Include the code of the application.                              |
|                   | - `app_path`               | String           | `Dir.pwd`          | Path to the application (e.g., `Dir.pwd`).                        |
|                   | - `gems`                   | Array            | []                 | List of gems to include (e.g., `["gem1", "gem2"]`).               |
|                   | `exclude_gems`             | Hash             | N/A                | Exclude specified gems.                                           |
|                   | - `gems`                   | Array            | []                 | List of gems to exclude (e.g., `["excluded_gem"]`).               |
| `export`          | `enabled`                  | Boolean          | true               | Enables or disables exporting of trace logs.                      |
|                   | `path`                     | String           | `"tmp"`            | Directory for exported trace logs.                                |
|                   | `format`                   | Symbol           | `:txt`             | Format for trace logs (`:txt` or other supported formats).        |
|                   | `overwrite`                | Boolean          | false              | Prevents overwriting of existing exported files.                  |

### Notes

- **Default Skipped Classes**: The following standard library classes are excluded by default when `:exclude_default_classes` is enabled:
  - `Object`, `String`, `Array`, `Hash`, `Numeric`, `Integer`, `Float`, `Symbol`, `Kernel`, `Module`, `Class`, `Range`, `Regexp`.

## Development

To set up your development environment:

1. Clone the repository:

```bash
git clone https://github.com/patrick204nqh/trace_viz.git
```

2. Navigate to the project directory:

```bash
cd trace_viz
```

3. Install dependencies:

```bash
bundle install
```

4. Run the test suite:

```bash
bin/rspec
```

You can use `debug` or `pry` to test the gem locally. Make your changes, add tests, and ensure all tests pass before submitting a pull request.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/patrick204nqh/trace_viz. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/patrick204nqh/trace_viz/blob/main/CODE_OF_CONDUCT.md).

## License

TraceViz is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
