# frozen_string_literal: true

require_relative "verbose_formatter"

module TraceViz
  module Formatters
    module Log
      class MethodReturnFormatter < VerboseFormatter
        include Helpers::Log::ResultHelper

        def call(trace_data)
          [
            indent_representation(trace_data),
            format_depth(trace_data, config),
            format_method_name(trace_data, config),
            format_result(trace_data, config),
            colorize_for(source_location_representation(trace_data), :trace_source_location),
            colorize_for(execution_time_representation(trace_data), :trace_execution_time),
          ].compact.join(" ")
        end
      end
    end
  end
end
