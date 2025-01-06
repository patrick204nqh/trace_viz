# frozen_string_literal: true

require "trace_viz/renderers/renderer_factory"
require "trace_viz/renderers/render_context"
require "trace_viz/formatters/export/formatter_factory"
require "trace_viz/formatters/log/formatter_factory"

module TraceViz
  module Shared
    module RendererHelper
      def build_renderer(collector, mode:, formatter_factory:)
        raise ArgumentError, "Collector cannot be nil" unless collector
        raise ArgumentError, "Mode cannot be nil" unless mode
        raise ArgumentError, "FormatterFactory cannot be nil" unless formatter_factory

        context = Renderers::RenderContext.new(
          formatter_factory: formatter_factory,
        )
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
        unless line.respond_to?(:line) && line.respond_to?(:data)
          raise ArgumentError,
            "Invalid line structure: #{line.inspect}. Expected an object with :line and :data attributes."
        end
      end
    end
  end
end
