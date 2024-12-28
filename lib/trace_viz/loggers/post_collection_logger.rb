# frozen_string_literal: true

require_relative "base_logger"
require_relative "trace_logger"

module TraceViz
  module Loggers
    class PostCollectionLogger < BaseLogger
      def initialize(collector)
        super()
        @collector = collector
      end

      def log
        collection.each do |trace_data|
          log_trace(trace_data)
        end
      end

      private

      attr_reader :collector

      def collection
        collector.collection
      end

      def log_trace(trace_data)
        TraceLogger.log(trace_data)
      end
    end
  end
end
