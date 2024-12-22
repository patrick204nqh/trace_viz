# frozen_string_literal: true

require "trace_viz/trace_data/trace_point_builder"
require "trace_viz/loggers/trace_logger"
require_relative "base_collector"
require_relative "filters/registry"

module TraceViz
  module Collectors
    class TracePointCollector < BaseCollector
      def initialize(filters = [], sanitizers = [])
        super()
        @filters = build_filters(config.filters)
      end

      def collect(trace_point_event)
        trace_data = TraceData::TracePointBuilder.build(trace_point_event)

        return unless should_collect?(trace_data)

        Loggers::TraceLogger.log(trace_data)

        @collected_data << trace_data
      end

      private

      attr_reader :filters

      def should_collect?(trace_data)
        filters_apply?(trace_data) && trace_event_allowed?(trace_data)
      end

      def filters_apply?(trace_data)
        filters.all? { |filter| filter.apply?(trace_data) }
      end

      def trace_event_allowed?(trace_data)
        config.show_trace_events.include?(trace_data.event)
      end

      def build_filters(filters)
        Collectors::Filters::Registry.build(filters)
      end
    end
  end
end
