# frozen_string_literal: true

require "trace_viz/helpers"
require "trace_viz/loggers/logging_manager"
require_relative "hierarchy_linker"
require_relative "trace_stats"
require_relative "trace_pipeline_builder"

module TraceViz
  module Collectors
    class BaseCollector
      include Helpers::ConfigHelper
      include Helpers::TrackingHelper

      attr_reader :collection, :stats, :hierarchy

      # To implement collect trace data from the given event,
      # you need to enter the `config` context to perform the evaluation.
      def initialize
        setup_logger
        setup_stats
        setup_pipeline
        setup_hierarchy
        clear
      end

      def collect(event)
        return unless can_collect?(event)

        trace_data = build_trace(event)
        processed_data = process_trace(trace_data)

        return unless processed_data

        store_trace(processed_data)
        link_to_hierarchy(processed_data)
      end

      def clear
        @collection = []
      end

      private

      attr_reader :logger, :pipeline

      def setup_logger
        @logger = Loggers::LoggingManager.new
      end

      def setup_stats
        @stats = TraceStats.new
      end

      def setup_pipeline
        @pipeline = TracePipelineBuilder.build
      end

      def setup_hierarchy
        @hierarchy = TraceData::HierarchyLinker.new
      end

      def process_trace(trace_data)
        pipeline.process(trace_data)
      end

      # Base on trace-event for specific adapter
      def can_collect?(event)
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

      def link_to_hierarchy(trace_data)
        hierarchy.link(trace_data)
      end
    end
  end
end
