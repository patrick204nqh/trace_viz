# frozen_string_literal: true

require_relative "verbose_renderer"
require_relative "summary_renderer"

module TraceViz
  module Renderers
    class RendererFactory
      RENDERERS = {
        verbose: VerboseRenderer,
        summary: SummaryRenderer,
      }.freeze

      class << self
        def build(mode, collector, context:)
          renderer_class = fetch_renderer_class(mode)
          renderer_class.new(determine_input(mode, collector), context: context)
        end

        private

        def fetch_renderer_class(mode)
          RENDERERS.fetch(mode) do
            raise ArgumentError, "Unknown mode: #{mode}. Valid modes are: #{RENDERERS.keys.join(", ")}"
          end
        end

        def determine_input(mode, collector)
          case mode
          when :verbose
            collector.collection
          when :summary
            collector.hierarchy.root
          else
            raise ArgumentError, "Invalid mode for input determination: #{mode}"
          end
        end
      end
    end
  end
end
