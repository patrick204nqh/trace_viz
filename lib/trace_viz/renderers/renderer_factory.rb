# frozen_string_literal: true

require_relative "verbose_renderer"
require_relative "summary_renderer"
require_relative "mermaid/sequence_renderer"

module TraceViz
  module Renderers
    class RendererFactory
      RENDERERS = {
        verbose: VerboseRenderer,
        summary: SummaryRenderer,
        sequence_diagram: Mermaid::SequenceRenderer,
      }.freeze

      def initialize(collector, context)
        @collector = collector
        @context = context
      end

      def build(key)
        renderer_class = RENDERERS[key]
        raise ArgumentError, "Invalid renderer key: #{key}" unless renderer_class

        renderer_class.new(@collector, @context)
      end
    end
  end
end
