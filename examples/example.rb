$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "trace_viz"

class Example
  # Basic method with two parameters
  def perform_task(x, y)
    result = add_numbers(x, y)
    log_result(result)
    result
  end

  # Method with optional parameters
  def add_numbers(a, b = 0)
    sleep(0.1)
    sum = a + b
    multiply_by_factor(sum, 2)
  end

  def multiply_by_factor(value, factor)
    sleep(0.05)
    value * factor
  end

  # Method with splat arguments
  def sum_all(*args)
    sleep(0.05)
    args.sum
  end

  # Method with keyword arguments
  def configure(options = {})
    sleep(0.02)
    puts "Configured with: #{options.inspect}"
    options[:enabled] ? "Configured successfully" : "Configuration failed"
  end

  # Method with double-splat arguments
  def handle_kwargs(**kwargs)
    sleep(0.03)
    puts "Handling keyword arguments: #{kwargs.inspect}"
    kwargs.values.sum
  end

  # Method with both splat and double-splat arguments
  def combine_args(*args, **kwargs)
    sleep(0.04)
    puts "Positional arguments: #{args.inspect}"
    puts "Keyword arguments: #{kwargs.inspect}"
    args.sum + kwargs.values.sum
  end

  # Method that accepts and yields a block
  def with_block
    sleep(0.02)
    if block_given?
      yield("Block execution successful")
    else
      "No block provided"
    end
  end

  # Logging method for debugging
  def log_result(result)
    sleep(0.02)
    puts "Final result: #{result}"
  end

  # Method with error handling
  def divide(a, b)
    sleep(0.05)
    raise "Division by zero!" if b.zero?

    a / b
  end
end

TraceViz.trace(
  tab_size: 4,
  show_indent: true,
  show_depth: true,
  max_display_depth: 4,
  show_method_name: true,
  show_params: true,
  param_display_mode: :name_and_value,
  show_return_value: true,
  show_execution_time: true,
  show_source_location: true,
  show_trace_events: [:call, :return],
  filters: [
    :exclude_internal_call,
    :exclude_rails_framework,
    allow_classes: {
      classes: [Example]
    },
    # exclude_classes: {
    #   classes: [Example]
    # }
  ],
  export: {
    enabled: true,
    format: :txt,
    overwrite: true
  }
) do
  example = Example.new
  example.perform_task(5, 7)
  example.add_numbers(10)
  example.sum_all(1, 2, 3, 4, 5)
  example.configure(enabled: true, retries: 3)
  example.handle_kwargs(a: 10, b: 20, c: 30)
  example.combine_args(1, 2, 3, a: 10, b: 20)
  example.with_block { |message| puts message }
  begin
    example.divide(10, 0)
  rescue => e
    puts "Error: #{e.message}"
  end
end