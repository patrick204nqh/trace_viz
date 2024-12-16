$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "trace_viz"

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
    show_params: true,
    show_return_value: true,
    show_execution_time: true,
    show_trace_events: [:call, :return]
) do
  example = Example.new
  example.perform_task(5, 7)
end