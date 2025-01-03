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

        @renderer = build_renderer(collector, Formatters::Export::FormatterFactory)
      end

      private

      attr_reader :renderer

      def content
        data.join("\n")
      end

      def data
        process_lines(renderer.to_lines) { |line| process_line(line) }
      end

      def process_line(line)
        [
          line[:line],
          *process_lines(line[:nested_lines]) { |nested| process_line(nested) },
        ].compact
      end
    end
  end
end
