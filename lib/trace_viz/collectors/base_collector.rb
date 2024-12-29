# frozen_string_literal: true

require "trace_viz/context"
require "trace_viz/loggers/logging_manager"
require_relative "trace_stats"
require_relative "trace_pipeline_builder"

module TraceViz
  module Collectors
    class BaseCollector
      attr_reader :collection, :stats

      # To implement collect trace data from the given event,
      # you need to enter the `config` context to perform the evaluation.
      def initialize
        setup_context
        setup_pipeline
        reset_collection
      end

      def collect(event)
        return unless collectible?(event)

        trace_data = build_trace(event)
        processed_data = process_trace_data(trace_data)

        return unless processed_data

        store_trace(processed_data)
      end

      def clear
        reset_collection
      end

      private

      attr_reader :config,
        :tracker,
        :logger,
        :pipeline

      def setup_context
        @config = Context.for(:config).configuration
        @tracker = Context.for(:tracking)
        @logger = Loggers::LoggingManager.new(config)
        @stats = TraceStats.new
      end

      def setup_pipeline
        @pipeline = TracePipelineBuilder.build
      end

      def reset_collection
        @collection = []
      end

      def process_trace_data(trace_data)
        pipeline.process(trace_data)
      end

      # Base on trace-event for specific adapter
      def collectible?(event)
        raise NotImplementedError
      end

      # Builds trace data from the trace-event for specific adapter
      def build_trace(event)
        raise NotImplementedError
      end

      def store_trace(trace_data)
        logger.log_runtime_trace(trace_data)
        stats.update(trace_data)

        @collection << trace_data
      end
    end
  end
end
