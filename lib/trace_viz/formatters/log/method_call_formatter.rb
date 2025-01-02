# frozen_string_literal: true

require_relative "verbose_formatter"

module TraceViz
  module Formatters
    module Log
      class MethodCallFormatter < VerboseFormatter
        include Helpers::Log::ParamsHelper
        include Helpers::Log::ResultHelper

        def call(trace_data)
          [
            indent_representation(trace_data),
            format_depth(trace_data, config),
            format_method_name(trace_data, config),
            colorize(source_location_representation(trace_data), :trace_source_location),
            format_params(trace_data, config),
            format_result(trace_data, config),
            colorize(execution_time_representation(trace_data), :trace_execution_time),
          ].compact.join(" ")
        end

        private

        def format_result(trace_data, config)
          return unless trace_data.method_return

          super(trace_data.method_return, config)
        end
      end
    end
  end
end
