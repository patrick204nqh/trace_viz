# frozen_string_literal: true

require "trace_viz/trace_data/trace_point_builder"
require "trace_viz/loggers/trace_logger"
require_relative "base_collector"

module TraceViz
  module Collectors
    class TracePointCollector < BaseCollector
      def collect(trace_point)
        return if depth_manager.exceeded_max_depth?

        trace_data = build_trace_data(trace_point)
        depth_manager.adjust_for_event(trace_data)
        return unless policy_evaluator.eligible_for_collection?(trace_data)

        log_trace_data(trace_data)
        store_trace_data(trace_data)
      end

      private

      def build_trace_data(trace_point)
        TraceData::TracePointBuilder.build(trace_point)
      end

      def log_trace_data(trace_data)
        Loggers::TraceLogger.log(trace_data)
      end

      def store_trace_data(trace_data)
        @collection << trace_data
      end
    end
  end
end
