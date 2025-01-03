# frozen_string_literal: true

require_relative "base_logger"
require_relative "log_level_resolver"
require "trace_viz/renderers/renderer_factory"

module TraceViz
  module Loggers
    class PostCollectionLogger < BaseLogger
      def initialize(collector)
        super()

        @collector = collector
        @renderer = build_renderer
      end

      def log
        process_lines(renderer.to_lines)
      end

      private

      attr_reader :collector, :renderer

      def process_lines(lines)
        lines.each do |line|
          log_line(line)
        end
      end

      def log_line(line)
        log_level = resolve_log_level(line[:trace_data])
        formatted_message = line[:line]

        log_message(log_level, formatted_message)

        process_lines(line[:nested_lines]) if line[:nested_lines]&.any?
      end

      def resolve_log_level(trace_data)
        LogLevelResolver.resolve(trace_data)
      end

      def build_renderer
        mode = collector.config.log[:post_collection_mode]

        Renderers::RendererFactory.build(mode, collector)
      end
    end
  end
end
