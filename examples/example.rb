$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "trace_viz"

class Calculator
  def initialize(factor)
    @factor = factor
  end

  # A method that triggers a chain of calculations
  def calculate_chain(a, b)
    sum = add(a, b)
    scaled = scale(sum)
    complex_operation(scaled)
  end

  # Basic addition
  def add(x, y)
    sleep(0.05)
    x + y
  end

  # Scaling a number by the factor
  def scale(value)
    sleep(0.05)
    value * @factor
  end

  # Complex operation involving another class
  def complex_operation(value)
    sleep(0.05)
    Logger.new.log("Starting complex operation")
    divider = Divider.new
    divider.divide_and_process(value, 2)
  end
end

class Divider
  # Divides a number and calls a nested method
  def divide_and_process(value, divisor)
    result = divide(value, divisor)
    process_divided_result(result)
  end

  # Performs division
  def divide(a, b)
    raise "Division by zero!" if b.zero?

    sleep(0.05)
    a / b
  end

  # Processes the divided result further
  def process_divided_result(value)
    Logger.new.log("Processing divided result: #{value}")
    nested_process(value)
  end

  # A nested operation
  def nested_process(value)
    sleep(0.05)
    Logger.new.log("Final nested processing on #{value}")
    value + 10
  end
end

class Logger
  def log(message)
    sleep(0.01)
    puts "[LOG] #{message}"
  end
end

TraceViz.trace(
  general: {
    tab_size: 4,
    show_indent: true,
    show_depth: true,
    max_display_depth: 10,
    show_method_name: true,
  },
  params: {
    show: true,
    mode: :name_and_value,
    truncate_values: 10,
  },
  result: {
    show: true,
    truncate_length: 5,
  },
  source_location: {
    show: true,
    truncate_length: 20,
  },
  execution: {
    show_time: true,
    show_trace_events: [:call, :return],
  },
  filters: [
    :exclude_internal_call,
    include_classes: {
      classes: [Calculator, Divider, Logger],
    }
  ],
  export: {
    enabled: true,
    format: :yaml,
    overwrite: true
  }
) do
  calculator = Calculator.new(3)
  result = calculator.calculate_chain(10, 20)
  puts "Final result: #{result}"
end
