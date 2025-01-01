# frozen_string_literal: true

require_relative "base_logger"
require_relative "trace_builder"

module TraceViz
  module Loggers
    class TraceStatsLogger < BaseLogger
      def initialize(collector)
        super()
        @collector = collector
        @stats = collector.stats
      end

      def log
        logger.stats(format_stats)
      end

      private

      attr_reader :stats

      def format_stats
        [
          total_traces_info,
          max_depth_info,
          event_counts_info,
        ].join(" | ")
      end

      def total_traces_info
        "Total Traces: #{stats.total_traces}"
      end

      def max_depth_info
        "Max Depth: #{stats.max_depth}"
      end

      def event_counts_info
        "Event Counts: [#{formatted_event_counts}]"
      end

      def formatted_event_counts
        stats.event_counts.map { |event, count| "#{event.capitalize}: #{count}" }.join(", ")
      end
    end
  end
end
