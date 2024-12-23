# frozen_string_literal: true

require "trace_viz/trace_data/trace_point_builder"
require "trace_viz/loggers/trace_logger"
require_relative "base_collector"

module TraceViz
  module Collectors
    class TracePointCollector < BaseCollector
      def collect(trace_point)
        decrement_depth if trace_point.event == :return
        trace_data = build_trace_data(trace_point)
        increment_depth if trace_point.event == :call

        return unless should_collect?(trace_data)

        log_trace_data(trace_data)

        @collection << trace_data
      end

      private

      def build_trace_data(trace_point)
        TraceData::TracePointBuilder.build(trace_point)
      end

      def log_trace_data(trace_data)
        Loggers::TraceLogger.log(trace_data)
      end

      def depth_tracker
        @depth_tracker ||= Context.for(:tracking).depth
      end

      def increment_depth
        depth_tracker.increment
      end

      def decrement_depth
        depth_tracker.decrement
      end
    end
  end
end
