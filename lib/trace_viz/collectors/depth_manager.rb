# frozen_string_literal: true

module TraceViz
  module Collectors
    class DepthManager
      def initialize
        @config = Context.for(:config).configuration
        @tracker = Context.for(:tracking).depth
      end

      # Adjusts the depth based on the trace event type and assigns it to the trace data
      def adjust_for_event(trace_data)
        case trace_data.event
        when :call
          trace_data.depth = current
          increment
        when :return
          decrement
          trace_data.depth = current
        end
      end

      def current
        tracker.current || 0
      end

      def increment
        tracker.increment
      end

      def decrement
        tracker.decrement
      end

      def exceeded_max_depth?
        current >= config.max_display_depth
      end

      private

      attr_reader :config, :tracker
    end
  end
end
