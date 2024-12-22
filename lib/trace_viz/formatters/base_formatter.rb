# frozen_string_literal: true

require "trace_viz/utils/colorize"

module TraceViz
  module Formatters
    class BaseFormatter
      def initialize(trace_data)
        @trace_data = trace_data
        @config = @trace_data.config
      end

      def format_for_log
        raise NotImplementedError
      end

      private

      attr_reader :trace_data, :config

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
        return unless config.show_params

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

      def colorize(text, color_key)
        Utils::Colorize.colorize(text, color_key)
      end
    end
  end
end
