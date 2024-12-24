# frozen_string_literal: true

module TraceViz
  module Collectors
    class DepthManager
      def initialize
        @config = Context.for(:config).configuration
        @tracker = Context.for(:tracking)
      end

      # Adjusts the depth based on the trace event type and assigns it to the trace data
      def adjust_for_event(trace_data)
        case trace_data.event
        when :call
          trace_data.depth = current_depth
          tracker.active_calls.push(trace_data)
        when :return
          tracker.active_calls.pop
          trace_data.depth = current_depth
        end

        trace_data
      end

      def current_depth
        tracker.active_calls.size
      end

      def within_depth?
        current_depth <= config.general[:max_display_depth]
      end

      def current_call
        tracker.active_calls.current
      end

      private

      attr_reader :config, :tracker
    end
  end
end
