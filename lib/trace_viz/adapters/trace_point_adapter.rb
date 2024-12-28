# frozen_string_literal: true

require "trace_viz/adapters/base_adapter"
require "trace_viz/collectors/trace_point_collector"
require "trace_viz/exporters/text_exporter"
require "trace_viz/loggers/collection_trace_logger"

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
        log_collection
        export_collection
      end

      private

      attr_reader :collector

      def log_collection
        Loggers::CollectionTraceLogger.log(collector)
      end

      def export_collection
        exporter = Exporters::Registry.build(config.export[:format], collector)
        exporter.export
      end
    end
  end
end
