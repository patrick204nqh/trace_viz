# frozen_string_literal: true

module TraceViz
  module Collectors
    class DepthManager
      def initialize
        @tracker = Context.for(:tracking)
      end

      def align(trace_data)
        case trace_data.event
        when :call
          push_to_call_stack(trace_data)
        when :return
          pop_from_call_stack(trace_data)
        end
        trace_data
      end

      private

      attr_reader :tracker

      # Increment the depth
      def push_to_call_stack(trace_data)
        trace_data.depth = tracker.current_depth
        tracker.active_calls.push(trace_data)
      end

      # Decrement the depth
      def pop_from_call_stack(trace_data)
        tracker.active_calls.pop
        trace_data.depth = tracker.current_depth
      end
    end
  end
end
