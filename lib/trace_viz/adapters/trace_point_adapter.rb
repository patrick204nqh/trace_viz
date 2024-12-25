# frozen_string_literal: true

require "trace_viz/adapters/base_adapter"
require "trace_viz/collectors/trace_point_collector"
require "trace_viz/exporters/text_exporter"
require "trace_viz/loggers/trace_stats_logger"

module TraceViz
  module Adapters
    class TracePointAdapter < BaseAdapter
      def initialize
        super()

        @collector = Collectors::TracePointCollector.new
      end

      def trace(&block)
        ::TracePoint.new(:call, :return) do |tp|
          collector.collect(tp)
        end.enable(&block)
      ensure
        Loggers::TraceStatsLogger.log(collector)
        Exporters::TextExporter.new(collector).export
      end

      private

      attr_reader :collector
    end
  end
end
