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
        exporter.export
      end

      private

      attr_reader :collector

      def exporter
        Exporters::Registry.build(config.export[:format], collector)
      end
    end
  end
end
