# frozen_string_literal: true

require_relative "../verbose_formatter"

module TraceViz
  module Formatters
    module Log
      module Verbose
        class MethodReturnFormatter < VerboseFormatter
          include Helpers::Log::Verbose::ResultHelper

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
end
