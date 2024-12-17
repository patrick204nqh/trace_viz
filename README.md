# TraceViz

[![Gem Version](https://badge.fury.io/rb/trace_viz.svg)](https://rubygems.org/gems/trace_viz)
[![Downloads](https://img.shields.io/gem/dt/trace_viz)](https://rubygems.org/gems/trace_viz)
[![Build Status](https://github.com/patrick204nqh/trace_viz/actions/workflows/main.yml/badge.svg)](https://github.com/patrick204nqh/trace_viz/actions)
[![Maintainability](https://api.codeclimate.com/v1/badges/e97579abe66f3477e71d/maintainability)](https://codeclimate.com/github/patrick204nqh/trace_viz/maintainability)
![License](https://img.shields.io/github/license/patrick204nqh/trace_viz)

TraceViz is a Ruby library designed to trace and visualize events executed in a block of code. It is useful for logging, debugging, and generating diagrams to understand code execution and flow. The gem allows you to customize how much detail you want to see, such as method calls, parameters, return values, and execution times.

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

```ruby
TraceViz.trace(
  tab_size: 2,
  show_indent: true,
  show_depth: true,
  max_display_depth: 4, # Recommended to keep this value between 3 and 5
  show_method_name: true,
  show_source_location: false,
  show_params: true,
  show_return_value: true,
  show_execution_time: true,
  show_trace_events: [:call, :return]
) do
  # Your code here
end
```

**Example**

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
    tab_size: 4,
    show_indent: true,
    show_depth: true,
    max_display_depth: 3,
    show_method_name: true,
    show_source_location: false,
    show_params: true,
    show_return_value: true,
    show_execution_time: true,
    show_trace_events: [:call, :return]
) do
  example = Example.new
  example.perform_task(5, 7)
end
```

**Output**

```bash
🚀   [START]   #depth:0 Example#perform_task (5, 7, nil)
🚀   [START]       #depth:1 Example#add_numbers (5, 7, nil)
🚀   [START]           #depth:2 Example#multiply_by_factor (12, 2)
🏁   [FINISH]          #depth:2 Example#multiply_by_factor #=> 24
🏁   [FINISH]      #depth:1 Example#add_numbers #=> 24
🚀   [START]       #depth:1 Example#log_result (24)
Final result: 24
🏁   [FINISH]      #depth:1 Example#log_result #=> nil
🏁   [FINISH]  #depth:0 Example#perform_task #=> 24
```

### Configuration Options

| Option                 | Type             | Description                                                                      |
| ---------------------- | ---------------- | -------------------------------------------------------------------------------- |
| `tab_size`             | Integer          | Defines the number of spaces used for indentation when `show_indent` is enabled. |
| `show_indent`          | Boolean          | Whether to visually indent nested calls.                                         |
| `show_depth`           | Boolean          | Displays the depth level of the method call.                                     |
| `max_display_depth`    | Integer          | Limits the display to a maximum depth of calls.                                  |
| `show_method_name`     | Boolean          | Shows the name of the method being called.                                       |
| `show_source_location` | Boolean          | Logs the source file name and line number where the method is defined.           |
| `show_params`          | Boolean          | Logs the parameters passed to the method.                                        |
| `show_return_value`    | Boolean          | Logs the return value of the method.                                             |
| `show_execution_time`  | Boolean          | Logs the execution time for methods.                                             |
| `show_trace_events`    | Array of Symbols | Specifies the events to trace. Valid values include:                             |
|                        |                  | - `:call` - Log method calls.                                                    |
|                        |                  | - `:return` - Log method returns.                                                |

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

You can use `irb` or `pry` to test the gem locally. Make your changes, add tests, and ensure all tests pass before submitting a pull request.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/patrick204nqh/trace_viz. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/patrick204nqh/trace_viz/blob/main/CODE_OF_CONDUCT.md).

## License

TraceViz is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Acknowledgements

Special thanks to the Ruby community for their continued support and inspiration!
