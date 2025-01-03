# frozen_string_literal: true

require_relative "base_exporter"
require "trace_viz/renderers/renderer_factory"
require "trace_viz/renderers/render_context"
require "trace_viz/formatters/export/formatter_factory"

module TraceViz
  module Exporters
    class TextExporter < BaseExporter
      def initialize(collector)
        super(collector)

        @renderer = build_renderer
      end

      private

      attr_reader :renderer

      def data
        process_lines(renderer.to_lines)
      end

      def content
        data.join("\n")
      end

      def process_lines(lines)
        return unless lines

        lines.map do |line|
          process_line(line)
        end
      end

      def process_line(line)
        [line[:line], process_lines(line[:nested_lines])].compact
      end

      def build_renderer
        mode = collector.config.log[:post_collection_mode]
        context = build_render_context

        Renderers::RendererFactory.build(
          mode,
          collector,
          context: context,
        )
      end

      def build_render_context
        Renderers::RenderContext.new(
          formatter_factory: Formatters::Export::FormatterFactory,
        )
      end
    end
  end
end
