# frozen_string_literal: true

require "trace_viz/renderers/renderer_factory"
require "trace_viz/renderers/render_context"
require "trace_viz/formatters/export/formatter_factory"
require "trace_viz/formatters/log/formatter_factory"

module TraceViz
  module Shared
    module RendererHelper
      def build_renderer(collector, formatter_factory)
        raise ArgumentError, "Collector cannot be nil" unless collector
        raise ArgumentError, "FormatterFactory cannot be nil" unless formatter_factory

        mode = collector.config.general[:mode] do
          raise KeyError, "Missing mode"
        end

        context = Renderers::RenderContext.new(formatter_factory: formatter_factory)
        Renderers::RendererFactory.build(mode, collector, context: context)
      end

      def process_lines(lines, &block)
        return [] unless lines.is_a?(Array)

        lines.map do |line|
          validate_line_structure!(line)
          block.call(line)
        end.compact
      end

      private

      def validate_line_structure!(line)
        raise ArgumentError, "Line must be a Hash" unless line.is_a?(Hash)
        raise KeyError, "Line must include a :line key" unless line.key?(:line)
      end
    end
  end
end
