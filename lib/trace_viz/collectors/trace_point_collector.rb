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
        @filters = Collectors::Filters::Registry.build(config.filters)
      end

      def collect(trace_point_event)
        trace_data = TraceData::TracePointBuilder.build(trace_point_event)

        return unless filters_apply?(trace_data)

        Loggers::TraceLogger.log(trace_data)

        @collected_data << trace_data
      end

      private

      attr_reader :filters

      def filters_apply?(trace_data)
        filters.all? { |filter| filter.apply?(trace_data) }
      end
    end
  end
end
