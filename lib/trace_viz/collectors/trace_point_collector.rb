# frozen_string_literal: true

require "trace_viz/trace_data/trace_point_builder"
require "trace_viz/loggers/trace_logger"
require_relative "base_collector"

module TraceViz
  module Collectors
    class TracePointCollector < BaseCollector
      def collect(trace_point)
        return unless should_collect?(trace_point)

        trace_data = build_trace(trace_point)

        return unless eligible_for_collection?(trace_data)

        trace_data = manage_depth(trace_data)

        log_trace(trace_data)
        store_trace(trace_data)
      end

      private

      def should_collect?(trace_point)
        depth_manager.within_depth? || current_call_return?(trace_point)
      end

      # Checks if the given trace_point corresponds to the return event
      # of the currently tracked method call in depth_manager.
      def current_call_return?(trace_point)
        trace_point.event == :return &&
          depth_manager.current_call&.id == trace_point.object_id
      end

      def build_trace(trace_point)
        TraceData::TracePointBuilder.build(trace_point)
      end

      def eligible_for_collection?(trace_data)
        policy_evaluator.eligible_for_collection?(trace_data)
      end

      def manage_depth(trace_data)
        depth_manager.adjust_for_event(trace_data)
      end
    end
  end
end
