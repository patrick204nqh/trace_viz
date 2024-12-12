# frozen_string_literal: true

module TraceViz
  module Adapters
    module TracePoint
      class TraceFormatter
        def initialize(trace_data)
          @trace_data = trace_data
          @config = TraceViz.configuration
          @logger = TraceViz.logger
        end

        def format_call
          return "" if trace_data.exceeded_max_depth?

          [
            indent_if_enabled,
            depth_if_enabled,
            method_name_if_enabled,
            source_location_if_enabled,
            params_if_enabled,
          ].compact.join(" ")
        end

        def format_return
          return "" if trace_data.exceeded_max_depth?

          [
            indent_if_enabled,
            depth_if_enabled,
            method_name_if_enabled,
            result_if_enabled,
            source_location_if_enabled,
            execution_time_if_enabled,
          ].compact.join(" ")
        end

        private

        attr_reader :trace_data, :config, :logger

        def indent_if_enabled
          return unless config.show_indent && config.show_depth

          " " * (config.tab_size * trace_data.depth)
        end

        def depth_if_enabled
          return unless config.show_depth

          "#depth:#{trace_data.depth}"
        end

        def method_name_if_enabled
          return unless config.show_method_name

          "#{trace_data.klass}##{trace_data.id}"
        end

        def source_location_if_enabled
          return unless config.show_source_location

          "at #{trace_data.path}:#{trace_data.line_number}"
        end

        def params_if_enabled
          return unless config.show_parameters

          param_values = trace_data.params.map do |var|
            trace_data.trace_point.binding.local_variable_get(var).inspect
          end.join(", ")
          "(#{param_values})"
        end

        def result_if_enabled
          return unless config.show_return_value

          "#=> #{trace_data.result.inspect}"
        end

        def execution_time_if_enabled
          return unless config.show_execution_time && trace_data.duration

          "in #{trace_data.duration}ms"
        end
      end
    end
  end
end
