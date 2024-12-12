# frozen_string_literal: true

module TraceViz
  module Adapters
    module TracePoint
      class TraceFormatter
        def initialize(trace_data)
          @trace_data = trace_data
        end

        def format_call
          "#{indent}#{depth_str} > #{method_name} at #{path}:#{line_number} #{params_str}"
        end

        def format_return
          "#{indent}#{depth_str} < #{method_name}#{result_str} at #{path}:#{line_number}#{execution_time}"
        end

        private

        def method_name
          "#{@trace_data.klass}##{@trace_data.id}"
        end

        def path
          @trace_data.path
        end

        def line_number
          @trace_data.line_number
        end

        def params_str
          param_values = @trace_data.params.map do |var|
            @trace_data.trace_point.binding.local_variable_get(var).inspect
          end.join(", ")
          "(#{param_values})"
        end

        def result_str
          " #=> #{@trace_data.result.inspect}"
        end

        def execution_time
          @trace_data.duration ? " in #{@trace_data.duration}ms" : ""
        end

        def indent
          "  " * @trace_data.depth
        end

        def depth_str
          "#depth:#{@trace_data.depth}"
        end
      end
    end
  end
end
