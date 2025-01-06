# frozen_string_literal: true

module TraceViz
  module Renderers
    class RenderContext
      attr_reader :formatter_factory

      def initialize(formatter_factory:)
        @formatter_factory = formatter_factory
      end

      def fetch_formatter(key)
        formatter_factory.fetch_formatter(key)
      end
    end
  end
end
