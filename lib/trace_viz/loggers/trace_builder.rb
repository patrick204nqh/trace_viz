# frozen_string_literal: true

require "trace_viz/formatters/log/verbose/method_call_formatter"
require "trace_viz/formatters/log/verbose/method_return_formatter"

module TraceViz
  module Loggers
    class TraceBuilder
      FORMATTERS = {
        call: Formatters::Log::Verbose::MethodCallFormatter,
        return: Formatters::Log::Verbose::MethodReturnFormatter,
      }.freeze

      def initialize(trace_data)
        @trace_data = trace_data
      end

      def build
        formatter_class = FORMATTERS[trace_data.event]
        raise ArgumentError, "No formatter found for #{trace_data.event}" unless formatter_class

        formatter_class.new(trace_data).call
      end

      private

      attr_reader :trace_data
    end
  end
end
