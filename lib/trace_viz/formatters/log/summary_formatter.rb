# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Formatters
    module Log
      class SummaryFormatter < BaseFormatter
        include Helpers::Log::DepthHelper
        include Helpers::Log::MethodNameHelper

        def call(trace_data)
          [
            indent_representation(trace_data),
            format_depth(trace_data, config),
            format_method_name(trace_data, config),
          ].compact.join(" ")
        end
      end
    end
  end
end
