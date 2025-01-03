# frozen_string_literal: true

require_relative "node_formatter"

module TraceViz
  module Renderers
    class NodeProcessor
      def initialize(nodes)
        @nodes = nodes
      end

      def process
        grouped_nodes.flat_map { |key, group| render_node_or_group(key, group) }
      end

      private

      attr_reader :nodes

      def grouped_nodes
        nodes.group_by { |node| node_key(node) }
      end

      def node_key(node)
        [node.event, node.klass, node.action]
      end

      def render_node_or_group(key, group)
        if group.size > 1
          render_group(key, group)
        else
          render_single_node(group.first)
        end
      end

      def render_group(key, group)
        representative_node = group.first
        nested_lines = process_nested_nodes(representative_node)

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
          nested_lines: process_nested_nodes(node),
        }

        [current_line]
      end

      def process_nested_nodes(node)
        return [] unless node.respond_to?(:children) && node.children.any?

        NodeProcessor.new(node.children).process
      end
    end
  end
end
