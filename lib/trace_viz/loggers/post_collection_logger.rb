# frozen_string_literal: true

require "trace_viz/formatters/log/formatter_factory"
require "trace_viz/shared"
require_relative "base_logger"
require_relative "log_level_resolver"

module TraceViz
  module Loggers
    class PostCollectionLogger < BaseLogger
      include Shared::RendererHelper

      def initialize(collector)
        super()

        @collector = collector
        @renderer = build_renderer(collector, Formatters::Log::FormatterFactory)
      end

      def log
        process_lines(renderer.to_lines) { |line| log_line(line) }
      end

      private

      attr_reader :collector, :renderer

      def log_line(line)
        log_message(resolve_log_level(line[:trace_data]), line[:line])

        process_lines(line[:nested_lines]) { |nested| log_line(nested) }
      end

      def resolve_log_level(trace_data)
        LogLevelResolver.resolve(trace_data)
      end
    end
  end
end
