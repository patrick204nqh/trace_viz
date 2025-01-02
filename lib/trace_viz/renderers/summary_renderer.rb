# frozen_string_literal: true

require_relative "base_renderer"

module TraceViz
  module Renderers
    class SummaryRenderer < BaseRenderer
      def to_lines
        return [] unless children_present?(data)

        summarize_nodes(data.children)
      end

      private

      def children_present?(node)
        node.respond_to?(:children) && node.children.any?
      end

      def summarize_nodes(nodes)
        grouped_nodes = group_similar_nodes(nodes)

        grouped_nodes.flat_map do |key, group|
          if group.size > 1
            summarize_group(key, group)
          else
            single_node_to_line(group.first)
          end
        end
      end

      def group_similar_nodes(nodes)
        nodes.group_by { |node| group_key(node) }
      end

      def group_key(node)
        [node.event, node.action]
      end

      def summarize_group(key, group)
        representative_node = group.first
        nested_lines = summarize_nodes(group.flat_map(&:children))

        [
          {
            line: format_summary_line(representative_node, group.size),
            trace_data: representative_node,
            nested_lines: nested_lines,
          },
        ]
      end

      def format_summary_line(node, count)
        Formatters::Log::FormatterFactory.fetch_formatter(:summary).call(node)
      end

      def single_node_to_line(node)
        current_line = {
          line: format_for(node),
          trace_data: node,
        }
        nested_lines = children_present?(node) ? summarize_nodes(node.children) : []
        [current_line] + nested_lines
      end

      def format_for(trace_data)
        fetch_formatter(trace_data).call(trace_data)
      end

      def fetch_formatter(trace_data)
        Formatters::Log::FormatterFactory.fetch_formatter(trace_data.event)
      end
    end
  end
end
