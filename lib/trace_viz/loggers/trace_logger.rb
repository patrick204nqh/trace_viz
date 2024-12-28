# frozen_string_literal: true

require_relative "base_logger"
require_relative "trace_builder"

module TraceViz
  module Loggers
    class TraceLogger < BaseLogger
      LOG_LEVELS = {
        call: :start,
        return: :finish,
      }.freeze

      def initialize(trace_data)
        super()
        @trace_data = trace_data
      end

      def log
        log_level = LOG_LEVELS[trace_data.event] || :info
        logger.send(log_level, formatted_message)
      end

      private

      attr_reader :trace_data

      def formatted_message
        Loggers::TraceBuilder.new(trace_data).build
      end
    end
  end
end
