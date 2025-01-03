# frozen_string_literal: true

require_relative "base_renderer"
require_relative "summary/node_processor"

module TraceViz
  module Renderers
    class SummaryRenderer < BaseRenderer
      def to_lines
        return [] unless valid_children?(data)

        NodeProcessor.new(data.children, context).process
      end

      private

      def valid_children?(node)
        node.respond_to?(:children) && node.children.any?
      end
    end
  end
end
