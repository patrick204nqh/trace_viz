# frozen_string_literal: true

module TraceViz
  module Collectors
    class TraceStats
      attr_reader :total_traces, :max_depth, :event_counts

      def initialize
        @total_traces = 0
        @max_depth = 0
        @event_counts = Hash.new(0)
      end

      def update(trace_data)
        @total_traces += 1
        @max_depth = [@max_depth, trace_data.depth].max
        @event_counts[trace_data.event] += 1
      end
    end
  end
end
