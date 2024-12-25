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
          new(trace_data).log
        end
      end

      def initialize(trace_data)
        @logger = TraceViz.logger
        @trace_data = trace_data
      end

      def log
        log_level = LOG_LEVELS[trace_data.event] || :info
        logger.send(log_level, formatted_message)
      end

      private

      attr_reader :logger, :trace_data

      def formatted_message
        Loggers::TraceBuilder.new(trace_data).build
      end
    end
  end
end
