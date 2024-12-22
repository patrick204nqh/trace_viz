# frozen_string_literal: true

require "trace_viz/trace_data/trace_point_builder"
require "trace_viz/trace_logger"
require_relative "base_collector"
require_relative "filters/registry"

module TraceViz
  module Collectors
    class TracePointCollector < BaseCollector
      def initialize(filters = [], sanitizers = [])
        super()
        @filters = Collectors::Filters::Registry.build(config.filters)
        # @sanitizers = sanitizers
      end

      def collect(trace_point_event)
        trace_data = TraceData::TracePointBuilder.build(trace_point_event)

        # Apply filters
        return unless @filters.all? { |filter| filter.apply?(trace_data) }

        # Apply sanitizers
        # @sanitizers.each { |sanitizer| sanitizer.apply(trace_data) }

        TraceLogger.log(trace_data)

        @collected_data << trace_data
      end
    end
  end
end
