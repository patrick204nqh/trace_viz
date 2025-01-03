# frozen_string_literal: true

module TraceViz
  module Renderers
    class RenderContext
      attr_reader :formatter_factory, :group_keys

      def initialize(formatter_factory:, group_keys: [])
        @formatter_factory = formatter_factory
        @group_keys = group_keys
      end

      def fetch_formatter(key)
        formatter_factory.fetch_formatter(key)
      end
    end
  end
end
