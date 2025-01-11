# frozen_string_literal: true

require_relative "base_renderer"
require "trace_viz/transformers/summary_transformer"

module TraceViz
  module Renderers
    class SummaryRenderer < BaseRenderer
      def to_lines
        render_nodes(data.children)
      end

      private

      def data
        Transformers::SummaryTransformer.new(collector).transform
      end

      def render_nodes(nodes)
        nodes.flat_map { |node| render_node(node) }
      end

      def render_node(node)
        node_line = NodeLine.new(node.data, format_node(node.data))

        [node_line] + render_nodes(node.children)
      end

      def format_node(data)
        context.fetch_formatter(data.key).call(data)
      end
    end
  end
end
