# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Exporters
    module Formatters
      class MethodCallFormatter < BaseFormatter
        def call(trace_data)
          [
            indent_representation(trace_data),
            depth_representation(trace_data),
            method_name_representation(trace_data),
            source_location_representation(trace_data),
            params_representation(trace_data),
          ].compact.join(" ")
        end
      end
    end
  end
end
