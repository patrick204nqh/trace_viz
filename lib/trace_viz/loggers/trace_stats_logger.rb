# frozen_string_literal: true

require_relative "trace_builder"

module TraceViz
  module Loggers
    class TraceStatsLogger
      class << self
        def log(collector)
          new(collector).log
        end
      end

      def initialize(collector)
        @logger = TraceViz.logger
        @stats = collector.stats
      end

      def log
        logger.stats(formatted_stats)
      end

      private

      attr_reader :logger, :stats

      def formatted_stats
        event_counts = stats.event_counts.map { |event, count| "#{event.capitalize}: #{count}" }.join(", ")
        "Total Traces: #{stats.total_traces} | Max Depth: #{stats.max_depth} | Event Counts: [#{event_counts}]"
      end
    end
  end
end
