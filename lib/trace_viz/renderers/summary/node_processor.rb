# frozen_string_literal: true

require "trace_viz/trace_data/summary_node"

module TraceViz
  module Renderers
    class NodeProcessor
      def initialize(nodes, context)
        @nodes = nodes
        @context = context
      end

      def process
        grouped_nodes.flat_map { |key, group| render_node_or_group(key, group) }
      end

      private

      attr_reader :nodes, :context

      def grouped_nodes
        nodes.group_by { |node| node_key(node) }
      end

      def group_keys
        context.group_keys
      end

      def node_key(node)
        group_keys.map { |key| fetch_node_attribute(node, key) }
      end

      def fetch_node_attribute(node, key)
        node.respond_to?(key) ? node.public_send(key) : nil
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
          line: format_group_line(group),
          trace_data: representative_node,
          nested_lines: nested_lines,
        }]
      end

      def render_single_node(node)
        current_line = {
          line: format_node(node),
          trace_data: node,
          nested_lines: process_nested_nodes(node),
        }

        [current_line]
      end

      def process_nested_nodes(node)
        return [] unless node.respond_to?(:children) && node.children.any?

        NodeProcessor.new(node.children, context).process
      end

      def format_node(node)
        context.fetch_formatter(node.event).call(node)
      end

      def format_group_line(group)
        node = TraceData::SummaryNode.new(group: group)
        context.fetch_formatter(:summary_group).call(node)
      end
    end
  end
end
