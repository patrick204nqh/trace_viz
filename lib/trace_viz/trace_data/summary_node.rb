# frozen_string_literal: true

require_relative "node"

module TraceViz
  module TraceData
    class SummaryNode < Node
      attr_reader :group, :count, :representative_node, :event, :klass, :action, :params

      def initialize(group:)
        super()

        @group = group
        @count = group.size

        @representative_node = group.first
        @depth = representative_node.depth
        @event = representative_node.event
        @klass = representative_node.klass
        @action = representative_node.action
        @params = representative_node.params

        add_children(representative_node.children)
      end

      def average_duration
        return 0 if count.zero?

        total_duration / count
      end

      def total_duration
        children.map(&:duration).sum
      end

      private

      def add_children(nodes)
        nodes.each do |node|
          add_child(node)
        end
      end
    end
  end
end
