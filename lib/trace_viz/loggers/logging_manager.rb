# frozen_string_literal: true

require_relative "trace_logger"
require_relative "post_collection_logger"
require_relative "trace_stats_logger"

module TraceViz
  module Loggers
    class LoggingManager
      def initialize(config)
        @config = config
      end

      def log_runtime_trace(trace_data)
        return unless runtime_logging_enabled?

        TraceLogger.log(trace_data)
      end

      def log_stats(collector)
        return unless stats_logging_enabled?

        TraceStatsLogger.log(collector)
      end

      def log_post_collection(collector)
        return unless post_collection_logging_enabled?

        PostCollectionLogger.log(collector)
      end

      private

      attr_reader :config

      def runtime_logging_enabled?
        config.log[:enabled] && config.log[:runtime]
      end

      def post_collection_logging_enabled?
        config.log[:enabled] && config.log[:post_collection]
      end

      def stats_logging_enabled?
        config.log[:enabled] && config.log[:stats]
      end
    end
  end
end
