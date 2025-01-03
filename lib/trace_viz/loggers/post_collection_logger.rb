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
        @renderer = build_renderer(collector)
      end

      def log
        renderer.to_lines.each do |line|
          log_line(line)
        end
      end

      private

      attr_reader :collector, :renderer

      def log_line(line)
        log_level = LogLevelResolver.resolve(line[:trace_data])
        formatted_message = line[:line]

        log_message(log_level, formatted_message)
      end

      def build_renderer(collector)
        mode = collector.config.log[:post_collection_mode]

        Renderers::RendererFactory.build(mode, collector)
      end
    end
  end
end
