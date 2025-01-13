# frozen_string_literal: true

require_relative "base_logger"
require_relative "log_level_resolver"
require "trace_viz/formatters/log/formatter_factory"

module TraceViz
  module Loggers
    class TraceLogger < BaseLogger
      def initialize(trace_data)
        super()

        @trace_data = trace_data
        @formatter_factory = Formatters::Log::FormatterFactory.new
      end

      def log
        log_message(log_level, formatted_message)
      end

      private

      attr_reader :trace_data, :formatter_factory

      def log_level
        LogLevelResolver.resolve(trace_data)
      end

      def formatted_message
        formatter_factory.fetch_formatter(trace_data.key).call(trace_data)
      end
    end
  end
end
