# frozen_string_literal: true

require_relative "verbose_renderer"
require_relative "summary_renderer"

module TraceViz
  module Renderers
    class RendererFactory
      class << self
        def build(mode, collector)
          case mode
          when :verbose
            VerboseRenderer.new(collector.collection)
          when :summary
            SummaryRenderer.new(collector.hierarchy.root)
          else
            raise ArgumentError, "Unknown mode: #{mode}"
          end
        end
      end
    end
  end
end
