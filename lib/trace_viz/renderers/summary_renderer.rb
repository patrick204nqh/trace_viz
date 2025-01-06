# frozen_string_literal: true

require_relative "base_renderer"
require "trace_viz/transformers/summary_transformer"
require "trace_viz/trace_data/summary_node"

module TraceViz
  module Renderers
    class SummaryRenderer < BaseRenderer
      def to_lines
        render_nodes(data)
      end

      private

      def data
        Transformers::SummaryTransformer.new(collector).transform
      end

      def render_nodes(nodes)
        nodes.map { |node| render_node(node) }
      end

      def render_node(node)
        {
          data: node[:data],
          line: format_node(node[:data]),
          nested_lines: render_nodes(node[:children]),
        }
      end

      def format_node(data)
        if data.is_a?(TraceData::SummaryNode)
          fetch_formatter(:summary_group).call(data)
        else
          fetch_formatter(data.event).call(data)
        end
      end

      def fetch_formatter(key)
        context.fetch_formatter(key)
      end
    end
  end
end
