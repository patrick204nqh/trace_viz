# frozen_string_literal: true

require_relative "base_logger"
require_relative "log_level_resolver"
require "trace_viz/formatters/log/verbose/formatter_factory"

module TraceViz
  module Loggers
    class TraceLogger < BaseLogger
      def initialize(trace_data)
        super()

        @trace_data = trace_data
      end

      def log
        log_message(log_level, formatted_message)
      end

      private

      attr_reader :trace_data

      def log_level
        LogLevelResolver.resolve(trace_data)
      end

      def formatted_message
        formatter = FormatterFactory.fetch_formatter(trace_data.event)
        formatter.call(trace_data)
      end
    end
  end
end
