# frozen_string_literal: true

require "trace_viz/trace_data/summary_node"
require_relative "base_transformer"

module TraceViz
  module Transformers
    class SummaryTransformer < BaseTransformer
      def transform
        return [] unless valid_children?(root_node)

        transform_nodes(root_node.children)
      end

      private

      def valid_children?(node)
        node.respond_to?(:children) && node.children.any?
      end

      def root_node
        collector.hierarchy.root
      end

      def transform_nodes(nodes)
        nodes.group_by { |node| node_key(node) }
          .map { |_key, group| transform_group(group) }
      end

      def node_key(node)
        group_keys.map { |key| fetch_node_attribute(node, key) }
      end

      def fetch_node_attribute(node, key)
        node.respond_to?(key) ? node.public_send(key) : nil
      end

      def transform_group(group)
        if group.size > 1
          create_summary_node(group)
        else
          create_single_node(group.first)
        end
      end

      def create_summary_node(group)
        summary_node = TraceData::SummaryNode.new(group: group)

        {
          data: summary_node,
          children: transform_nodes(summary_node.children || []),
        }
      end

      def create_single_node(node)
        {
          data: node,
          children: transform_nodes(node.children || []),
        }
      end

      def group_keys
        fetch_general_config(:group_keys)
      end
    end
  end
end
