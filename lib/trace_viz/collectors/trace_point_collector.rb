# frozen_string_literal: true

require "trace_viz/trace_data/trace_point_builder"
require "trace_viz/loggers/trace_logger"
require_relative "base_collector"

module TraceViz
  module Collectors
    class TracePointCollector < BaseCollector
      def collect(trace_point_event)
        trace_data = TraceData::TracePointBuilder.build(trace_point_event)

        return unless should_collect?(trace_data)

        Loggers::TraceLogger.log(trace_data)

        @collection << trace_data
      end
    end
  end
end
