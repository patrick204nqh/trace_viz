# frozen_string_literal: true

require_relative "node_formatter"

module TraceViz
  module Renderers
    class NodeProcessor
      def initialize(nodes)
        @nodes = nodes
      end

      def process
        grouped_nodes.flat_map do |key, group|
          group.size > 1 ? render_group(key, group) : render_single_node(group.first)
        end
      end

      private

      def grouped_nodes
        @nodes.group_by { |node| node_key(node) }
      end

      def node_key(node)
        [node.event, node.klass, node.action]
      end

      def render_group(key, group)
        representative_node = group.first
        nested_lines = NodeProcessor.new(group.flat_map(&:children)).process

        [{
          line: NodeFormatter.format_group_line(group),
          trace_data: representative_node,
          nested_lines: nested_lines,
        }]
      end

      def render_single_node(node)
        current_line = {
          line: NodeFormatter.format_node(node),
          trace_data: node,
        }
        nested_lines = if node.respond_to?(:children) && node.children.any?
          NodeProcessor.new(node.children).process
        else
          []
        end

        [current_line] + nested_lines
      end
    end
  end
end
