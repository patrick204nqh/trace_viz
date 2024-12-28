# frozen_string_literal: true

require_relative "trace_linker"

module TraceViz
  module Collectors
    class DepthManager
      def initialize
        @tracker = Context.for(:tracking)
        @trace_linker = TraceLinker.new
      end

      def align(trace_data)
        assign_depth(trace_data)
        trace_data
      end

      private

      attr_reader :tracker, :trace_linker

      def assign_depth(trace_data)
        case trace_data.event
        when :call
          push_to_call_stack(trace_data)
        when :return
          link_trace(trace_data)
          pop_from_call_stack(trace_data)
        end
      end

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

      def link_trace(trace_data)
        trace_linker.link_return_to_call(trace_data, tracker.active_calls.current)
      end
    end
  end
end
