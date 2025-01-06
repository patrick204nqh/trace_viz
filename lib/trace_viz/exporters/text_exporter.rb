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

        @formatter_factory = Formatters::Export::FormatterFactory.new
        @renderer = build_renderer(
          collector,
          mode: fetch_general_config(:mode),
          formatter_factory: @formatter_factory,
        )
      end

      private

      attr_reader :renderer

      def content
        data.join("\n")
      end

      def data
        process_lines(renderer.to_lines) { |line| line[:line] }
      end
    end
  end
end
