# frozen_string_literal: true

require_relative "render_context"
require_relative "renderer_factory"

module TraceViz
  module Renderers
    class RendererBuilder
      class << self
        def build(collector, key:, formatter_factory:)
          raise ArgumentError, "Renderer key must be provided" if key.nil?

          render_context = RenderContext.new(formatter_factory: formatter_factory)
          renderer_factory = RendererFactory.new(collector, render_context)
          renderer_factory.build(key)
        end
      end
    end
  end
end
