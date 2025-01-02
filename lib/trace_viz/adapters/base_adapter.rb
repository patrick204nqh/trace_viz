# frozen_string_literal: true

require "trace_viz/helpers"
require "trace_viz/loggers/logging_manager"
require "trace_viz/exporters/export_manager"

module TraceViz
  module Adapters
    class BaseAdapter
      include Helpers::ConfigHelper

      def initialize
        @logger = Loggers::LoggingManager.new
        @exporter = Exporters::ExportManager.new
      end

      def trace(&block)
        execute_trace(&block)
      ensure
        logger.log_post_collection(collector)
        logger.log_stats(collector)
        exporter.export(collector)
      end

      private

      attr_reader :logger, :exporter, :collector

      def execute_trace
        raise NotImplementedError
      end
    end
  end
end
