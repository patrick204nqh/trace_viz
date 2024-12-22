# frozen_string_literal: true

require_relative "loggers/method_call_formatter"
require_relative "loggers/method_return_formatter"

module TraceViz
  module Formatters
    class LogBuilder
      FORMATTERS = {
        call: Loggers::MethodCallFormatter,
        return: Loggers::MethodReturnFormatter,
      }.freeze

      def initialize(trace_data)
        @trace_data = trace_data
      end

      def build
        formatter_class = FORMATTERS[trace_data.event]
        raise ArgumentError, "No formatter found for #{trace_data.event}" unless formatter_class

        formatter_class.new(trace_data).format
      end

      private

      attr_reader :trace_data
    end
  end
end