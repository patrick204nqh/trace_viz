# frozen_string_literal: true

require_relative "base_formatter"
require_relative "helpers/result_helper"

module TraceViz
  module Loggers
    module TraceFormatters
      class MethodReturnFormatter < BaseFormatter
        include Helpers::ResultHelper

        def call
          [
            indent_representation,
            format_depth(trace_data, config),
            format_method_name(trace_data, config),
            format_result(trace_data, config),
            colorize(source_location_representation, :trace_source_location),
            colorize(execution_time_representation, :trace_execution_time),
          ].compact.join(" ")
        end
      end
    end
  end
end
