# frozen_string_literal: true

require_relative "base_logger"
require_relative "trace_logger"
require_relative "trace_stats_logger"

module TraceViz
  module Loggers
    class CollectionTraceLogger < BaseLogger
      def initialize(collector)
        super()
        @collector = collector
      end

      def log
        collection.each do |trace_data|
          log_trace(trace_data)
        end
        log_stats
      end

      private

      attr_reader :collector

      def collection
        collector.collection
      end

      def log_trace(trace_data)
        TraceLogger.log(trace_data)
      end

      def log_stats
        TraceStatsLogger.log(collector)
      end
    end
  end
end
