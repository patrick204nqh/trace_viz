# frozen_string_literal: true

require "trace_viz/formatters/log/formatter_factory"
require "trace_viz/trace_data/summary_node"

module TraceViz
  module Renderers
    class NodeFormatter
      class << self
        def format_node(node)
          fetch_formatter(node.event).call(node)
        end

        def format_group_line(group)
          node = TraceData::SummaryNode.new(group: group)
          fetch_formatter(:summary_group).call(node)
        end

        private

        def fetch_formatter(key)
          Formatters::Log::FormatterFactory.fetch_formatter(key)
        end
      end
    end
  end
end
