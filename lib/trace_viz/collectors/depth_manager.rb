# frozen_string_literal: true

module TraceViz
  module Collectors
    class DepthManager
      def initialize
        @config = Context.for(:config).configuration
        @tracker = Context.for(:tracking)
        @depth_tracker = tracker.depth
        @active_calls_tracker = tracker.active_calls
      end

      # Adjusts the depth based on the trace event type and assigns it to the trace data
      def adjust_for_event(trace_data)
        case trace_data.event
        when :call
          trace_data.depth = current
          active_calls_tracker.push(trace_data)
          depth_tracker.increment
        when :return
          active_calls_tracker.pop
          depth_tracker.decrement
          trace_data.depth = current
        end

        trace_data
      end

      def current
        depth_tracker.current || 0
      end

      def within_depth?
        current <= config.max_display_depth
      end

      def current_call
        active_calls_tracker.current
      end

      private

      attr_reader :config, :tracker, :depth_tracker, :active_calls_tracker
    end
  end
end
