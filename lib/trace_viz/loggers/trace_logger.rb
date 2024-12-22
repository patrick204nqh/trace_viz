# frozen_string_literal: true

require_relative "trace_builder"

module TraceViz
  module Loggers
    class TraceLogger
      LOG_LEVELS = {
        call: :start,
        return: :finish,
      }.freeze

      class << self
        def log(trace_data)
          new.log(trace_data)
        end
      end

      def initialize
        @logger = TraceViz.logger
      end

      def log(trace_data)
        formatted_message = build_log_message(trace_data)
        log_level = LOG_LEVELS[trace_data.event] || :info
        logger.send(log_level, formatted_message)
      end

      private

      attr_reader :logger

      def build_log_message(trace_data)
        Loggers::TraceBuilder.new(trace_data).build
      end
    end
  end
end
